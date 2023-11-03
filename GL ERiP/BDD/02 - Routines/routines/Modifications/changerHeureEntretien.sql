DELIMITER $$

/*  Procédure permettant de changer l'heure d'un entretien à partir de
    l'ancienne heure
    le nom de la salle
    la nouvelle heure */
CREATE PROCEDURE changerHeureEntretien(IN ancienneHeure DATETIME, IN nom_Salle VARCHAR(45), IN nouvelleHeure TIME)
BEGIN

    DECLARE id_Salle INT;
    SELECT (idSalleParNomSalle(nom_Salle)) INTO @id_Salle;
    UPDATE Entretiens SET dateHeure=concat(concat(DATE(dateHeure)," "), nouvelleHeure) 
    WHERE dateHeure = ancienneHeure AND fk_idSalle = @id_Salle;

END$$

DELIMITER ;