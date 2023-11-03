DELIMITER $$

/*  Procédure permettant l'ajout d'un candidat à partir de
    courriel
    */
CREATE PROCEDURE ajoutCandidat(IN courriel VARCHAR(45))
BEGIN

    /* On récupère l'identifiant du candidat à partir de son courriel */
    DECLARE idCandidat INT;
    SELECT( idUtilisateurParCourriel(courriel) ) INTO @idCandidat;

    /* On l'insère dans la table */
    INSERT INTO Candidats( fk_idCandidat ) VALUES ( @idCandidat );

END $$

DELIMITER ;