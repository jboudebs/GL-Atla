DELIMITER $$

/*  Procédure permettant l'ajout d'un rôle à un utilisateur à partir de
    son courriel et
    le nom du rôle
    */
CREATE PROCEDURE ajoutRoleToUtilisateur( IN courriel VARCHAR(45), IN nomRole VARCHAR(45) )
BEGIN

    DECLARE idUtilisateur INT;
    DECLARE idRole INT;

    /* On récupère l'identifiant de l'utilisateur à partir de son courriel */
    SELECT( idUtilisateurParCourriel(courriel) ) INTO @idUtilisateur;

    /* On récupère l'identifiant du rôle à partir de son nom */
    SELECT( idRoleParNomRole(nomRole) ) INTO @idRole;

    /* On l'insère dans la table */
    INSERT INTO Possede ( Roles_idRole, Utilisateurs_idUtilisateur ) VALUES ( @idRole, @idUtilisateur );

END $$

DELIMITER ;