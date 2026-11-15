package com.pearltrails.pearltrails.pattern;

public class DatabaseConnectionManager {

    private static DatabaseConnectionManager instance;

    private DatabaseConnectionManager() {
        System.out.println("Singleton Database Connection Initialized.");
    }

    public static DatabaseConnectionManager getInstance() {
        if (instance == null) {
            instance = new DatabaseConnectionManager();
        }
        return instance;
    }

    public void connect() {
        System.out.println("Connected to PearlTrails Database successfully.");
    }

    public static void main(String[] args) {

        DatabaseConnectionManager db1 =
                DatabaseConnectionManager.getInstance();

        DatabaseConnectionManager db2 =
                DatabaseConnectionManager.getInstance();

        db1.connect();
        db1.connect();

        System.out.println(db1==db2);

    }
}
