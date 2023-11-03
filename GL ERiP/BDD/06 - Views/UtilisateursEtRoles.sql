CREATE VIEW UtilisateursEtRoles
AS  SELECT idUtilisateur, nom, prenom, courriel, nomRole FROM Utilisateurs
    INNER JOIN Possede ON Utilisateurs_idUtilisateur = idUtilisateur
    INNER JOIN Roles ON Roles_idRole = idRole
    ORDER BY nomRole;
