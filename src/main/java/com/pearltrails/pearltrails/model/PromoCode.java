package com.pearltrails.pearltrails.model;

import jakarta.persistence.*;

@Entity
@Table(name = "promo_codes")
public class PromoCode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer promoId;

    @Column(unique = true, nullable = false)
    private String code;

    private Double discountPercentage; // e.g., 10.0 for 10% off

    // Description or occasion of the promo code (e.g., New Year Special, Weekend Deal)
    private String description;

    // --- Getters and Setters ---
    public Integer getPromoId() { return promoId; }
    public void setPromoId(Integer promoId) { this.promoId = promoId; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public Double getDiscountPercentage() { return discountPercentage; }
    public void setDiscountPercentage(Double discountPercentage) { this.discountPercentage = discountPercentage; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}