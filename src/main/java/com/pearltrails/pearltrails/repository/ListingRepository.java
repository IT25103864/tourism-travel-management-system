package com.pearltrails.pearltrails.repository;

import com.pearltrails.pearltrails.model.Listing;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Collection;
import java.util.List;

@Repository
public interface ListingRepository extends JpaRepository<Listing, Integer> {

    List<Listing> findByPropertyType(String propertyType);

    List<Listing> findByPropertyTypeIn(Collection<String> propertyTypes);

    List<Listing> findByStatus(String status);

    long countByStatus(String status);

    List<Listing> findByOwner_UserId(String userId);

    List<Listing> findByTitleContainingIgnoreCaseOrLocationContainingIgnoreCase(String title, String location);

    List<Listing> findByPropertyTypeAndTitleContainingIgnoreCaseOrPropertyTypeAndLocationContainingIgnoreCase(
            String propertyType1, String title, String propertyType2, String location);
}