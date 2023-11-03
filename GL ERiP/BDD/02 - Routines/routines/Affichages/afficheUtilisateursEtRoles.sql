DELIMITER $$

/*  Procédure permettant l'affichage de tous les utilisateurs et leurs rôles respectifs */
CREATE PROCEDURE afficheUtilisateursEtRoles() 
BEGIN

SELECT idUtilisateur, nom, prenom, courriel, nomRole FROM Utilisateurs
INNER JOIN Possede ON Utilisateurs_idUtilisateur = idUtilisateur
INNER JOIN Roles ON Roles_idRole = idRole
ORDER BY nomRole;

END $$


DELIMITER ;