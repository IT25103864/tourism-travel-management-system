package com.pearltrails.pearltrails.pattern;

// Component Interface
interface TourPackage {
    String getDescription();
    double getCost();
}

// Concrete Component
class BaseTourPackage implements TourPackage {
    public String getDescription() { return "Standard Island Tour Package"; }
    public double getCost() { return 50000.00; }
}

// Abstract Decorator
abstract class PackageDecorator implements TourPackage {
    protected TourPackage tempPackage;

    public PackageDecorator(TourPackage newPackage) {
        this.tempPackage = newPackage;
    }

    public String getDescription() { return tempPackage.getDescription(); }
    public double getCost() { return tempPackage.getCost(); }
}

// Concrete Decorator (Adding Tour Guide)
public class TourGuideDecorator extends PackageDecorator {
    public TourGuideDecorator(TourPackage newPackage) {
        super(newPackage);
    }

    public String getDescription() {
        return tempPackage.getDescription() + " + Professional Tour Guide";
    }

    public double getCost() {
        return tempPackage.getCost() + 10000.00;
    }
}