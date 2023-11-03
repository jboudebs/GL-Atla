DELIMITER $$

/*  Procédure permettant l'ajout d'un entretien à partir
    d'un courriel de candidat
    d'un id de jury
    une heure
    une salle
    */
CREATE PROCEDURE ajoutEntretien( IN courriel VARCHAR(45), IN idJury INT, IN nomSalle VARCHAR(45), IN dateDebut DATETIME, IN dateFin DATETIME  )
BEGIN

    DECLARE idCandidat INT;
    DECLARE idSalle INT;

    /* On récupère l'identifiant de l'utilisateur à partir de son courriel */
    SELECT( idUtilisateurParCourriel(courriel) ) INTO @idCandidat;

    /* On récupère l'identifiant de la salle à partir de son nom */
    SELECT( idSalleParNomSalle(nomSalle) ) INTO @idSalle;

    /* On l'insère dans la table */
    INSERT INTO Entretiens ( Candidats_idCandidat, Jury_idJury, dateDebut, dateFin, fk_idSalle ) VALUES ( @idCandidat, idJury, dateDebut, dateFin, @idSalle );

END $$

DELIMITER ;