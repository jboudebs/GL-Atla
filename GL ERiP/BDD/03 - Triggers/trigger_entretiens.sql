CREATE DEFINER = CURRENT_USER TRIGGER `ProjetBDD`.`Entretiens_BEFORE_INSERT` BEFORE INSERT ON `Entretiens` FOR EACH ROW
BEGIN
	IF NEW.dateDebut < CURRENT_TIMESTAMP() OR NEW.dateFin < CURRENT_TIMESTAMP() THEN
		call raiseError('Date entretien inferieure a la date courante');
	END IF;
	IF NEW.dateDebut >= NEW.dateFin THEN
		call raiseError('Date début entretien inferieure a la date de fin');
	END IF;
	IF TIME(NEW.dateDebut) NOT BETWEEN '08:00:00' AND '18:00:00' OR TIME(NEW.dateFin) NOT BETWEEN '08:00:00' AND '18:00:00' THEN
		call raiseError('Horaires entretiens : 8h-18h');
	END IF;
    IF (NEW.note < 0 OR NEW.note > 20) THEN
		call raiseError('Notes entre 0 et 20');
	END IF;
    IF (EXISTS(SELECT * FROM Entretiens WHERE Jury_idJury = NEW.Jury_idJury AND ((NEW.dateDebut BETWEEN dateDebut AND dateFin) OR (NEW.dateFin BETWEEN dateDebut AND dateFin)))) THEN
		call raiseError('Jury non disponible');
	END IF;
	IF (EXISTS(SELECT * FROM Entretiens WHERE Candidats_idCandidat = NEW.Candidats_idCandidat AND ((NEW.dateDebut BETWEEN dateDebut AND dateFin) OR (NEW.dateFin BETWEEN dateDebut AND dateFin)))) THEN
		call raiseError('Candidat non disponible');
	END IF;
    IF (EXISTS(SELECT * FROM Entretiens WHERE fk_idSalle = NEW.fk_idSalle AND ((NEW.dateDebut BETWEEN dateDebut AND dateFin) OR (NEW.dateFin BETWEEN dateDebut AND dateFin)))) THEN
		call raiseError('Salle non disponible');
	END IF;
END