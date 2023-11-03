DELIMITER $$

/*  Procédure permettant de supprimer un rôle à partir de
    son nom
    */
CREATE PROCEDURE supprimerRole(role VARCHAR(45))
BEGIN

	DELETE FROM Roles
	WHERE nomRole = role;

END $$

DELIMITER ;