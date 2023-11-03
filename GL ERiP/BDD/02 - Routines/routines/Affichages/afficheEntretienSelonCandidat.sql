DELIMITER $$

/* 	Procédure permettant l'affichage des entretiens d'un candidat donné */
CREATE PROCEDURE afficheEntretienSelonCandidat(courriel VARCHAR(45)) 
BEGIN

    DECLARE id_Candidat INT;

    /* On récupère l'identifiant du candidat à partir de son courriel */
    SELECT( idUtilisateurParCourriel(courriel) ) INTO @id_Candidat;

	SELECT fk_idCandidat AS idCandidat, nom, prenom, Jury_idJury AS idJury, dateDebut, dateFin, nomSalle, note FROM Candidats
    INNER JOIN Entretiens ON fk_idCandidat = Candidats_idCandidat
    INNER JOIN Salles ON fk_idSalle = idSalle
    INNER JOIN Utilisateurs ON fk_idCandidat = idUtilisateur
    WHERE note IS NULL AND fk_idCandidat = @id_Candidat;

END $$


DELIMITER ;

