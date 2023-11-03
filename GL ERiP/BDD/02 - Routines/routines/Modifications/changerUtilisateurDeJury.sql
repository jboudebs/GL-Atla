DELIMITER $$

/*  Procédure permettant de changer à quel jury appartient un utlisateur à partir de
    son courriel
    l'id de son ancien jury
    et le nouvel id
    */
CREATE PROCEDURE changerUtilisateurDeJury( IN courriel VARCHAR(45), IN ancienIdJury INT, IN nouvelIdJury INT)
BEGIN

    DECLARE idUtilisateur INT;

    /* On récupère l'identifiant de l'utilisateur à partir de son courriel */
    SELECT( idUtilisateurParCourriel(courriel) ) INTO @idUtilisateur;

    /* On l'insère dans la table */
    UPDATE Fait_Partie_De SET Jury_idJury = nouvelIdJury 
    WHERE Jury_idJury = ancienIdJury AND Utilisateurs_idUtilisateur = @idUtilisateur;

END $$

DELIMITER ;