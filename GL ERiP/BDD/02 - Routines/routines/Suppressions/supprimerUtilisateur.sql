DELIMITER $$

/*  Procédure permettant de supprimer un utilisateur à partir de
    son courriel */
CREATE PROCEDURE supprimerUtilisateur(mail VARCHAR(45))
BEGIN

	DELETE FROM Utilisateurs
	WHERE courriel = mail;

END $$

DELIMITER ;