
DELIMITER $$

/* Procédure permettant de modifier le nom de famille et le prenom d'un utilisateur */
CREATE PROCEDURE changerNomPrenomUtilisateur(IN mail VARCHAR(45), IN nouveauNomUtilisateur VARCHAR(45), IN nouveauPrenomUtilisateur VARCHAR(45))
BEGIN

		CALL changerNomUtilisateur(mail, nouveauNomUtilisateur) ;
		CALL changerPrenomUtilisateur(mail, nouveauPrenomUtilisateur);
END$$

DELIMITER ;