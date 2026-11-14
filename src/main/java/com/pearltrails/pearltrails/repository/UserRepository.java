package com.pearltrails.pearltrails.repository;

import com.pearltrails.pearltrails.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, String> { // Changed Integer to String for custom IDs like U001

    // Method to find a user by their email and password for login
    User findByEmailAndPassword(String email, String password);

    Optional<User> findByEmail(String email);

    // Method to find the last registered user to generate the next custom user ID (e.g., U001, U002)
    User findTopByOrderByUserIdDesc();
}