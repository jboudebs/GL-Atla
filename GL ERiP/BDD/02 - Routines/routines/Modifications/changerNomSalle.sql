DELIMITER $$

/* Procédure permettant de modifier le nom d'une salle */
CREATE PROCEDURE changerNomSalle(IN numSalle INT, IN nouveauNomSalle VARCHAR(45))
BEGIN

	UPDATE Salles 
    SET nomSalle = nouveauNomSalle 
    WHERE idSalle = numSalle;

END$$

DELIMITER ;
