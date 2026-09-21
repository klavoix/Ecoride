CREATE DATABASE ecoride;
USE ecoride;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pseudo VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    credits INT DEFAULT 20,
    role ENUM('user','employee','admin') DEFAULT 'user',
    status ENUM('active','suspended') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    immatriculation VARCHAR(20),
    date_first_immat DATE,
    marque VARCHAR(50),
    modele VARCHAR(50),
    couleur VARCHAR(50),
    energie ENUM('electrique','essence','diesel','hybride') NOT NULL,
    places INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE rides (
    id INT AUTO_INCREMENT PRIMARY KEY,
    driver_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    ville_depart VARCHAR(100) NOT NULL,
    ville_arrivee VARCHAR(100) NOT NULL,
    date_depart DATE NOT NULL,
    heure_depart TIME NOT NULL,
    date_arrivee DATE NOT NULL,
    heure_arrivee TIME NOT NULL,
    duree_minutes INT NOT NULL,
    prix_credits INT NOT NULL,
    places_total INT NOT NULL,
    places_restantes INT NOT NULL,
    statut ENUM('planifie','en_cours','termine','annule') DEFAULT 'planifie',
    FOREIGN KEY (driver_id) REFERENCES users(id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id)
);

CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ride_id INT NOT NULL,
    passenger_id INT NOT NULL,
    credits_payes INT NOT NULL,
    statut ENUM('confirme','annule') DEFAULT 'confirme',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ride_id) REFERENCES rides(id),
    FOREIGN KEY (passenger_id) REFERENCES users(id)
);

CREATE TABLE platform_credit_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ride_id INT NOT NULL,
    montant INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ride_id) REFERENCES rides(id)
);