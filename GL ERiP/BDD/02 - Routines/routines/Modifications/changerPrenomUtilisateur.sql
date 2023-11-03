DELIMITER $$

/* Procédure permettant de modifier le prénom d'un utilisateur */
CREATE PROCEDURE changerPrenomUtilisateur(IN mail VARCHAR(45), IN nouveauPrenomUtilisateur VARCHAR(45))
BEGIN

	UPDATE Utilisateurs 
    SET prenom = nouveauPrenomUtilisateur 
    WHERE courriel = mail;

END$$

DELIMITER ;