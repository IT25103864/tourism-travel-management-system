package com.pearltrails.pearltrails.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "payments")
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer paymentId;

    @ManyToOne
    @JoinColumn(name = "tourist_id")
    private User tourist;

    private Double originalAmount;
    private Double discountAmount;
    private Double finalAmount;
    private String promoCodeUsed;
    private String paymentStatus; // SUCCESS / PENDING
    private LocalDateTime paymentDate = LocalDateTime.now();

    // Getters and Setters
    public Integer getPaymentId() { return paymentId; }
    public void setPaymentId(Integer paymentId) { this.paymentId = paymentId; }
    public User getTourist() { return tourist; }
    public void setTourist(User tourist) { this.tourist = tourist; }
    public Double getOriginalAmount() { return originalAmount; }
    public void setOriginalAmount(Double originalAmount) { this.originalAmount = originalAmount; }
    public Double getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(Double discountAmount) { this.discountAmount = discountAmount; }
    public Double getFinalAmount() { return finalAmount; }
    public void setFinalAmount(Double finalAmount) { this.finalAmount = finalAmount; }
    public String getPromoCodeUsed() { return promoCodeUsed; }
    public void setPromoCodeUsed(String promoCodeUsed) { this.promoCodeUsed = promoCodeUsed; }
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    public LocalDateTime getPaymentDate() { return paymentDate; }
    public void setPaymentDate(LocalDateTime paymentDate) { this.paymentDate = paymentDate; }
}