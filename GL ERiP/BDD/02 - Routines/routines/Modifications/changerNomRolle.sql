DELIMITER $$

/* Procédure permettant de modifier le nom d'un rôle */
CREATE PROCEDURE changerNomRole(IN role INT , IN nouveauNomRole VARCHAR(45))
BEGIN

	UPDATE Roles 
    SET nomRole = nouveauNomRole 
    WHERE idRole = role;

END$$

DELIMITER ;