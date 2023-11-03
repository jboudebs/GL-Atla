DELIMITER $$

/*  Procédure permettant de supprimer un entretien à partir de
    son heure
    et sa salle
    */
CREATE PROCEDURE supprimerEntretien(IN date DATETIME, IN nomSalle VARCHAR(45))
BEGIN

    DECLARE idSalle INT;

    /* On récupère l'identifiant de la salle à partir de son nom */
    SELECT( idSalleParNomSalle(nomSalle) ) INTO @idSalle;

	DELETE FROM Entretiens
	WHERE  dateHeure = date
	AND    fk_idSalle = @idSalle;

END $$

DELIMITER ;