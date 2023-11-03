DELIMITER $$

/*  Procédure permettant de retirer le rôle d'un utilisateur à partir de
    son courriel
    et du nom du rôle
    */
CREATE PROCEDURE supprimerRoleUtilisateur(IN courriel VARCHAR(45), IN nomRole VARCHAR(45))
BEGIN

    DECLARE idUtilisateur INT;
    DECLARE idRole INT;

    /* On récupère l'identifiant du candidat à partir de son courriel */
    SELECT( idUtilisateurParCourriel(courriel) ) INTO @idUtilisateur;

    /* On récupère l'identifiant du role à partir de son nom */
    SELECT( idRoleParNomRole( nomRole ) ) INTO @idRole;

	DELETE FROM Possede
	WHERE  Roles_idRole = @idRole AND Utilisateurs_idUtilisateur = @idUtilisateur;

END $$

DELIMITER ;