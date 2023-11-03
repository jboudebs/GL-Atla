DELIMITER $$

/*  Fonction permettant de récupérer l'identifiant d'un utilisateur à partir de
    son courriel */
CREATE FUNCTION idUtilisateurParCourriel(courrielUtilisateur VARCHAR(45)) RETURNS INT
BEGIN

    /* si courriel est dans la table */
    IF EXISTS ( SELECT idUtilisateur FROM Utilisateurs WHERE courriel=courrielUtilisateur ) THEN
        RETURN ( SELECT idUtilisateur FROM Utilisateurs WHERE courriel=courrielUtilisateur );
    ELSE
        CALL raiseError("Le courriel n existe pas.");
    END IF;

END $$

DELIMITER ;