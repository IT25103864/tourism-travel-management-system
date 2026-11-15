package com.pearltrails.pearltrails.pattern;

public class PaymentContext {
    private PaymentStrategy strategy;

    public void setPaymentStrategy(PaymentStrategy strategy) {
        this.strategy = strategy;
    }

    public void executePayment(double amount) {
        if (strategy == null) {
            throw new IllegalStateException("Payment method not selected!");
        }
        strategy.pay(amount);
    }
}