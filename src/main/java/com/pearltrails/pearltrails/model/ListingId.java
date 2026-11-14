package com.pearltrails.pearltrails.model;

import java.io.Serializable;
import java.util.Objects;

// Composite primary key class for Listing entity (listing_id + user_id)
public class ListingId implements Serializable {
    private Integer listingId;
    private String owner; // Corresponds to the User entity ID (user_id)

    public ListingId() {}

    public ListingId(Integer listingId, String owner) {
        this.listingId = listingId;
        this.owner = owner;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ListingId listingId1 = (ListingId) o;
        return Objects.equals(listingId, listingId1.listingId) && Objects.equals(owner, listingId1.owner);
    }

    @Override
    public int hashCode() {
        return Objects.hash(listingId, owner);
    }
}