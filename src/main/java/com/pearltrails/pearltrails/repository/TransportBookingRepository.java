package com.pearltrails.pearltrails.repository;

import com.pearltrails.pearltrails.model.TransportBooking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TransportBookingRepository extends JpaRepository<TransportBooking, Integer> {

    // Change from findByUser_UserId to findByUser_Id or findByUserId
    List<TransportBooking> findByUser_UserId(String userId);}