DELIMITER $$

/*  Procédure permettant de changer la date et l'heure d'un entretien à partir de
    l'ancienne heure
    le nom de la salle
    la nouvelle date et heure */
CREATE PROCEDURE changerDateHeureEntretien(IN ancienneHeure DATETIME, IN nom_Salle VARCHAR(45), IN nouvelleHeure DATETIME)
BEGIN

    DECLARE id_Salle INT;
    SELECT (idSalleParNomSalle(nom_Salle)) INTO @id_Salle;

    UPDATE Entretiens 
    SET dateHeure = nouvelleHeure 
    WHERE dateHeure = ancienneHeure AND fk_idSalle = @id_Salle;

END$$

DELIMITER ;