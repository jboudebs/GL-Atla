DELIMITER $$

/*  Procédure permettant l'ajout d'un utilisateur à un jury à partir de
    son courriel et
    l'identifiant du jury
    */
CREATE PROCEDURE ajoutUtilisateurToJury( IN courriel VARCHAR(45), IN idJury INT )
BEGIN

    DECLARE idUtilisateur INT;

    /* On récupère l'identifiant de l'utilisateur à partir de son courriel */
    SELECT( idUtilisateurParCourriel(courriel) ) INTO @idUtilisateur;

    /* On l'insère dans la table */
    INSERT INTO Fait_Partie_De ( Jury_idJury, Utilisateurs_idUtilisateur ) VALUES ( idJury, @idUtilisateur );

END $$

DELIMITER ;