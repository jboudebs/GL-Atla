DELIMITER $$

/* Procédure permettant modifier le rôle d'un utilisateur */
CREATE PROCEDURE changerUtilisateurDeRole(courrielUtilisateur VARCHAR(45), ancienRole VARCHAR(45), nouveauRole VARCHAR(45)) 
BEGIN

	UPDATE Possede SET Roles_idRole=(select(idRoleParNomRole(nouveauRole)))
	WHERE Roles_idRole=(select(idRoleParNomRole(ancienRole)))
	AND Utilisateurs_idUtilisateur = (select(idUtilisateurParCourriel(courrielUtilisateur)));

END$$

DELIMITER ;