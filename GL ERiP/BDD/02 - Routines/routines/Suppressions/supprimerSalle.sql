DELIMITER $$

/* 	Procédure permettant de supprimer une salle à partir de
	son nom
	*/
CREATE PROCEDURE supprimerSalle(salle VARCHAR(45))
BEGIN

	DELETE FROM Salles
	WHERE nomSalle = salle;

END $$


DELIMITER ;