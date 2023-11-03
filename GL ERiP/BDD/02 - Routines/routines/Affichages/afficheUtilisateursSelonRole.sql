DELIMITER $$

/*  Procédure permettant l'affichage de tous les utilisateurs selon
    leur rôle */
CREATE PROCEDURE afficheUtilisateursSelonRole(In nomRole VARCHAR(45)) 
BEGIN

    DECLARE idRole INT;

    /* On récupère l'identifiant du rôle à partir de son nom */
    SELECT( idRoleParNomRole(nomRole) ) INTO @idRole;

	SELECT * FROM Utilisateurs
	WHERE idUtilisateur IN ( SELECT Utilisateurs_idUtilisateur FROM Possede WHERE Roles_idRole = @idRole );

END $$

DELIMITER ;