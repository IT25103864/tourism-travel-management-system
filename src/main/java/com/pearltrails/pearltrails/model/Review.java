package com.pearltrails.pearltrails.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Reviews") // Maps this class to the "Reviews" table in the database
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer reviewId; // Primary key for the review

    @Column(nullable = false)
    private Integer rating; // Rating out of 5 (e.g., 1, 2, 3, 4, 5)

    @Column(nullable = false, length = 1000)
    private String comment; // The actual review text

    @Column(nullable = false)
    private String status = "Pending"; // Status can be 'Pending', 'Approved', or 'Rejected'

    // Many-to-One relationship: Many reviews can be written by one User (Tourist)
    @ManyToOne
    @JoinColumn(name = "tourist_id", nullable = false)
    private User tourist;

    // Many-to-One relationship: Many reviews can belong to one Listing
    @ManyToOne
    @JoinColumn(name = "listing_id", nullable = false)
    private Listing listing;

    // Default constructor required by Spring Boot
    public Review() {
    }

    // --- Getters and Setters ---

    public Integer getReviewId() { return reviewId; }
    public void setReviewId(Integer reviewId) { this.reviewId = reviewId; }

    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public User getTourist() { return tourist; }
    public void setTourist(User tourist) { this.tourist = tourist; }

    public Listing getListing() { return listing; }
    public void setListing(Listing listing) { this.listing = listing; }
}