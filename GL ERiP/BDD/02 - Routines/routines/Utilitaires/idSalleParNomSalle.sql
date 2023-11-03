DELIMITER $$

/*  Fonction permettant de récupérer l'identifiant d'une salle à partir de
    son nom */
CREATE FUNCTION idSalleParNomSalle(nom_Salle VARCHAR(45)) RETURNS INT
BEGIN

    /* si nom_Salle est dans la table */
    IF EXISTS ( SELECT idSalle FROM Salles WHERE nomSalle=nom_Salle ) THEN
        RETURN ( SELECT idSalle FROM Salles WHERE nomSalle=nom_Salle );
    ELSE
        CALL raiseError("La salle n existe pas.");
    END IF;

END $$

DELIMITER ;