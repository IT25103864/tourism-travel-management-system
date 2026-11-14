package com.pearltrails.pearltrails.repository;

import com.pearltrails.pearltrails.model.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Integer> {

    // User ID is Integer in User model, so update parameter type to Integer
    List<Payment> findByTourist_UserId(Integer touristId);
}