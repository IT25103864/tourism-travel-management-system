package com.pearltrails.pearltrails.repository;

import com.pearltrails.pearltrails.model.Transport;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TransportRepository extends JpaRepository<Transport, Integer> {

    // Allow service providers to view only their own transports (User ID is a String)
    List<Transport> findByProvider_UserId(String providerId);

    // Allow tourists to search transport based on the route
    List<Transport> findByRouteContainingIgnoreCase(String route);

    // ==========================================
    // Added for Vehicle Categorization
    // ==========================================

    // Fetch vehicles filtered by vehicle type (e.g., Car, Van, SUV)
    List<Transport> findByVehicleType(String vehicleType);

    // ==========================================
    // Composite Primary Key
    // ==========================================
    @Query("SELECT t FROM Transport t WHERE t.id = :id")
    Transport findByTransportId(@Param("id") Integer id);
}