package com.pearltrails.pearltrails.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Travel_Packages")
public class TravelPackage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer packageId;

    @Column(nullable = false)
    private String packageName;

    @Column(nullable = false, length = 1000)
    private String destination;

    @Column(nullable = false)
    private Integer durationDays;

    @Column(nullable = false)
    private Double totalPrice;

    private String imageUrl;

    @Column(nullable = false, length = 1500)
    private String description;

    @ManyToOne
    @JoinColumn(name = "tourist_id", nullable = false)
    private User tourist; // Travel agent or creator who posted the package

    public TravelPackage() {}

    // --- Getters and Setters ---
    public Integer getPackageId() { return packageId; }
    public void setPackageId(Integer packageId) { this.packageId = packageId; }

    public String getPackageName() { return packageName; }
    public void setPackageName(String packageName) { this.packageName = packageName; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public Integer getDurationDays() { return durationDays; }
    public void setDurationDays(Integer durationDays) { this.durationDays = durationDays; }

    public Double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(Double totalPrice) { this.totalPrice = totalPrice; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public User getTourist() { return tourist; }
    public void setTourist(User tourist) { this.tourist = tourist; }
}