package com.pearltrails.pearltrails.controller;

import com.pearltrails.pearltrails.model.Transport;
import com.pearltrails.pearltrails.model.User;
import com.pearltrails.pearltrails.repository.TransportRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class TransportController {

    @Autowired
    private TransportRepository transportRepository;

    @GetMapping("/add-transport")
    public String showAddTransportForm(HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/login";
        return "add_transport";
    }

    @PostMapping("/add-transport")
    public String saveTransport(@RequestParam("vehicleType") String vehicleType,
                                @RequestParam("vehicleModel") String vehicleModel,
                                @RequestParam("numberPlate") String numberPlate,
                                @RequestParam("seatingCapacity") int seatingCapacity,
                                @RequestParam("route") String route,
                                @RequestParam("price") Double price,
                                @RequestParam("description") String description,
                                @RequestParam("imageUrl") String imageUrl,
                                HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/login";

        Transport transport = new Transport();
        transport.setVehicleType(vehicleType);
        transport.setVehicleModel(vehicleModel);
        transport.setNumberPlate(numberPlate);
        transport.setSeatingCapacity(seatingCapacity);
        transport.setRoute(route);
        transport.setPrice(price);
        transport.setDescription(description);
        transport.setImageUrl(imageUrl);
        transport.setProvider(loggedInUser);
        transport.setStatus("Available");

        transportRepository.save(transport);
        return "redirect:/my-transports?success=created";
    }

    @GetMapping("/my-transports")
    public String showMyTransports(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/login";

        List<Transport> myTransports = transportRepository.findByProvider_UserId(loggedInUser.getUserId());
        model.addAttribute("transports", myTransports);
        return "my_transports";
    }

    // Handle URL to show details of a specific transport/vehicle
    @GetMapping("/transport-details")
    public String showTransportDetails(@RequestParam("id") Integer id, Model model) {
        Transport transport = transportRepository.findByTransportId(id);
        if (transport == null) {
            return "redirect:/?error=transport_not_found";
        }
        model.addAttribute("transport", transport);
        return "transport_details";
    }

    // 1. Show Edit Transport Form
    @GetMapping("/edit-transport")
    public String showEditTransportForm(@RequestParam("id") Integer id, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/login";

        Transport transport = transportRepository.findByTransportId(id);
        if (transport == null) {
            return "redirect:/my-transports?error=not_found";
        }

        model.addAttribute("transport", transport);
        return "edit_transport";
    }

    // 2. Handle Transport Update Submission
    @PostMapping("/update-transport")
    public String updateTransport(@RequestParam("transportId") Integer transportId,
                                  @RequestParam("vehicleType") String vehicleType,
                                  @RequestParam("vehicleModel") String vehicleModel,
                                  @RequestParam("numberPlate") String numberPlate,
                                  @RequestParam("seatingCapacity") int seatingCapacity,
                                  @RequestParam("route") String route,
                                  @RequestParam("price") Double price,
                                  @RequestParam("description") String description,
                                  @RequestParam("imageUrl") String imageUrl,
                                  HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/login";

        Transport transport = transportRepository.findByTransportId(transportId);
        if (transport != null) {
            transport.setVehicleType(vehicleType);
            transport.setVehicleModel(vehicleModel);
            transport.setNumberPlate(numberPlate);
            transport.setSeatingCapacity(seatingCapacity);
            transport.setRoute(route);
            transport.setPrice(price);
            transport.setDescription(description);
            transport.setImageUrl(imageUrl);
            transportRepository.save(transport);
        }

        return "redirect:/my-transports?updated=true";
    }

    // 3. Handle Delete Transport
    @GetMapping("/delete-transport")
    public String deleteTransport(@RequestParam("id") Integer id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/login";

        Transport transport = transportRepository.findByTransportId(id);
        if (transport != null) {
            transportRepository.delete(transport);
        }

        return "redirect:/my-transports?deleted=true";
    }
}