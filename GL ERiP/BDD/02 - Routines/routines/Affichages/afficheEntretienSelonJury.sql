DELIMITER $$

/* 	Procédure permettant l'affichage des entretiens d'un jury donné */
CREATE PROCEDURE afficheEntretienSelonJury(id_Jury INT) 
BEGIN

	SELECT Jury_idJury AS idJury, fk_idCandidat AS idCandidat, nom, prenom, dateDebut, dateFin, nomSalle, note FROM Candidats
    INNER JOIN Entretiens ON fk_idCandidat = Candidats_idCandidat
    INNER JOIN Salles ON fk_idSalle = idSalle
    INNER JOIN Utilisateurs ON fk_idCandidat = idUtilisateur
    WHERE note IS NULL AND Jury_idJury = id_Jury;

END $$


DELIMITER ;

