DELIMITER $$

/* Procédure permettant de préciser si un document a été fournit ou non */
CREATE PROCEDURE changerDocuments(IN courriel VARCHAR(45), IN cv BOOLEAN, IN lm BOOLEAN, in cni BOOLEAN, IN rlv1 BOOLEAN, IN rlv2 BOOLEAN)
BEGIN

    DECLARE idCandidat INT;

    /* On récupère l'identifiant du candidat à partir de son courriel */
    SELECT( idUtilisateurParCourriel(courriel) ) INTO @idCandidat;

	UPDATE Candidats 
    SET CV = cv, LM = lm, CNI = cni, releve1 = rlv1, releve2 = rlv2
    WHERE fk_idCandidat = 102;

END$$

DELIMITER ;

