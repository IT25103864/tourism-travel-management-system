package com.pearltrails.pearltrails.repository;

import com.pearltrails.pearltrails.model.TravelPackage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TravelPackageRepository extends JpaRepository<TravelPackage, Integer> {

    // Since the User ID in the User model is a String, update the parameter type to String
    List<TravelPackage> findByTourist_UserId(String touristId);
}