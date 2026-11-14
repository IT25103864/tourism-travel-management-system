package com.pearltrails.pearltrails.controller;

import com.pearltrails.pearltrails.model.Listing;
import com.pearltrails.pearltrails.model.Transport;
import com.pearltrails.pearltrails.model.TravelPackage;
import com.pearltrails.pearltrails.model.User;
import com.pearltrails.pearltrails.repository.ListingRepository;
import com.pearltrails.pearltrails.repository.TransportRepository;
import com.pearltrails.pearltrails.repository.TravelPackageRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Arrays;
import java.util.List;

@Controller
public class PackageController {

    @Autowired
    private TravelPackageRepository travelPackageRepository;

    @Autowired
    private ListingRepository listingRepository;

    @Autowired
    private TransportRepository transportRepository;

    // 1. Show Package Creation Form (Restricted to Travel Agents only)
    @GetMapping("/create-package")
    public String showCreatePackageForm(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        String role = loggedInUser.getRole();
        if (role == null || (!role.equalsIgnoreCase("Travel Agent") && !role.equalsIgnoreCase("travel_agent"))) {
            return "redirect:/?error=unauthorized";
        }

        List<Listing> destinations = listingRepository.findByPropertyType("Attraction");
        List<Listing> hotels = listingRepository.findByPropertyTypeIn(Arrays.asList("Hotel", "Villa"));
        List<Transport> transports = transportRepository.findAll();

        model.addAttribute("destinationListings", destinations);
        model.addAttribute("hotelListings", hotels);
        model.addAttribute("transports", transports);

        return "create_package";
    }

    // 2. Handle Package Creation Submission by Travel Agent
    @PostMapping("/save-package")
    public String savePackage(@RequestParam("packageName") String packageName,
                              @RequestParam(value = "destinationListingIds", required = false) List<Integer> destinationListingIds,
                              @RequestParam(value = "hotelListingIds", required = false) List<Integer> hotelListingIds,
                              @RequestParam("transportId") Integer transportId,
                              @RequestParam("numberOfDays") int numberOfDays,
                              @RequestParam("totalPrice") double totalPrice,
                              @RequestParam("imageUrl") String imageUrl,
                              @RequestParam("description") String description,
                              HttpSession session) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Transport transport = transportRepository.findById(transportId).orElse(null);
        if (transport == null) {
            return "redirect:/create-package?error=invalid_transport";
        }

        StringBuilder destinationSummary = new StringBuilder();
        if (destinationListingIds != null) {
            for (Integer destId : destinationListingIds) {
                Listing dest = listingRepository.findById(destId).orElse(null);
                if (dest != null) {
                    if (destinationSummary.length() > 0) {
                        destinationSummary.append(", ");
                    }
                    destinationSummary.append(dest.getTitle());
                }
            }
        }

        TravelPackage travelPackage = new TravelPackage();
        travelPackage.setTourist(loggedInUser);
        travelPackage.setPackageName(packageName);
        travelPackage.setDestination(destinationSummary.length() > 0 ? destinationSummary.toString() : "Custom Destination");
        travelPackage.setDurationDays(numberOfDays);
        travelPackage.setTotalPrice(totalPrice);
        travelPackage.setImageUrl(imageUrl);
        travelPackage.setDescription(description);

        travelPackageRepository.save(travelPackage);

        return "redirect:/my-packages?success=created";
    }

    // 3. View Created Packages (For Travel Agents)
    @GetMapping("/my-packages")
    public String viewMyPackages(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        List<TravelPackage> packages = travelPackageRepository.findByTourist_UserId(loggedInUser.getUserId());
        model.addAttribute("packages", packages);

        return "my_packages";
    }

    // 4. Browse All Available Packages (For Tourists)
    @GetMapping("/packages-list")
    public String browsePackages(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        List<TravelPackage> allPackages = travelPackageRepository.findAll();
        model.addAttribute("packages", allPackages);

        return "packages_list";
    }

    // 5. Show Package Booking Form
    @GetMapping("/book-package")
    public String showBookPackageForm(@RequestParam("id") Integer packageId, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        TravelPackage travelPackage = travelPackageRepository.findById(packageId).orElse(null);
        if (travelPackage == null) {
            return "redirect:/packages-list?error=not_found";
        }

        model.addAttribute("travelPackage", travelPackage);
        return "book_package";
    }

    // 6. Confirm Package Booking Submission
    @PostMapping("/confirm-package-booking")
    public String confirmPackageBooking(@RequestParam("packageId") Integer packageId,
                                        @RequestParam("membersCount") int membersCount,
                                        @RequestParam("checkInDate") String checkInDate,
                                        @RequestParam("checkOutDate") String checkOutDate,
                                        HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        TravelPackage travelPackage = travelPackageRepository.findById(packageId).orElse(null);
        if (travelPackage == null) {
            return "redirect:/packages-list";
        }

        return "redirect:/my-bookings?success=booked";
    }

    // 7. Display details of a specific custom travel package
    @GetMapping("/package-details")
    public String showPackageDetails(@RequestParam("id") Integer id, Model model) {
        TravelPackage travelPackage = travelPackageRepository.findById(id).orElse(null);
        if (travelPackage == null) {
            return "redirect:/";
        }

        model.addAttribute("travelPackage", travelPackage);
        return "package_details";
    }

    // 8. Show Edit Package Form (Update)
    @GetMapping("/edit-package")
    public String showEditPackageForm(@RequestParam("id") Integer id, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        TravelPackage travelPackage = travelPackageRepository.findById(id).orElse(null);
        if (travelPackage == null) {
            return "redirect:/my-packages?error=not_found";
        }

        model.addAttribute("travelPackage", travelPackage);
        return "edit_package";
    }

    // 9. Handle Package Update Submission
    @PostMapping("/update-package")
    public String updatePackage(@RequestParam("packageId") Integer packageId,
                                @RequestParam("packageName") String packageName,
                                @RequestParam("destination") String destination,
                                @RequestParam("durationDays") Integer durationDays,
                                @RequestParam("totalPrice") Double totalPrice,
                                @RequestParam("imageUrl") String imageUrl,
                                @RequestParam("description") String description,
                                HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        TravelPackage travelPackage = travelPackageRepository.findById(packageId).orElse(null);
        if (travelPackage != null) {
            travelPackage.setPackageName(packageName);
            travelPackage.setDestination(destination);
            travelPackage.setDurationDays(durationDays);
            travelPackage.setTotalPrice(totalPrice);
            travelPackage.setImageUrl(imageUrl);
            travelPackage.setDescription(description);
            travelPackageRepository.save(travelPackage);
        }

        return "redirect:/my-packages?updated=true";
    }

    // 10. Handle Delete Package
    @GetMapping("/delete-package")
    public String deletePackage(@RequestParam("id") Integer id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        travelPackageRepository.deleteById(id);
        return "redirect:/my-packages?deleted=true";
    }
}