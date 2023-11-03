DELIMITER $$

/* Procédure permettant de changer la note d'un entretien */
CREATE PROCEDURE changerNoteEntretien(IN heure DATETIME, IN nom_Salle VARCHAR(45), IN nouvelleNote INT)
BEGIN

	DECLARE id_Salle INT;
	SELECT (idSalleParNomSalle(nom_Salle)) INTO @id_Salle;
	
	UPDATE Entretiens 
	SET note = nouvelleNote 
	WHERE dateHeure = heure AND fk_idSalle = @id_Salle;

END$$

DELIMITER ;