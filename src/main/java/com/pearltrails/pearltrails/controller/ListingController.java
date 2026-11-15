package com.pearltrails.pearltrails.controller;

import com.pearltrails.pearltrails.model.Listing;
import com.pearltrails.pearltrails.model.Review;
import com.pearltrails.pearltrails.model.User;
import com.pearltrails.pearltrails.repository.ListingRepository;
import com.pearltrails.pearltrails.repository.ReviewRepository;
import com.pearltrails.pearltrails.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import java.util.List;

@Controller
public class ListingController {

    @Autowired
    private ListingRepository listingRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @GetMapping("/add-listing")
    public String showAddListingForm(HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        return "add_listing";
    }

    @PostMapping("/add-listing")
    public String saveListing(@RequestParam("title") String title,
                              @RequestParam("description") String description,
                              @RequestParam("location") String location,
                              @RequestParam(value = "price", required = false, defaultValue = "0.0") Double price,
                              @RequestParam("imageUrl") String imageUrl,
                              @RequestParam(value = "propertyType", required = false, defaultValue = "Hotel") String propertyType,
                              HttpSession session) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Listing newListing = new Listing();
        newListing.setTitle(title);
        newListing.setDescription(description);
        newListing.setLocation(location);
        newListing.setPrice(price);
        newListing.setImageUrl(imageUrl);
        newListing.setPropertyType(propertyType);
        newListing.setOwner(loggedInUser);

        if ("TravelAgent".equalsIgnoreCase(loggedInUser.getRole()) || "TRAVEL_AGENT".equalsIgnoreCase(loggedInUser.getRole())) {
            newListing.setStatus("Approved");
            newListing.setPropertyType("Destination");
        } else {
            newListing.setStatus("Pending");
        }

        listingRepository.save(newListing);
        return "redirect:/my-listings";
    }

    @GetMapping("/my-listings")
    public String showMyListings(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        List<Listing> myListings = listingRepository.findByOwner_UserId(loggedInUser.getUserId());
        model.addAttribute("listings", myListings);
        return "my_listings";
    }

    @GetMapping("/listing")
    public String showListingDetails(@RequestParam("id") Integer id, Model model) {
        Listing listing = listingRepository.findById(id).orElse(null);
        List<Review> reviews = reviewRepository.findByListing_ListingIdAndStatus(id, "Approved");

        model.addAttribute("listing", listing);
        model.addAttribute("reviews", reviews);
        return "listing_details";
    }

    @GetMapping("/listing-details")
    public String showListingDetailsAlias(@RequestParam("id") Integer id, Model model) {
        Listing listing = listingRepository.findById(id).orElse(null);
        List<Review> reviews = reviewRepository.findByListing_ListingIdAndStatus(id, "Approved");

        model.addAttribute("listing", listing);
        model.addAttribute("reviews", reviews);
        return "listing_details";
    }

    @GetMapping("/book-listing")
    public String showBookListingForm(@RequestParam("id") Integer id, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Listing listing = listingRepository.findById(id).orElse(null);
        if (listing == null) {
            return "redirect:/?error=not_found";
        }

        model.addAttribute("listing", listing);
        return "book_listing";
    }

    @GetMapping("/edit-listing")
    public String showEditListingForm(@RequestParam("id") Integer id, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Listing listing = listingRepository.findById(id).orElse(null);
        if (listing == null) {
            return "redirect:/my-listings?error=not_found";
        }

        model.addAttribute("listing", listing);
        return "edit_listing";
    }

    @PostMapping("/update-listing")
    public String updateListing(@RequestParam("listingId") Integer listingId,
                                @RequestParam("title") String title,
                                @RequestParam("location") String location,
                                @RequestParam("description") String description,
                                @RequestParam("price") Double price,
                                @RequestParam("imageUrl") String imageUrl,
                                @RequestParam("propertyType") String propertyType,
                                HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Listing listing = listingRepository.findById(listingId).orElse(null);
        if (listing != null) {
            listing.setTitle(title);
            listing.setLocation(location);
            listing.setDescription(description);
            listing.setPrice(price);
            listing.setImageUrl(imageUrl);
            listing.setPropertyType(propertyType);
            listingRepository.save(listing);
        }

        return "redirect:/my-listings?updated=true";
    }

    @GetMapping("/delete-listing")
    public String deleteListing(@RequestParam("id") Integer id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        listingRepository.deleteById(id);
        return "redirect:/my-listings?deleted=true";
    }
}