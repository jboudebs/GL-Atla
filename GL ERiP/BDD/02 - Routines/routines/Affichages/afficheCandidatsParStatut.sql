DELIMITER $$

/* 	Procédure permettant l'affichage des candidats selon
	leur statut */
CREATE PROCEDURE afficheCandidatsParStatut(statutCandidat VARCHAR(45)) 
BEGIN

	SELECT * FROM Candidats, Hist_Statuts 
	WHERE Candidats.fk_idCandidat = Hist_Statuts.fk_idCandidat
	AND Hist_Statuts.statut=statutCandidat;

END $$


DELIMITER ;