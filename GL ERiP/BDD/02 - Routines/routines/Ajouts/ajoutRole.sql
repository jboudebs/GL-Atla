DELIMITER $$

/*  Procédure permettant l'ajout d'un rôle à partir de
    son nom
    */
CREATE PROCEDURE ajoutRole( IN nomRole VARCHAR(45))
BEGIN

    /* On l'insère dans la table */
    INSERT INTO Roles( nomRole ) VALUES ( nomRole );

END $$

DELIMITER ;