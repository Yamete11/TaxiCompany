-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-10-04 13:35:22.616

-- Table: Customers
CREATE TABLE Customers (
    person_id BIGINT NOT NULL AUTO_INCREMENT,
    membership_status ENUM('Regular', 'VIP') NOT NULL DEFAULT 'Regular',
    vip_status_change_date TIMESTAMP NULL,
    vip_expiration_date TIMESTAMP NULL,
    CONSTRAINT pk_customers PRIMARY KEY (person_id)
);

-- Table: CustomerPromotions
CREATE TABLE CustomerPromotions (
    customer_promotion_id BIGINT NOT NULL AUTO_INCREMENT,
    person_id BIGINT NOT NULL,
    promotion_id BIGINT NOT NULL,
    use_date TIMESTAMP NOT NULL,
    CONSTRAINT pk_customer_promotions PRIMARY KEY (customer_promotion_id)
);

-- Table: Drivers
CREATE TABLE Drivers (
    person_id BIGINT NOT NULL AUTO_INCREMENT,
    vehicle_id BIGINT NOT NULL,
    license_number VARCHAR(20) NOT NULL,
    driver_rating_id TINYINT NOT NULL,
    CONSTRAINT pk_drivers PRIMARY KEY (person_id)
);

-- Table: DriverRatings
CREATE TABLE DriverRatings (
    driver_rating_id TINYINT NOT NULL AUTO_INCREMENT,
    rating TINYINT NOT NULL,
    CONSTRAINT pk_driver_ratings PRIMARY KEY (driver_rating_id)
);

-- Table: Feedbacks
CREATE TABLE Feedbacks (
    feedback_id BIGINT NOT NULL AUTO_INCREMENT,
    trip_id BIGINT NOT NULL,
    person_id BIGINT NOT NULL,
    comment VARCHAR(50) NOT NULL,
    CONSTRAINT pk_feedbacks PRIMARY KEY (feedback_id)
);

-- Table: Locations
CREATE TABLE Locations (
    location_id BIGINT NOT NULL AUTO_INCREMENT,
    city VARCHAR(30) NOT NULL,
    street VARCHAR(30) NOT NULL,
    CONSTRAINT pk_locations PRIMARY KEY (location_id)
);

-- Table: Payments
CREATE TABLE Payments (
    payment_id BIGINT NOT NULL AUTO_INCREMENT,
    trip_id BIGINT NOT NULL,
    payment_date TIMESTAMP NOT NULL,
    payment_method_id BIGINT NOT NULL,
    payment_amount DOUBLE NULL,
    CONSTRAINT pk_payments PRIMARY KEY (payment_id)
);

-- Table: PaymentMethods
CREATE TABLE PaymentMethods (
    payment_method_id BIGINT NOT NULL AUTO_INCREMENT,
    title VARCHAR(20) NOT NULL,
    description VARCHAR(30) NOT NULL,
    CONSTRAINT pk_payment_methods PRIMARY KEY (payment_method_id)
);

-- Table: Persons
CREATE TABLE Persons (
    person_id BIGINT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(254) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    CONSTRAINT pk_persons PRIMARY KEY (person_id)
);

-- Table: Promotions
CREATE TABLE Promotions (
    promotion_id BIGINT NOT NULL AUTO_INCREMENT,
    promotion_code VARCHAR(20) NOT NULL,
    description VARCHAR(100) NOT NULL,
    discount_percentage DOUBLE NOT NULL,
    expiration_date TIMESTAMP NOT NULL,
    is_active TINYINT NOT NULL,
    CONSTRAINT pk_promotions PRIMARY KEY (promotion_id)
);

-- Table: Trips
CREATE TABLE Trips (
    trip_id BIGINT NOT NULL AUTO_INCREMENT,
    customer_id BIGINT NOT NULL,
    driver_id BIGINT NOT NULL,
    trip_duration DOUBLE NOT NULL,
    trip_distance DOUBLE NOT NULL,
    start_location_id BIGINT NOT NULL,
    end_location_id BIGINT NOT NULL,
    trip_status_id BIGINT NOT NULL,
    CONSTRAINT pk_trips PRIMARY KEY (trip_id)
);

-- Table: TripStatuses
CREATE TABLE TripStatuses (
    trip_status_id BIGINT NOT NULL AUTO_INCREMENT,
    title VARCHAR(20) NOT NULL,
    CONSTRAINT pk_trip_statuses PRIMARY KEY (trip_status_id)
);

-- Table: VehicleMaintenances
CREATE TABLE VehicleMaintenances (
    maintenance_id BIGINT NOT NULL AUTO_INCREMENT,
    vehicle_id BIGINT NOT NULL,
    maintenance_date TIMESTAMP NOT NULL,
    description VARCHAR(50) NOT NULL,
    CONSTRAINT pk_vehicle_maintenances PRIMARY KEY (maintenance_id)
);

-- Table: Vehicles
CREATE TABLE Vehicles (
    vehicle_id BIGINT NOT NULL AUTO_INCREMENT,
    model VARCHAR(20) NOT NULL,
    year YEAR NOT NULL,
    plate_number VARCHAR(20) NOT NULL,
    CONSTRAINT pk_vehicles PRIMARY KEY (vehicle_id)
);

-- Foreign Keys

-- Reference: Customers_Person (table: Customers)
ALTER TABLE Customers ADD CONSTRAINT fk_customers_person FOREIGN KEY (person_id)
    REFERENCES Persons (person_id);

-- Reference: CustomerPromotions_Customers (table: CustomerPromotions)
ALTER TABLE CustomerPromotions ADD CONSTRAINT fk_customer_promotions_customers FOREIGN KEY (person_id)
    REFERENCES Customers (person_id);

-- Reference: CustomerPromotions_Promotions (table: CustomerPromotions)
ALTER TABLE CustomerPromotions ADD CONSTRAINT fk_customer_promotions_promotions FOREIGN KEY (promotion_id)
    REFERENCES Promotions (promotion_id);

-- Reference: Drivers_DriverRatings (table: Drivers)
ALTER TABLE Drivers ADD CONSTRAINT fk_drivers_driver_ratings FOREIGN KEY (driver_rating_id)
    REFERENCES DriverRatings (driver_rating_id);

-- Reference: Drivers_Persons (table: Drivers)
ALTER TABLE Drivers ADD CONSTRAINT fk_drivers_persons FOREIGN KEY (person_id)
    REFERENCES Persons (person_id);

-- Reference: Drivers_Vehicles (table: Drivers)
ALTER TABLE Drivers ADD CONSTRAINT fk_drivers_vehicles FOREIGN KEY (vehicle_id)
    REFERENCES Vehicles (vehicle_id);

-- Reference: Feedbacks_Customers (table: Feedbacks)
ALTER TABLE Feedbacks ADD CONSTRAINT fk_feedbacks_customers FOREIGN KEY (person_id)
    REFERENCES Customers (person_id);

-- Reference: Feedbacks_Trips (table: Feedbacks)
ALTER TABLE Feedbacks ADD CONSTRAINT fk_feedbacks_trips FOREIGN KEY (trip_id)
    REFERENCES Trips (trip_id);

-- Reference: Payments_PaymentMethods (table: Payments)
ALTER TABLE Payments ADD CONSTRAINT fk_payments_payment_methods FOREIGN KEY (payment_method_id)
    REFERENCES PaymentMethods (payment_method_id);

-- Reference: Payments_Trips (table: Payments)
ALTER TABLE Payments ADD CONSTRAINT fk_payments_trips FOREIGN KEY (trip_id)
    REFERENCES Trips (trip_id);

-- Reference: Trips_Customers (table: Trips)
ALTER TABLE Trips ADD CONSTRAINT fk_trips_customers FOREIGN KEY (customer_id)
    REFERENCES Customers (person_id);

-- Reference: Trips_Drivers (table: Trips)
ALTER TABLE Trips ADD CONSTRAINT fk_trips_drivers FOREIGN KEY (driver_id)
    REFERENCES Drivers (person_id);

-- Reference: Trips_StartLocations (table: Trips)
ALTER TABLE Trips ADD CONSTRAINT fk_trips_start_locations FOREIGN KEY (start_location_id)
    REFERENCES Locations (location_id);

-- Reference: Trips_EndLocations (table: Trips)
ALTER TABLE Trips ADD CONSTRAINT fk_trips_end_locations FOREIGN KEY (end_location_id)
    REFERENCES Locations (location_id);

-- Reference: Trips_TripStatuses (table: Trips)
ALTER TABLE Trips ADD CONSTRAINT fk_trips_trip_statuses FOREIGN KEY (trip_status_id)
    REFERENCES TripStatuses (trip_status_id);

-- Reference: VehicleMaintenances_Vehicles (table: VehicleMaintenances)
ALTER TABLE VehicleMaintenances ADD CONSTRAINT fk_vehicle_maintenances_vehicles FOREIGN KEY (vehicle_id)
    REFERENCES Vehicles (vehicle_id);

-- End of file.
