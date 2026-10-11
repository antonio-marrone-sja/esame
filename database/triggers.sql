USE library_management;

-- Primo trigger, verifica la disponibilità di una copia

DELIMITER $$

CREATE TRIGGER check_copy_availability
BEFORE INSERT ON loans
FOR EACH ROW
BEGIN
    DECLARE current_status VARCHAR(20);

    SELECT status
    INTO current_status
    FROM book_copies
    WHERE copy_id = NEW.copy_id;

    IF current_status <> 'available' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La copia del libro non è disponibile.';
    END IF;
END$$

DELIMITER ;

-- Secondo trigger, modifica lo stato di una
-- copia dopo essere stata presa in prestito

DELIMITER $$

CREATE TRIGGER update_copy_status_after_loan
AFTER INSERT ON loans
FOR EACH ROW
BEGIN
    UPDATE book_copies
    SET status = 'on_loan'
    WHERE copy_id = NEW.copy_id;
END$$

DELIMITER ;

-- Terzo trigger rende disponibile una copia che è stata ritornata

DELIMITER $$

CREATE TRIGGER update_copy_status_after_return
AFTER UPDATE ON loans
FOR EACH ROW
BEGIN
    IF OLD.return_date IS NULL
       AND NEW.return_date IS NOT NULL THEN

        UPDATE book_copies
        SET status = 'available'
        WHERE copy_id = NEW.copy_id;

    END IF;
END$$

DELIMITER ;