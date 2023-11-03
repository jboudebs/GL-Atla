DELIMITER $$

/* Procédure permettant la levée d'une erreur */
CREATE PROCEDURE raiseError(IN msg VARCHAR(100))
BEGIN

    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = msg;

END $$

DELIMITER ;