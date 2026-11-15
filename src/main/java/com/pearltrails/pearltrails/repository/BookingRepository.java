package com.pearltrails.pearltrails.repository;

import com.pearltrails.pearltrails.model.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Integer> {

    // Since the User ID in the User model is a String, the parameter here must also be a String to match properly
    List<Booking> findByTourist_UserId(String touristId);

}