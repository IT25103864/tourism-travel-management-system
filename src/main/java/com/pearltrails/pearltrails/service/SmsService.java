package com.pearltrails.pearltrails.service;

import org.springframework.stereotype.Service;

@Service
public class SmsService {

    // Method to simulate sending SMS (Can be integrated with Twilio API later)
    public void sendSms(String phoneNumber, String message) {
        // In a real production app, Twilio / Dialog API integration goes here.
        System.out.println("----------------------------------------");
        System.out.println("📱 [SMS GATEWAY SIMULATION]");
        System.out.println("Sending to: " + phoneNumber);
        System.out.println("Message: "  + message);
        System.out.println("----------------------------------------");
    }
}