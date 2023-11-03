DELIMITER $$

/*  Procédure permettant l'ajout d'une d'une salle à partir de
    son nom
    */
CREATE PROCEDURE ajoutSalle( IN nomSalle VARCHAR(45))
BEGIN

    /* On l'insère dans la table */
    INSERT INTO Salles( nomSalle ) VALUES ( nomSalle );

END $$

DELIMITER ;