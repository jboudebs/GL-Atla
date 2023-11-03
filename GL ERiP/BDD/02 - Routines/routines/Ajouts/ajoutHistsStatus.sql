DELIMITER $$

/*  Procédure permettant le changement du statut d'un candidat à partir de
    son courriel
    le courriel du gestionnaire
    */
CREATE PROCEDURE ajoutHistStatus( IN courrielCandidat VARCHAR(45), IN courrielGestionnaire VARCHAR(45), IN nouveauStatut VARCHAR(45) )
BEGIN

    DECLARE idCandidat INT;
    DECLARE idGestionnaire INT;
    DECLARE dateActuelle DATETIME;

    /* On récupère l'identifiant du candidat à partir de son courriel */
    SELECT( idUtilisateurParCourriel(courrielCandidat) ) INTO @idCandidat;

    /* On récupère l'identifiant du gestionnaire à partir de son courriel */
    SELECT( idUtilisateurParCourriel(courrielGestionnaire) ) INTO @idGestionnaire;

    SELECT NOW() INTO @dateActuelle;

    /* On l'insère dans la table */
    INSERT INTO Hist_Statuts ( fk_idCandidat, fk_idUtilisateur_update, statut, date ) VALUES ( @idCandidat, @idGestionnaire, nouveauStatut, @dateActuelle );

END $$

DELIMITER ;