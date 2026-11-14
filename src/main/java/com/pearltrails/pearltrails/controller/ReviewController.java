package com.pearltrails.pearltrails.controller;

import com.pearltrails.pearltrails.model.Listing;
import com.pearltrails.pearltrails.model.Review;
import com.pearltrails.pearltrails.model.User;
import com.pearltrails.pearltrails.repository.ListingRepository;
import com.pearltrails.pearltrails.repository.ReviewRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ReviewController {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private ListingRepository listingRepository;

    // Handle the Review Form Submission
    @PostMapping("/add-review")
    public String addReview(@RequestParam("listingId") Integer listingId,
                            @RequestParam("rating") Integer rating,
                            @RequestParam("comment") String comment,
                            HttpSession session) {

        // Get the logged-in user from the session
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // If no user is logged in, redirect to login page
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        // Fetch listing using standard findById to match single primary key configuration
        Listing listing = listingRepository.findById(listingId).orElse(null);

        if (listing != null) {
            Review review = new Review();
            review.setListing(listing);
            review.setTourist(loggedInUser); // Set the real logged-in user
            review.setRating(rating);
            review.setComment(comment);

            // Set status to Pending so Admin has to approve it
            review.setStatus("Pending");

            reviewRepository.save(review);
        }

        // Redirect back to the specific listing's detail page
        return "redirect:/listing?id=" + listingId;
    }
}