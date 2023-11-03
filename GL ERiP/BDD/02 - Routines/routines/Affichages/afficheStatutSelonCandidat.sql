DELIMITER $$

/* 	Procédure permettant l'affichage des candidats selon
	leur statut */
CREATE PROCEDURE afficheStatutSelonCandidat(courriel VARCHAR(45)) 
BEGIN

	DECLARE id_Candidat INT;

    /* On récupère l'identifiant du candidat à partir de son courriel */
	SELECT( idUtilisateurParCourriel(courriel) ) INTO @id_Candidat;


    SELECT fk_idCandidat as idCandidat, nom, prenom, fk_idUtilisateur_update AS Gestionnaire, statut, date FROM Hist_Statuts
	INNER JOIN Utilisateurs ON fk_idCandidat = idUtilisateur
	WHERE fk_idCandidat = @id_Candidat;

END $$


DELIMITER ;