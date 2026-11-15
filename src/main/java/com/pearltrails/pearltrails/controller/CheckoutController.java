package com.pearltrails.pearltrails.controller;

import com.pearltrails.pearltrails.model.Booking;
import com.pearltrails.pearltrails.model.Payment;
import com.pearltrails.pearltrails.model.PromoCode;
import com.pearltrails.pearltrails.model.TransportBooking;
import com.pearltrails.pearltrails.model.TravelPackage;
import com.pearltrails.pearltrails.model.User;
import com.pearltrails.pearltrails.repository.BookingRepository;
import com.pearltrails.pearltrails.repository.PaymentRepository;
import com.pearltrails.pearltrails.repository.PromoCodeRepository;
import com.pearltrails.pearltrails.repository.TransportBookingRepository;
import com.pearltrails.pearltrails.repository.TravelPackageRepository;
import com.pearltrails.pearltrails.service.EmailService;
import com.pearltrails.pearltrails.service.SmsService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class CheckoutController {

    @Autowired
    private TravelPackageRepository travelPackageRepository;

    @Autowired
    private BookingRepository bookingRepository; // For Hotel Bookings

    @Autowired
    private TransportBookingRepository transportBookingRepository; // For Vehicle Bookings

    @Autowired
    private PromoCodeRepository promoCodeRepository;

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private SmsService smsService;

    @Autowired
    private EmailService emailService;

    // Simulated fixed OTP for demonstration and viva presentation purposes
    private final String SIMULATED_OTP = "1234";

    /// 1. Show Checkout Page for Travel Package (Updated with required = false to prevent Whitelabel Error)
    @GetMapping("/checkout")
    public String showCheckout(@RequestParam(value = "packageId", required = false) Integer packageId,
                               @RequestParam(value = "promoCode", required = false) String promoCodeStr,
                               HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        if (packageId == null) {
            return "redirect:/my-packages"; // Redirect if accessed without packageId
        }

        TravelPackage travelPackage = travelPackageRepository.findById(packageId).orElse(null);
        if (travelPackage == null) {
            return "redirect:/my-packages";
        }

        double originalAmount = travelPackage.getTotalPrice();
        double discountAmount = 0.0;
        double finalAmount = originalAmount;
        String appliedPromo = null;

        if (promoCodeStr != null && !promoCodeStr.trim().isEmpty()) {
            Optional<PromoCode> promoOpt = promoCodeRepository.findByCode(promoCodeStr.trim());
            if (promoOpt.isPresent()) {
                PromoCode promo = promoOpt.get();
                discountAmount = (originalAmount * promo.getDiscountPercentage()) / 100.0;
                finalAmount = originalAmount - discountAmount;
                appliedPromo = promo.getCode();
                model.addAttribute("promoMessage", "Promo code applied successfully (" + promo.getDiscountPercentage() + "% OFF)!");
            } else {
                model.addAttribute("promoError", "Invalid promo code!");
            }
        }

        model.addAttribute("packageId", packageId);
        model.addAttribute("originalAmount", originalAmount);
        model.addAttribute("discountAmount", discountAmount);
        model.addAttribute("finalAmount", finalAmount);
        model.addAttribute("appliedPromo", appliedPromo);

        return "checkout";
    }

    // 2. Show Checkout Page for Hotel Booking
    @GetMapping("/checkout-booking")
    public String showBookingCheckout(@RequestParam("bookingId") Integer bookingId,
                                      @RequestParam(value = "promoCode", required = false) String promoCodeStr,
                                      HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Booking booking = bookingRepository.findById(bookingId).orElse(null);
        if (booking == null) {
            return "redirect:/my-bookings";
        }

        double originalAmount = booking.getTotalAmount();
        double discountAmount = 0.0;
        double finalAmount = originalAmount;
        String appliedPromo = null;

        if (promoCodeStr != null && !promoCodeStr.trim().isEmpty()) {
            Optional<PromoCode> promoOpt = promoCodeRepository.findByCode(promoCodeStr.trim());
            if (promoOpt.isPresent()) {
                PromoCode promo = promoOpt.get();
                discountAmount = (originalAmount * promo.getDiscountPercentage()) / 100.0;
                finalAmount = originalAmount - discountAmount;
                appliedPromo = promo.getCode();
                model.addAttribute("promoMessage", "Promo code applied successfully (" + promo.getDiscountPercentage() + "% OFF)!");
            } else {
                model.addAttribute("promoError", "Invalid promo code!");
            }
        }

        model.addAttribute("booking", booking);
        model.addAttribute("originalAmount", originalAmount);
        model.addAttribute("discountAmount", discountAmount);
        model.addAttribute("finalAmount", finalAmount);
        model.addAttribute("appliedPromo", appliedPromo);

        return "checkout_booking";
    }

    // 3. Show Checkout Page for Transport/Vehicle Booking
    @GetMapping("/checkout-transport")
    public String showTransportCheckout(@RequestParam("transportBookingId") Integer transportBookingId,
                                        @RequestParam(value = "promoCode", required = false) String promoCodeStr,
                                        HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        TransportBooking transportBooking = transportBookingRepository.findById(transportBookingId).orElse(null);
        if (transportBooking == null) {
            return "redirect:/my-bookings";
        }

        double originalAmount = transportBooking.getTotalAmount();
        double discountAmount = 0.0;
        double finalAmount = originalAmount;
        String appliedPromo = null;

        if (promoCodeStr != null && !promoCodeStr.trim().isEmpty()) {
            Optional<PromoCode> promoOpt = promoCodeRepository.findByCode(promoCodeStr.trim());
            if (promoOpt.isPresent()) {
                PromoCode promo = promoOpt.get();
                discountAmount = (originalAmount * promo.getDiscountPercentage()) / 100.0;
                finalAmount = originalAmount - discountAmount;
                appliedPromo = promo.getCode();
                model.addAttribute("promoMessage", "Promo code applied successfully (" + promo.getDiscountPercentage() + "% OFF)!");
            } else {
                model.addAttribute("promoError", "Invalid promo code!");
            }
        }

        model.addAttribute("transportBooking", transportBooking);
        model.addAttribute("originalAmount", originalAmount);
        model.addAttribute("discountAmount", discountAmount);
        model.addAttribute("finalAmount", finalAmount);
        model.addAttribute("appliedPromo", appliedPromo);

        return "checkout_transport";
    }

    // 4. Show Payment Details Input Page
    @GetMapping("/payment-details")
    public String showPaymentDetailsPage(@RequestParam(value = "packageId", required = false) Integer packageId,
                                         @RequestParam(value = "bookingId", required = false) Integer bookingId,
                                         @RequestParam(value = "transportBookingId", required = false) Integer transportBookingId,
                                         @RequestParam(value = "originalAmount", required = false) Double originalAmount,
                                         @RequestParam(value = "discountAmount", required = false) Double discountAmount,
                                         @RequestParam("finalAmount") Double finalAmount,
                                         @RequestParam(value = "promoCodeUsed", required = false) String promoCodeUsed,
                                         HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        model.addAttribute("packageId", packageId);
        model.addAttribute("bookingId", bookingId);
        model.addAttribute("transportBookingId", transportBookingId);
        model.addAttribute("originalAmount", originalAmount != null ? originalAmount : finalAmount);
        model.addAttribute("discountAmount", discountAmount != null ? discountAmount : 0.0);
        model.addAttribute("finalAmount", finalAmount);
        model.addAttribute("promoCodeUsed", promoCodeUsed);

        return "payment_details";
    }

    // 5. Intercept Payment Details, Save in Session, Send Simulated OTP, and Redirect to OTP Verification Page
    @PostMapping("/process-payment")
    public String processPayment(@RequestParam(value = "packageId", required = false) Integer packageId,
                                 @RequestParam(value = "bookingId", required = false) Integer bookingId,
                                 @RequestParam(value = "transportBookingId", required = false) Integer transportBookingId,
                                 @RequestParam(value = "originalAmount", required = false) Double originalAmount,
                                 @RequestParam(value = "discountAmount", required = false) Double discountAmount,
                                 @RequestParam("finalAmount") Double finalAmount,
                                 @RequestParam(value = "promoCodeUsed", required = false) String promoCodeUsed,
                                 @RequestParam("fullName") String fullName,
                                 @RequestParam("phone") String phone,
                                 @RequestParam("email") String email,
                                 HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        // Store payment details temporarily in session until OTP is verified
        session.setAttribute("pending_packageId", packageId);
        session.setAttribute("pending_bookingId", bookingId);
        session.setAttribute("pending_transportBookingId", transportBookingId);
        session.setAttribute("pending_originalAmount", originalAmount);
        session.setAttribute("pending_discountAmount", discountAmount);
        session.setAttribute("pending_finalAmount", finalAmount);
        session.setAttribute("pending_promoCodeUsed", promoCodeUsed);
        session.setAttribute("pending_fullName", fullName);
        session.setAttribute("pending_phone", phone);
        session.setAttribute("pending_email", email);

        // Simulate sending SMS OTP
        System.out.println("OTP 1234 sent to mobile number: " + phone);

        return "redirect:/verify-payment-otp";
    }

    // 6. Show OTP Verification Page
    @GetMapping("/verify-payment-otp")
    public String showPaymentOtpPage(HttpSession session, Model model) {
        String phone = (String) session.getAttribute("pending_phone");
        if (phone == null) {
            return "redirect:/checkout";
        }
        model.addAttribute("phone", phone);
        return "verify_otp"; // verify_otp.jsp page
    }

    // 7. Confirm OTP and Execute Final Payment Processing
    @PostMapping("/confirm-payment-otp")
    public String confirmPaymentOtp(@RequestParam("enteredOtp") String enteredOtp, HttpSession session) {
        if (!SIMULATED_OTP.equals(enteredOtp)) {
            return "redirect:/verify-payment-otp?error=invalid";
        }

        // Retrieve stored details from session
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Integer packageId = (Integer) session.getAttribute("pending_packageId");
        Integer bookingId = (Integer) session.getAttribute("pending_bookingId");
        Integer transportBookingId = (Integer) session.getAttribute("pending_transportBookingId");
        Double originalAmount = (Double) session.getAttribute("pending_originalAmount");
        Double discountAmount = (Double) session.getAttribute("pending_discountAmount");
        Double finalAmount = (Double) session.getAttribute("pending_finalAmount");
        String promoCodeUsed = (String) session.getAttribute("pending_promoCodeUsed");
        String fullName = (String) session.getAttribute("pending_fullName");
        String phone = (String) session.getAttribute("pending_phone");
        String email = (String) session.getAttribute("pending_email");

        // Save Payment record in Database
        Payment payment = new Payment();
        payment.setTourist(loggedInUser);
        payment.setOriginalAmount(originalAmount != null ? originalAmount : finalAmount);
        payment.setDiscountAmount(discountAmount != null ? discountAmount : 0.0);
        payment.setFinalAmount(finalAmount);
        payment.setPromoCodeUsed(promoCodeUsed);
        payment.setPaymentStatus("SUCCESS");

        paymentRepository.save(payment);

        // Update Booking Status if Hotel or Transport booking ID is present
        if (bookingId != null) {
            Booking booking = bookingRepository.findById(bookingId).orElse(null);
            if (booking != null) {
                booking.setStatus("Paid");
                bookingRepository.save(booking);
            }
        } else if (transportBookingId != null) {
            TransportBooking transportBooking = transportBookingRepository.findById(transportBookingId).orElse(null);
            if (transportBooking != null) {
                transportBooking.setStatus("Paid");
                transportBookingRepository.save(transportBooking);
            }
        }

        // Trigger SMS Notification
        String smsMessage = "Dear " + fullName + ", your payment of $" + finalAmount + " for PearlTrails is successful! Payment ID: #PT-" + payment.getPaymentId();
        try {
            smsService.sendSms(phone, smsMessage);
        } catch (Exception e) {
            System.out.println("SMS sending failed: " + e.getMessage());
        }

        // Trigger Email Notification
        if (email != null && !email.isEmpty()) {
            String emailSubject = "PearlTrails - Payment & Booking Confirmation (#PT-" + payment.getPaymentId() + ")";
            String emailBody = "Dear " + fullName + ",\n\n" +
                    "Thank you for your payment! Your booking has been successfully confirmed.\n\n" +
                    "Payment Details:\n" +
                    "- Payment ID: #PT-" + payment.getPaymentId() + "\n" +
                    "- Total Paid: $" + finalAmount + "\n" +
                    "- Phone: " + phone + "\n" +
                    "- Status: SUCCESS\n\n" +
                    "Best regards,\n" +
                    "PearlTrails Team";
            try {
                emailService.sendEmail(email, emailSubject, emailBody);
            } catch (Exception e) {
                System.out.println("Email sending failed: " + e.getMessage());
            }
        }

        // Clear session temporary attributes
        session.removeAttribute("pending_packageId");
        session.removeAttribute("pending_bookingId");
        session.removeAttribute("pending_transportBookingId");
        session.removeAttribute("pending_originalAmount");
        session.removeAttribute("pending_discountAmount");
        session.removeAttribute("pending_finalAmount");
        session.removeAttribute("pending_promoCodeUsed");
        session.removeAttribute("pending_fullName");
        session.removeAttribute("pending_phone");
        session.removeAttribute("pending_email");

        return "redirect:/payment-success?paymentId=" + payment.getPaymentId();
    }

    // 8. Payment Success Page
    @GetMapping("/payment-success")
    public String paymentSuccess(@RequestParam("paymentId") Integer paymentId, Model model) {
        Payment payment = paymentRepository.findById(paymentId).orElse(null);
        model.addAttribute("payment", payment);
        return "payment_success";
    }
}