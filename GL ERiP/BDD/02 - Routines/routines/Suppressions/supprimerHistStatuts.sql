DELIMITER $$

CREATE PROCEDURE supprimerHistStatuts(IN courriel VARCHAR(45))
BEGIN

    DECLARE idCandidat INT;

    /* On récupère l'identifiant du candidat à partir de son courriel */
    SELECT( idUtilisateurParCourriel(courriel) ) INTO @idCandidat;

	DELETE FROM Hist_Statuts
	WHERE  fk_idCandidat = @idCandidat;
END $$

DELIMITER ;