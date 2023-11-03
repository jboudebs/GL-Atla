DELIMITER $$

/*  Procédure supprimant un candidat à partir de 
    son courriel
    */
CREATE PROCEDURE supprimerCandidat(IN courriel VARCHAR(45))
BEGIN

    DECLARE idUtilisateur INT;

    /* On récupère l'identifiant de l'utilisateur à partir de son courriel */
    SELECT( idUtilisateurParCourriel(courriel) ) INTO @idUtilisateur;
   
	IF ( (SELECT( estRole(@idUtilisateur,"Candidat") ) != TRUE ) THEN
        call raiseError("Cet utilisateur n est pas un candidat");
    END IF;

    DELETE FROM Candidats WHERE fk_idCandidat = @idUtilisateur;

END $$

DELIMITER ;

