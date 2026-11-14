package com.pearltrails.pearltrails.controller;

import com.pearltrails.pearltrails.model.User;
import com.pearltrails.pearltrails.repository.UserRepository;
import com.pearltrails.pearltrails.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EmailService emailService;

    // Show Registration Form
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    // Handle Registration Submission with Provider Type separation
    @PostMapping("/register")
    public String registerUser(@RequestParam("fullName") String fullName,
                               @RequestParam("email") String email,
                               @RequestParam("phone") String phone,
                               @RequestParam("password") String password,
                               @RequestParam("role") String role,
                               @RequestParam(value = "providerType", required = false) String providerType,
                               Model model) {

        // Check if email already exists
        if (userRepository.findByEmail(email).isPresent()) {
            model.addAttribute("error", "Email is already registered!");
            return "register";
        }

        // --- Custom User ID Generation Logic ---
        String newUserId = "U001";
        User lastUser = userRepository.findTopByOrderByUserIdDesc();

        if (lastUser != null && lastUser.getUserId() != null) {
            String lastId = lastUser.getUserId();
            try {
                int numericPart = Integer.parseInt(lastId.substring(1));
                numericPart++;
                newUserId = String.format("U%03d", numericPart);
            } catch (Exception e) {
                newUserId = "U" + System.currentTimeMillis();
            }
        }

        // Determine correct role if Service Provider is selected
        String finalRole = role;
        if ("Service Provider".equalsIgnoreCase(role)) {
            if ("Transport Provider".equalsIgnoreCase(providerType)) {
                finalRole = "Transport Provider";
            } else {
                finalRole = "Hotel Provider";
            }
        }

        // Create and setup new User
        User user = new User();
        user.setUserId(newUserId);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setRole(finalRole);
        user.setAccountStatus("Active");

        userRepository.save(user);

        // Send Welcome Email
        if (email != null && !email.isEmpty()) {
            String subject = "Welcome to PearlTrails!";
            String body = "Dear " + fullName + ",\n\n" +
                    "Thank you for registering with PearlTrails! Your account has been successfully created as a " + finalRole + ".\n" +
                    "Your User ID is: " + newUserId + "\n\n" +
                    "You can now log in and explore our platform.\n\n" +
                    "Best regards,\n" +
                    "PearlTrails Team";
            try {
                emailService.sendEmail(email, subject, body);
            } catch (Exception e) {
                System.out.println("Registration email sending failed: " + e.getMessage());
            }
        }

        return "redirect:/login?registered=true";
    }

    // Show Login Form
    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    // Handle Login Submission with Role-based redirection
    @PostMapping("/login")
    public String loginUser(@RequestParam("email") String email,
                            @RequestParam("password") String password,
                            HttpSession session,
                            Model model) {

        User user = userRepository.findByEmailAndPassword(email, password);

        if (user != null) {
            session.setAttribute("loggedInUser", user);

            // Redirect to Admin Dashboard if user is an Admin
            if ("Admin".equalsIgnoreCase(user.getRole()) || "ADMIN".equalsIgnoreCase(user.getRole())) {
                return "redirect:/admin";
            }

            // Redirect others to Home page
            return "redirect:/";
        } else {
            model.addAttribute("error", "Invalid email or password!");
            return "login";
        }
    }

    // Handle Logout with proper session termination and cache prevention
    @GetMapping("/logout")
    public String logoutUser(HttpSession session, HttpServletResponse response) {
        session.invalidate();

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        return "redirect:/";
    }

    // 1. Show Forgot Password Page
    @GetMapping("/forgot-password")
    public String showForgotPasswordForm() {
        return "forgot_password";
    }

    // 2. Handle Password Reset
    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam("email") String email,
                                        @RequestParam("newPassword") String newPassword,
                                        Model model) {
        User user = userRepository.findByEmail(email).orElse(null);
        if (user == null) {
            model.addAttribute("error", "Email address not found!");
            return "forgot_password";
        }

        user.setPassword(newPassword);
        userRepository.save(user);

        model.addAttribute("success", "Password updated successfully! You can now login.");
        return "forgot_password";
    }
}