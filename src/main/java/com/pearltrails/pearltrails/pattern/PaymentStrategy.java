package com.pearltrails.pearltrails.pattern;

// 1. Strategy Interface
interface PaymentStrategy {
    void pay(double amount);
}

// 2. Concrete Strategy A
class CreditCardPayment implements PaymentStrategy {
    public void pay(double amount) {
        System.out.println("Paid LKR " + amount + " using Credit Card.");
    }
}

// 3. Concrete Strategy B
class PayPalPayment implements PaymentStrategy {
    public void pay(double amount) {
        System.out.println("Paid LKR " + amount + " using PayPal.");
    }
}