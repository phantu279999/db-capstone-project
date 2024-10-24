CREATE PROCEDURE AddBooking(IN booking_id INT, IN booking_date DATE, IN table_number INT, IN customer_id INT)
BEGIN
    DECLARE table_count INT;

    START TRANSACTION;

    -- Check if the table is already booked on the given date
    SELECT COUNT(*) INTO table_count
    FROM Bookings
    WHERE BookingDate = booking_date AND TableNumber = table_number;

    IF table_count > 0 THEN
        ROLLBACK;
        SELECT 'Bookng failed: Table is already booked.' AS result;
    ELSE
        INSERT INTO Bookings (BookingID, BookingDate, TableNumber, CustomerID)
        VALUES (booking_id, booking_date, table_number, customer_id);

        COMMIT;
        SELECT 'Booking successful: Table is reserved.' AS result;
    END IF;
END //



CREATE PROCEDURE UpdateBooking(IN booking_id INT, IN booking_date DATE)
BEGIN
    DECLARE table_count INT;

    START TRANSACTION;

    -- Check if the table is already booked on the given date
    SELECT COUNT(*) INTO table_count
    FROM Bookings
    WHERE BookingID = booking_id;


    IF table_count > 0 THEN
        UPDATE Bookings SET BookingDate = booking_date WHERE BookingID = booking_id;
        COMMIT;
        SELECT 'Booking is updated' AS result;
    ELSE
        ROLLBACK;
        SELECT 'Booking is not exists' AS result;
    END IF;
END //


CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN
    DECLARE table_count INT;

    START TRANSACTION;

    SELECT COUNT(*) INTO table_count
    FROM Bookings
    WHERE BookingID = booking_id;

    IF table_count > 0 THEN
        DELETE FROM Bookings WHERE BookingID = booking_id;
        COMMIT;
        SELECT 'Booking is deleted' AS result;
    ELSE
        ROLLBACK;
        SELECT 'Booking is not exists' AS result;
    END IF;
END //