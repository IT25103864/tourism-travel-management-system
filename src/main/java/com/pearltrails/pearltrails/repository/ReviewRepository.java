package com.pearltrails.pearltrails.repository;

import com.pearltrails.pearltrails.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Integer> {

    // Counts reviews based on status
    long countByStatus(String status);

    // Fetches a list of reviews based on their status
    List<Review> findByStatus(String status);

    // Find reviews for a specific listing where the status is given (e.g., 'Approved')
    List<Review> findByListing_ListingIdAndStatus(Integer listingId, String status);

    // Fetch all reviews for a specific listing by its ID
    List<Review> findByListing_ListingId(Integer listingId);
}