DELIMITER $$

/*  Fonction retournant true si l'utilisateur possède le role nom_Role
    false sinon */
CREATE FUNCTION estRole(id_Utilisateur INT, nom_Role VARCHAR(45) ) RETURNS BOOLEAN
BEGIN

    IF ( id_Utilisateur IN ( SELECT idUtilisateur FROM UtilisateursEtRoles WHERE nomRole = nom_Role ) ) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END $$

DELIMITER ;