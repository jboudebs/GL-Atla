DELIMITER $$

/* Procédure permettant de modifier le nom de famille d'un utilisateur */
CREATE PROCEDURE changerNomUtilisateur(IN mail VARCHAR(45), IN nouveauNomUtilisateur VARCHAR(45))
BEGIN

	UPDATE Utilisateurs 
    SET nom = nouveauNomUtilisateur 
    WHERE courriel = mail;

END$$

DELIMITER ;