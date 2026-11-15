package com.pearltrails.pearltrails.repository;

import com.pearltrails.pearltrails.model.PromoCode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PromoCodeRepository extends JpaRepository<PromoCode, Integer> {

    // Find promo code by its code string
    Optional<PromoCode> findByCode(String code);
}