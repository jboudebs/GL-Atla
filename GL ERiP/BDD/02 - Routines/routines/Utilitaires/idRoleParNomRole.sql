DELIMITER $$

/*  Fonction permettant de récupérer l'identifiant d'un rôle à partir de
    son nom */
CREATE FUNCTION idRoleParNomRole(nom_Role VARCHAR(45)) RETURNS INT
BEGIN

    /* si nom_Role est dans la table */
    IF EXISTS ( SELECT idRole FROM Roles WHERE nomRole=nom_Role ) THEN
        RETURN ( SELECT idRole FROM Roles WHERE nomRole=nom_Role );
    ELSE
        CALL raiseError("Le role n existe pas.");
    END IF;

END $$

DELIMITER ;