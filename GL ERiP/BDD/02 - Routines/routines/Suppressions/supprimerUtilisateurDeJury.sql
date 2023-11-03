DELIMITER $$

/*  Procédure permettant de retirer un utilisateur d'un jury
    son courriel
    et de l'id du jury
    */
CREATE PROCEDURE supprimerUtilisateurDeJury(IN courriel VARCHAR(45), IN idJury INT)
BEGIN

    DECLARE idUtilisateur INT;

    /* On récupère l'identifiant du candidat à partir de son courriel */
    SELECT( idUtilisateurParCourriel(courriel) ) INTO @idUtilisateur;

	DELETE FROM Fait_Partie_De
	WHERE  Jury_idJury = idJury AND Utilisateurs_idUtilisateur = @idUtilisateur;

END $$

DELIMITER ;