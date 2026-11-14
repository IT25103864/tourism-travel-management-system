package com.pearltrails.pearltrails.controller;

import com.pearltrails.pearltrails.model.Listing;
import com.pearltrails.pearltrails.model.Review;
import com.pearltrails.pearltrails.model.Transport;
import com.pearltrails.pearltrails.model.User;
import com.pearltrails.pearltrails.repository.*;
import com.pearltrails.pearltrails.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private ListingRepository listingRepository;

    @Autowired
    private TransportRepository transportRepository;

    @Autowired
    private TravelPackageRepository travelPackageRepository;

    @Autowired
    private PromoCodeRepository promoCodeRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private UserRepository userRepository; // Added to fetch or check tourist user

    @Autowired
    private EmailService emailService;

    // Handle home page view, keyword search filtering for stays and destinations, and packages/promos/reviews
    @GetMapping("/")
    public String viewHomePage(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        List<Listing> attractions;
        List<Listing> hotels;
        List<Listing> villas;

        // Check if a search keyword is entered by the user
        if (keyword != null && !keyword.trim().isEmpty()) {
            attractions = listingRepository.findByPropertyTypeAndTitleContainingIgnoreCaseOrPropertyTypeAndLocationContainingIgnoreCase("Attraction", keyword, "Attraction", keyword);
            hotels = listingRepository.findByPropertyTypeAndTitleContainingIgnoreCaseOrPropertyTypeAndLocationContainingIgnoreCase("Hotel", keyword, "Hotel", keyword);
            villas = listingRepository.findByPropertyTypeAndTitleContainingIgnoreCaseOrPropertyTypeAndLocationContainingIgnoreCase("Villa", keyword, "Villa", keyword);
            model.addAttribute("keyword", keyword);
        } else {
            // Load default lists if no search keyword is provided
            attractions = listingRepository.findByPropertyType("Attraction");
            hotels = listingRepository.findByPropertyType("Hotel");
            villas = listingRepository.findByPropertyType("Villa");
        }

        // Fetch ALL transports directly from database table
        List<Transport> transports = transportRepository.findAll();

        // Pass filtered listings and transports to home view
        model.addAttribute("attractions", attractions);
        model.addAttribute("hotels", hotels);
        model.addAttribute("villas", villas);
        model.addAttribute("transports", transports);

        // Fetch and pass custom travel packages and promo codes to display on home page
        model.addAttribute("travelPackages", travelPackageRepository.findAll());
        model.addAttribute("promoCodes", promoCodeRepository.findAll());

        // Fetch and pass only approved reviews to display in the home page marquee section
        model.addAttribute("approvedReviews", reviewRepository.findByStatus("Approved"));

        return "home"; // Returns home.jsp view
    }

    // Handle customer review form submission with User and Listing association
    @PostMapping("/submit-review")
    public String submitReview(@RequestParam("touristName") String touristName,
                               @RequestParam("rating") int rating,
                               @RequestParam("comment") String comment) {
        try {
            Review review = new Review();
            review.setRating(rating);
            review.setComment(comment);
            review.setStatus("Pending"); // Default status for admin approval

            // Safely fetch the first available listing from the database
            Listing defaultListing = listingRepository.findAll().stream().findFirst().orElse(null);
            if (defaultListing != null) {
                review.setListing(defaultListing);
            } else {
                return "redirect:/#reviews";
            }

            // Find tourist from database securely using stream filtering
            User tourist = userRepository.findAll().stream()
                    .filter(u -> u.getFullName() != null && u.getFullName().equalsIgnoreCase(touristName))
                    .findFirst()
                    .orElseGet(() -> userRepository.findAll().stream().findFirst().orElse(null));

            review.setTourist(tourist);

            // Save review into the database
            if (defaultListing != null && tourist != null) {
                reviewRepository.save(review);
            }
        } catch (Exception e) {
            System.out.println("Review submission error: " + e.getMessage());
        }

        // Redirect back to the home page reviews section after submission
        return "redirect:/#reviews";
    }

    // Handle contact form submission and send email to admin
    @PostMapping("/contact")
    public String handleContactMessage(@RequestParam("name") String name,
                                       @RequestParam("email") String email,
                                       @RequestParam("message") String message) {
        try {
            String adminEmail = "pearltrails.admin@gmail.com";

            String subject = "New Contact Message from " + name;
            String body = "You have received a new message from the PearlTrails contact form.\n\n" +
                    "Name: " + name + "\n" +
                    "Email: " + email + "\n\n" +
                    "Message:\n" + message;

            emailService.sendEmail(adminEmail, subject, body);

        } catch (Exception e) {
            System.out.println("Contact email error: " + e.getMessage());
        }
        return "redirect:/?sent=true";
    }
}