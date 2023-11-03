DELIMITER $$

/* Procédure permettant l'affichage de tous les candidats */
CREATE PROCEDURE afficheCandidats() 
BEGIN

	SELECT * FROM Candidats;

END $$


DELIMITER ;