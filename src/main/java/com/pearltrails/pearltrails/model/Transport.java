package com.pearltrails.pearltrails.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Transports")
public class Transport {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String vehicleType; // e.g., Car, Van, Bus, Tuk Tuk

    @Column(nullable = false)
    private String vehicleModel;

    @Column(nullable = false, unique = true)
    private String numberPlate;

    @Column(nullable = false)
    private Integer seatingCapacity;

    @Column(nullable = false)
    private Double price; // Price per day or per km

    @Column(nullable = false, columnDefinition = "TEXT")
    private String description;

    private String imageUrl;

    @Column(nullable = false)
    private String status = "Available"; // Available, Booked, Maintenance

    private String route; // Operating route or area

    @ManyToOne
    @JoinColumn(name = "provider_id", nullable = false)
    private User provider;

    public Transport() {}

    // --- Getters and Setters ---
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }

    public String getVehicleModel() { return vehicleModel; }
    public void setVehicleModel(String vehicleModel) { this.vehicleModel = vehicleModel; }

    public String getNumberPlate() { return numberPlate; }
    public void setNumberPlate(String numberPlate) { this.numberPlate = numberPlate; }

    public Integer getSeatingCapacity() { return seatingCapacity; }
    public void setSeatingCapacity(Integer seatingCapacity) { this.seatingCapacity = seatingCapacity; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getRoute() { return route; }
    public void setRoute(String route) { this.route = route; }

    public User getProvider() { return provider; }
    public void setProvider(User provider) { this.provider = provider; }
}