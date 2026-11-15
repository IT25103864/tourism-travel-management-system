package com.pearltrails.pearltrails.controller;

import com.pearltrails.pearltrails.model.Booking;
import com.pearltrails.pearltrails.model.Listing;
import com.pearltrails.pearltrails.model.Payment;
import com.pearltrails.pearltrails.model.TransportBooking;
import com.pearltrails.pearltrails.model.User;
import com.pearltrails.pearltrails.repository.BookingRepository;
import com.pearltrails.pearltrails.repository.ListingRepository;
import com.pearltrails.pearltrails.repository.PaymentRepository;
import com.pearltrails.pearltrails.repository.TransportBookingRepository;
import com.pearltrails.pearltrails.repository.UserRepository;
import com.pearltrails.pearltrails.service.EmailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Controller
public class BookingController {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private ListingRepository listingRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TransportBookingRepository transportBookingRepository;

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private EmailService emailService;

    @GetMapping("/book")
    public String showBookingForm(@RequestParam("listingId") Integer listingId, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Listing listing = listingRepository.findById(listingId).orElse(null);
        if (listing == null) {
            return "redirect:/?error=not_found";
        }

        model.addAttribute("listing", listing);
        return "book_listing";
    }

    @PostMapping("/book")
    public String saveBooking(@RequestParam("listingId") Integer listingId,
                              @RequestParam("checkInDate") @org.springframework.format.annotation.DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkInDate,
                              @RequestParam("checkOutDate") @org.springframework.format.annotation.DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkOutDate,
                              @RequestParam("roomType") String roomType,
                              @RequestParam("roomCount") Integer roomCount,
                              @RequestParam("guestCount") Integer guestCount,
                              HttpSession session) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        if (checkOutDate.isBefore(checkInDate) || checkOutDate.isEqual(checkInDate)) {
            return "redirect:/book?listingId=" + listingId + "&error=invalid_dates";
        }

        Listing listing = listingRepository.findById(listingId).orElse(null);
        if (listing == null) {
            return "redirect:/?error=listing_not_found";
        }

        Booking booking = new Booking();
        booking.setListing(listing);
        booking.setTourist(loggedInUser);
        booking.setCheckInDate(checkInDate);
        booking.setCheckOutDate(checkOutDate);
        booking.setRoomType(roomType);
        booking.setRoomCount(roomCount);
        booking.setGuestCount(guestCount);
        booking.setStatus("Confirmed");

        long days = ChronoUnit.DAYS.between(checkInDate, checkOutDate);
        if (days <= 0) {
            days = 1;
        }
        double total = listing.getPrice() * days * roomCount;
        booking.setTotalAmount(total);

        Booking savedBooking = bookingRepository.save(booking);

        try {
            String customerEmail = loggedInUser.getEmail();
            String subject = "Hotel Booking Confirmation - PearlTrails (Booking ID #" + savedBooking.getBookingId() + ")";

            String body = "Dear " + loggedInUser.getFullName() + ",\n\n" +
                    "Your hotel booking has been successfully confirmed!\n\n" +
                    "--- Booking Details ---\n" +
                    "Booking Reference ID: #" + savedBooking.getBookingId() + "\n" +
                    "Hotel Name: " + listing.getTitle() + "\n" +
                    "Location: " + listing.getLocation() + "\n" +
                    "Room Type: " + roomType + "\n" +
                    "Check-in Date: " + checkInDate + "\n" +
                    "Check-out Date: " + checkOutDate + "\n" +
                    "Rooms Booked: " + roomCount + "\n" +
                    "Guests: " + guestCount + "\n" +
                    "Total Amount: $" + total + "\n\n" +
                    "Thank you for choosing PearlTrails!\nHave a wonderful stay!";

            emailService.sendEmail(customerEmail, subject, body);
        } catch (Exception e) {
            System.out.println("Hotel booking email sending failed: " + e.getMessage());
        }

        return "redirect:/my-bookings?success=true";
    }

    @PostMapping("/process-booking-payment")
    public String processBookingPayment(@RequestParam("bookingId") Integer bookingId,
                                        @RequestParam("amount") Double amount,
                                        HttpSession session) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Payment payment = new Payment();
        payment.setTourist(loggedInUser);
        payment.setOriginalAmount(amount);
        payment.setDiscountAmount(0.0);
        payment.setFinalAmount(amount);
        payment.setPaymentStatus("SUCCESS");
        payment.setPaymentDate(java.time.LocalDateTime.now());
        paymentRepository.save(payment);

        Booking booking = bookingRepository.findById(bookingId).orElse(null);
        if (booking != null) {
            booking.setStatus("Paid");
            bookingRepository.save(booking);
        }

        return "redirect:/my-bookings?paymentSuccess=true";
    }

    @GetMapping("/cancel-booking")
    public String cancelBooking(@RequestParam("id") Integer bookingId, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Booking booking = bookingRepository.findById(bookingId).orElse(null);
        if (booking != null && booking.getTourist().getUserId().equals(loggedInUser.getUserId())) {
            booking.setStatus("Cancelled");
            bookingRepository.save(booking);
        }

        return "redirect:/my-bookings?cancelled=true";
    }

    @GetMapping("/my-bookings")
    public String showMyBookings(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        List<Booking> myBookings = bookingRepository.findByTourist_UserId(loggedInUser.getUserId());
        List<TransportBooking> myTransportBookings = transportBookingRepository.findByUser_UserId(loggedInUser.getUserId());

        model.addAttribute("bookings", myBookings);
        model.addAttribute("transportBookings", myTransportBookings);

        return "my_bookings";
    }
}