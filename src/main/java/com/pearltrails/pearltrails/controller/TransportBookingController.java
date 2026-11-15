package com.pearltrails.pearltrails.controller;

import com.pearltrails.pearltrails.model.Transport;
import com.pearltrails.pearltrails.model.TransportBooking;
import com.pearltrails.pearltrails.model.User;
import com.pearltrails.pearltrails.repository.TransportBookingRepository;
import com.pearltrails.pearltrails.repository.TransportRepository;
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

@Controller
public class TransportBookingController {

    @Autowired
    private TransportBookingRepository transportBookingRepository;

    @Autowired
    private TransportRepository transportRepository;

    @Autowired
    private EmailService emailService;

    // Show transport booking form
    @GetMapping("/book-transport")
    public String showTransportBookingForm(@RequestParam("id") Integer id, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Transport transport = transportRepository.findById(id).orElse(null);
        if (transport == null) {
            return "redirect:/?error=transport_not_found";
        }

        model.addAttribute("transport", transport);
        return "book_transport";
    }

    // Handle transport booking submission and send confirmation email
    @PostMapping("/book-transport")
    public String saveTransportBooking(@RequestParam("transportId") Integer transportId,
                                       @RequestParam("startDate") @org.springframework.format.annotation.DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
                                       @RequestParam("endDate") @org.springframework.format.annotation.DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate,
                                       @RequestParam("passengerCount") Integer passengerCount,
                                       HttpSession session) {

        // Check if user is logged in via session
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Transport transport = transportRepository.findById(transportId).orElse(null);
        if (transport == null) {
            return "redirect:/?error=transport_not_found";
        }

        // Create and save transport booking
        TransportBooking booking = new TransportBooking();
        booking.setTransport(transport);
        booking.setUser(loggedInUser);
        booking.setStartDate(startDate);
        booking.setEndDate(endDate);
        booking.setPassengerCount(passengerCount);
        booking.setStatus("Confirmed");

        // Calculate rental days and total amount
        long days = ChronoUnit.DAYS.between(startDate, endDate);
        if (days <= 0) {
            days = 1; // Minimum 1 day rental
        }
        double total = transport.getPrice() * days;
        booking.setTotalAmount(total);

        TransportBooking savedBooking = transportBookingRepository.save(booking);

        // Send confirmation email to the customer
        try {
            String customerEmail = loggedInUser.getEmail();
            String subject = "Vehicle Rental Confirmation - PearlTrails (Booking ID #" + savedBooking.getId() + ")";

            String body = "Dear " + loggedInUser.getFullName() + ",\n\n" +
                    "Your vehicle rental has been successfully confirmed!\n\n" +
                    "--- Rental Details ---\n" +
                    "Booking Reference ID: #" + savedBooking.getId() + "\n" +
                    "Vehicle Model: " + transport.getVehicleModel() + "\n" +
                    "Vehicle Type: " + transport.getVehicleType() + "\n" +
                    "Rental Start Date: " + startDate + "\n" +
                    "Rental End Date: " + endDate + "\n" +
                    "Passenger Count: " + passengerCount + "\n" +
                    "Total Amount: $" + total + "\n\n" +
                    "Thank you for choosing PearlTrails!\nHave a safe journey!";

            emailService.sendEmail(customerEmail, subject, body);
        } catch (Exception e) {
            System.out.println("Transport booking email failed: " + e.getMessage());
        }

        return "redirect:/my-bookings?success=true";
    }

}