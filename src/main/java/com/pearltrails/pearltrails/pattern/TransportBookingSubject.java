package com.pearltrails.pearltrails.pattern;
import java.util.ArrayList;
import java.util.List;

// Observer Interface
interface Observer {
    void update(String message);
}

// Subject Interface
interface Subject {
    void addObserver(Observer o);
    void notifyObservers();
}

// Concrete Subject (Transport Booking)
public class TransportBookingSubject implements Subject {
    private List<Observer> observers = new ArrayList<>();
    private String bookingStatus;

    public void addObserver(Observer o) { observers.add(o); }

    public void notifyObservers() {
        for (Observer o : observers) {
            o.update(bookingStatus);
        }
    }

    public void setBookingStatus(String status) {
        this.bookingStatus = status;
        notifyObservers();
    }
}

// Concrete Observer (Tourist App / Email)
class TouristAppNotifier implements Observer {
    public void update(String message) {
        System.out.println("Notification to Tourist App: Your transport booking status is -> " + message);
    }
}