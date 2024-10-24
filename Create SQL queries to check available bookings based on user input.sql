-- task 1
INSERT INTO Bookings(BookingID, BookingDate, TableNumber, CustomerID)
VALUES
(1, "2022-10-10", 5, 1),
(1, "2022-11-12", 3, 3),
(1, "2022-10-11", 2, 2),
(1, "2022-10-13", 2, 1),


-- task 2
CREATE PROCEDURE CheckBooking(IN date_booking DATE, IN table_number INT)
BEGIN
    SELECT
        CASE
            WHEN date_booking <= CURDATE() THEN 'Table is already booked'
            ELSE 'Table is not already booked'
        END AS booking_status
    FROM Bookings
    WHERE BookingID = table_number;
END //


-- task 3
CREATE PROCEDURE AddValidBooking(IN booking_date DATE, IN table_number INT, IN customer_id INT)
BEGIN
    DECLARE table_count INT;

    -- Start the transaction
    START TRANSACTION;

    -- Check if the table is already booked on the given date
    SELECT COUNT(*) INTO table_count
    FROM Bookings
    WHERE BookingDate = booking_date AND TableNumber = table_number;

    -- If the table is booked, rollback the transaction
    IF table_count > 0 THEN
        ROLLBACK;
        SELECT 'Booking declined: Table is already booked.' AS result;
    ELSE
        -- If the table is available, insert the booking and commit the transaction
        INSERT INTO Bookings (BookingDate, TableNumber, CustomerID)
        VALUES (booking_date, table_number, customer_id);

        COMMIT;
        SELECT 'Booking successful: Table is reserved.' AS result;
    END IF;

END //