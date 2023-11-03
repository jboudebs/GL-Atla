DELIMITER $$

/*  Procédure permettant de changer la date d'un entretien à partir de
    l'ancienne heure
    le nom de la salle
    la nouvelle salle */
CREATE PROCEDURE changerSalleEntretien(IN heure DATETIME, IN nom_Salle VARCHAR(45), IN nomNouvelleSalle VARCHAR(45))
BEGIN

    DECLARE id_Salle INT;
    DECLARE id_NouvelleSalle INT;

    SELECT (idSalleParNomSalle(nom_Salle)) INTO @id_Salle;
    SELECT (idSalleParNomSalle(nomNouvelleSalle)) INTO @id_NouvelleSalle;

	UPDATE Entretiens 
    SET fk_idSalle = @id_NouvelleSalle 
    WHERE dateHeure = heure AND fk_idSalle = @id_Salle;

END$$

DELIMITER ;