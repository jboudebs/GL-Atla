DELIMITER $$

/*  Procédure permettant l'ajout d'un jury
    */
CREATE PROCEDURE ajoutJury()
BEGIN

    /* On l'insère dans la table */
    INSERT INTO Jury( idJury ) VALUES ( NULL );

END $$

DELIMITER ;