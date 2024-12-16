INSERT INTO VEHICLE_TYPES (NAME, PRICE_PER_KM) VALUES
                                                   ('STANDARD', 150),
                                                   ('LUXURY', 250),
                                                   ('VAN', 200);


INSERT INTO USERS (ADDRESS,EMAIL,IS_ACTIVATED,IS_BLOCKED,NAME,PASSWORD,SURNAME,TELEPHONE_NUMBER,PROFILE_PICTURE) VALUES
    ('Bulevar oslobođenja 74', 'passenger1@mail.com', true, false, 'Radomir',
     '$2a$10$VjmW6rGtWg2vqQQ0kcytPej/gZ33H0UC/Fl4RioHh7LK7FdKTD3um', 'Radomirović', '+38165338295', '');

INSERT INTO USER_ACTIVATIONS(DATE_CREATED,MINUTES_VALID,USER_ID) VALUES
    (CURRENT_TIMESTAMP,25,1);


INSERT INTO LOCATIONS (ADDRESS, LATITUDE, LONGITUDE) VALUES
                                                         ('Đorđa Mikeša 2', 45.235866, 19.807387),
                                                         ('Anđe Ranković 2', 45.247309, 19.796717),
                                                         ('Veselina Masleše 62', 45.259711, 19.809787),
                                                         ('Jovana Hranilovića 2', 45.261421, 19.823026);

INSERT INTO VEHICLES (BABY_TRANSPORT, LICENSE_NUMBER, MODEL, PASSENGER_SEATS, PET_TRANSPORT, CURRENT_LOCATION, VEHICLE_TYPE) VALUES
    (true, 'NS 123-AB', 'VS Golf 3', 4, true, 1, 1);

INSERT INTO VEHICLES (BABY_TRANSPORT, LICENSE_NUMBER, MODEL, PASSENGER_SEATS, PET_TRANSPORT, CURRENT_LOCATION, VEHICLE_TYPE) VALUES
    (true, 'NS 567-VR', 'Fiat Punto', 4, true, 3, 1);

INSERT INTO DRIVERS(ID, VEHICLE_ID,IS_ACTIVE) VALUES (3, 1,false);

INSERT INTO DOCUMENTS(DOCUMENT_IMAGE, NAME, DRIVER_ID) VALUES
                                                               ('U3dhZ2dlciByb2Nrcw=', 'VOZACKA_DOZVOLA', 3);

INSERT INTO WORKING_HOURS(SHIFT_START, SHIFT_END, DRIVER_ID) VALUES
                                                                     ('2023-01-08 09:35:22', '2023-01-08 09:35:23', 3);


INSERT INTO USERS (ADDRESS,EMAIL,IS_ACTIVATED,IS_BLOCKED,NAME,PASSWORD,SURNAME,TELEPHONE_NUMBER,PROFILE_PICTURE) VALUES
    ('Bulevar Oslobođenja 23','driver2@mail.com',true, false, 'Jovan', '$2a$10$VjmW6rGtWg2vqQQ0kcytPej/gZ33H0UC/Fl4RioHh7LK7FdKTD3um', 'Jovanović', '+381657896445','');

INSERT INTO USER_ROLE (user_id, role_id) VALUES (3, 2);

INSERT INTO USER_ROLE (user_id, role_id) VALUES (4, 2);

INSERT INTO DRIVERS(ID, VEHICLE_ID,IS_ACTIVE) VALUES (4, 2,false);

INSERT INTO USERS (ADDRESS,EMAIL,IS_ACTIVATED,IS_BLOCKED,NAME,PASSWORD,SURNAME,TELEPHONE_NUMBER,PROFILE_PICTURE) VALUES
    ('Bulevar oslobođenja 74', 'passenger3@mail.com', true, false, 'Radomir',
     '$2a$10$VjmW6rGtWg2vqQQ0kcytPej/gZ33H0UC/Fl4RioHh7LK7FdKTD3um', 'Radomirović', '+38165338295', '');

INSERT INTO PASSENGERS VALUES 5;
INSERT INTO USER_ROLE (user_id, role_id) VALUES (5, 1);


INSERT INTO ROUTES(START_LOCATION_ID, END_LOCATION_ID, DISTANCE_IN_KM) VALUES
                                                                           (1, 2, 15),
                                                                           (2, 1, 15),
                                                                           (3, 4, 5),
                                                                           (4, 3, 5);

INSERT INTO FAVORITES(FAVORITE_NAME, VEHICLE_TYPE, TRANSPORTS_BABY, TRANSPORTS_PET) VALUES
                                                                                        ('Kuća do posla', 1, false, false),
                                                                                        ('Posao do kuće', 2, false, true),
                                                                                        ('Kuća do škole', 3, true, false),
                                                                                        ('Škola do kuće', 1, true, true);

INSERT INTO FAVORITES_PASSENGERS(FAVORITE_RIDE_ID, PASSENGERS_ID) VALUES
                                                                      (1, 1),
                                                                      (2, 1),
                                                                      (3, 1),
                                                                      (4, 1);

INSERT INTO FAVORITE_ROUTE(FAVORITE_ID, ROUTE_ID) VALUES
                                                      (1, 1),
                                                      (2, 2),
                                                      (3, 3),
                                                      (4, 4);

INSERT INTO RIDES(START_TIME, END_TIME, STATUS, TOTAL_PRICE,DRIVER_ID,VEHICLE_TYPE, TRANSPORTS_PET, TRANSPORTS_BABY)
VALUES ('2023-01-30 09:35:22', '2023-01-30 09:35:23', 'FINISHED', 1100,4,1, true, true),
       ('2023-01-30 09:36:22', '2023-01-30 09:36:23', 'FINISHED', 1000,4,2, false, false),
       ('2023-01-30 09:37:22', '2023-01-30 09:37:23', 'FINISHED', 1500,4,3, true, false),
       ('2023-02-01 09:35:22', '2023-02-01 09:35:23', 'FINISHED', 2000,4,2, false, true),
       ('2023-02-02 09:35:22', '2023-02-02 09:35:23', 'FINISHED', 500,4,3, true, true),
       ('2023-02-02 09:36:22', '2023-02-02 09:36:23', 'FINISHED', 1000,4,1, false, false),
       ('2023-02-02 09:37:22', '2023-02-02 09:37:23', 'FINISHED', 1500,4,1, false, false);


INSERT INTO RIDES_PASSENGERS(RIDE_ID, PASSENGERS_ID) VALUES
                                                         (1, 1),
                                                         (2, 1),
                                                         (3, 1),
                                                         (4, 1),
                                                         (5, 1),
                                                         (6, 2),
                                                         (7, 2);

INSERT INTO RIDE_ROUTE(RIDE_ID, ROUTE_ID) VALUES
                                              (1, 1),
                                              (2, 2),
                                              (3, 3),
                                              (4, 4),
                                              (5, 1),
                                              (6, 2),
                                              (7, 3);


INSERT INTO REVIEWS(COMMENT,RATING,CURRENT_RIDE,REVIEWER_ID) VALUES ('Vozač je bio korektan i oprezan.',9,1,1),
                                                                    ('Vozilo je bilo čisto i uredno.',10,1,1),
                                                                    ('Odličan vozač!', 10, 2, 1),
                                                                    ('Odlično vozilo!', 10, 2, 1);

INSERT INTO RIDES_REVIEWS VALUES (1,1), (1,2), (2,3), (2, 4);

INSERT INTO DRIVER_REVIEWS VALUES (1,4),(3,4);
INSERT INTO VEHICLE_REVIEWS VALUES (2,2), (4, 2);
INSERT INTO MESSAGES(MESSAGE,MESSAGE_TYPE,SENT_DATE_TIME,RECEIVER_ID,RIDE_ID,SENDER_ID) VALUES
('Da li smo blizu kraja?','VOZNJA','2023-01-20 09:35:22',4,1,1),
('Još malo?','VOZNJA','2023-01-20 09:35:23',1,1,4);


INSERT INTO USERS (ADDRESS,EMAIL,IS_ACTIVATED,IS_BLOCKED,NAME,PASSWORD,SURNAME,TELEPHONE_NUMBER,PROFILE_PICTURE) VALUES
    ('Kisačka 15', 'admin@mail.com', true, false, 'Nikola',
     '$2a$10$VjmW6rGtWg2vqQQ0kcytPej/gZ33H0UC/Fl4RioHh7LK7FdKTD3um', 'Simić', '+38165338295', '');
INSERT INTO ADMINS VALUES 6;
INSERT INTO USER_ROLE (user_id, role_id) VALUES (6, 3);