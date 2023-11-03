DELIMITER $$

/*  Procédure permettant de changer la date d'un entretien à partir de
    l'ancienne heure
    le nom de la salle
    la nouvelle date */
CREATE PROCEDURE changerDateEntretien(IN ancienneHeure DATETIME, IN nom_Salle VARCHAR(45), IN nouvelleDate DATE)
BEGIN

    DECLARE id_Salle INT;
	SELECT (idSalleParNomSalle(nom_Salle)) INTO @id_Salle;

	UPDATE Entretiens
    SET dateHeure = CONCAT( CONCAT (nouvelleDate," "), TIME(ancienneHeure) ) 
    WHERE dateHeure = ancienneHeure AND fk_idSalle =  @id_Salle;


END $$

DELIMITER ;