package com.pearltrails.pearltrails.pattern;

// Common Interface
interface HotelRoom {
    void createRoom();
}

// Concrete Classes
class DeluxeRoom implements HotelRoom {
    public void createRoom() { System.out.println("Deluxe Hotel Room listing created."); }
}

class StandardRoom implements HotelRoom {
    public void createRoom() { System.out.println("Standard Hotel Room listing created."); }
}

// Factory Class
public class HotelRoomFactory {
    public HotelRoom getRoomType(String roomType) {
        if (roomType == null) return null;
        if (roomType.equalsIgnoreCase("DELUXE")) {
            return new DeluxeRoom();
        } else if (roomType.equalsIgnoreCase("STANDARD")) {
            return new StandardRoom();
        }
        return null;
    }
}