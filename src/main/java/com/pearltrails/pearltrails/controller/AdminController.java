package com.pearltrails.pearltrails.controller;

import com.pearltrails.pearltrails.model.Listing;
import com.pearltrails.pearltrails.model.PromoCode;
import com.pearltrails.pearltrails.model.Review;
import com.pearltrails.pearltrails.model.User;
import com.pearltrails.pearltrails.repository.ListingRepository;
import com.pearltrails.pearltrails.repository.PromoCodeRepository;
import com.pearltrails.pearltrails.repository.ReviewRepository;
import com.pearltrails.pearltrails.repository.TransportRepository;
import com.pearltrails.pearltrails.repository.TravelPackageRepository;
import com.pearltrails.pearltrails.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.util.List;

@Controller
public class AdminController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ListingRepository listingRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private TransportRepository transportRepository;

    @Autowired
    private TravelPackageRepository travelPackageRepository;

    @Autowired
    private PromoCodeRepository promoCodeRepository;

    @GetMapping("/admin")
    public String showAdminDashboard(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        long userCount = userRepository.count();
        long pendingListingsCount = listingRepository.countByStatus("Pending");
        long pendingReviewsCount = reviewRepository.countByStatus("Pending");
        long totalListings = listingRepository.count();
        long totalPackages = travelPackageRepository.count();
        long totalTransports = transportRepository.count();

        model.addAttribute("totalUsers", userCount);
        model.addAttribute("pendingListings", pendingListingsCount);
        model.addAttribute("pendingReviews", pendingReviewsCount);
        model.addAttribute("totalListings", totalListings);
        model.addAttribute("totalPackages", totalPackages);
        model.addAttribute("totalTransports", totalTransports);

        return "admin_dashboard";
    }

    @GetMapping("/admin/users")
    public String manageUsers(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        List<User> userList = userRepository.findAll();
        model.addAttribute("users", userList);

        return "manage_users";
    }

    @PostMapping("/admin/users/block")
    public String blockUser(@RequestParam("userId") String userId, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        User user = userRepository.findById(userId).orElse(null);
        if (user != null) {
            user.setAccountStatus("Blocked");
            userRepository.save(user);
        }

        return "redirect:/admin/users";
    }

    @GetMapping("/admin/listings")
    public String manageListings(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        List<Listing> pendingListings = listingRepository.findByStatus("Pending");
        model.addAttribute("listings", pendingListings);

        return "manage_listings";
    }

    @PostMapping("/admin/listings/approve")
    public String approveListing(@RequestParam("listingId") Integer listingId, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        Listing listing = listingRepository.findById(listingId).orElse(null);
        if (listing != null) {
            listing.setStatus("Approved");
            listingRepository.save(listing);
        }

        return "redirect:/admin/listings";
    }

    @PostMapping("/admin/listings/reject")
    public String rejectListing(@RequestParam("listingId") Integer listingId, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        Listing listing = listingRepository.findById(listingId).orElse(null);
        if (listing != null) {
            listing.setStatus("Rejected");
            listingRepository.save(listing);
        }

        return "redirect:/admin/listings";
    }

    // Display ALL reviews so approved ones don't disappear and can still be deleted
    @GetMapping("/admin/reviews")
    public String manageReviews(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        List<Review> allReviews = reviewRepository.findAll();
        model.addAttribute("reviews", allReviews);

        return "manage_reviews";
    }

    @PostMapping("/admin/reviews/approve")
    public String approveReview(@RequestParam("reviewId") Integer reviewId, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        Review review = reviewRepository.findById(reviewId).orElse(null);
        if (review != null) {
            review.setStatus("Approved");
            reviewRepository.save(review);
        }

        return "redirect:/admin/reviews";
    }

    @PostMapping("/admin/reviews/reject")
    public String rejectReview(@RequestParam("reviewId") Integer reviewId, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        Review review = reviewRepository.findById(reviewId).orElse(null);
        if (review != null) {
            review.setStatus("Rejected");
            reviewRepository.save(review);
        }

        return "redirect:/admin/reviews";
    }

    @GetMapping("/admin/reviews/delete")
    public String deleteReview(@RequestParam("reviewId") Integer reviewId, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        Review review = reviewRepository.findById(reviewId).orElse(null);
        if (review != null) {
            reviewRepository.delete(review);
        }

        return "redirect:/admin/reviews";
    }

    @GetMapping("/admin/export-report")
    public void exportToExcel(HttpServletResponse response) throws IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=PearlTrails_Report.csv");

        response.getWriter().write("BookingID,UserEmail,TotalPrice,Status\n");
        response.getWriter().write("B001,tourist@gmail.com,250.00,Confirmed\n");
    }

    @GetMapping("/admin/reports")
    public String showAdminReports(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        long totalUsers = userRepository.count();
        long totalListings = listingRepository.count();
        long totalTransports = transportRepository.count();
        long totalPackages = travelPackageRepository.count();

        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalListings", totalListings);
        model.addAttribute("totalTransports", totalTransports);
        model.addAttribute("totalPackages", totalPackages);

        return "admin_reports";
    }

    @GetMapping("/admin/create-promo")
    public String showCreatePromoForm(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        List<PromoCode> promoCodes = promoCodeRepository.findAll();
        model.addAttribute("promoCodes", promoCodes);

        return "create_promo";
    }

    @PostMapping("/admin/create-promo")
    public String savePromoCode(@RequestParam("code") String code,
                                @RequestParam("discountPercentage") Double discountPercentage,
                                @RequestParam("description") String description,
                                HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        PromoCode promoCode = new PromoCode();
        promoCode.setCode(code.trim().toUpperCase());
        promoCode.setDiscountPercentage(discountPercentage);
        promoCode.setDescription(description);

        promoCodeRepository.save(promoCode);

        return "redirect:/admin/create-promo?success=true";
    }

    @GetMapping("/admin/edit-promo")
    public String editPromoCode(@RequestParam("id") Integer promoId, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        PromoCode promoCodeToEdit = promoCodeRepository.findById(promoId).orElse(null);
        List<PromoCode> promoCodes = promoCodeRepository.findAll();

        model.addAttribute("promoCode", promoCodeToEdit);
        model.addAttribute("promoCodes", promoCodes);

        return "create_promo";
    }

    @PostMapping("/admin/update-promo")
    public String updatePromoCode(@RequestParam("promoId") Integer promoId,
                                  @RequestParam("code") String code,
                                  @RequestParam("discountPercentage") Double discountPercentage,
                                  @RequestParam("description") String description,
                                  HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        PromoCode promoCode = promoCodeRepository.findById(promoId).orElse(null);
        if (promoCode != null) {
            promoCode.setCode(code.trim().toUpperCase());
            promoCode.setDiscountPercentage(discountPercentage);
            promoCode.setDescription(description);
            promoCodeRepository.save(promoCode);
        }

        return "redirect:/admin/create-promo?success=true";
    }

    @GetMapping("/admin/delete-promo")
    public String deletePromoCode(@RequestParam("id") Integer promoId, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && !"ADMIN".equalsIgnoreCase(loggedInUser.getRole()))) {
            return "redirect:/login";
        }

        promoCodeRepository.deleteById(promoId);
        return "redirect:/admin/create-promo?success=true";
    }
}