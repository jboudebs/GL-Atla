/* Tests triggers table Entretiens */
SELECT * FROM Entretiens;

-- Test : la date choisie est supérieure à la date actuelle
INSERT INTO Entretiens VALUES(3, 10, "2018-12-14 08:00:00", "2018-12-14 08:30:00", 1, 20);
-- Error Code: 1644. Date entretien inferieure a la date courante
INSERT INTO Entretiens VALUES(3, 10, "2018-12-14 08:00:00", "2018-12-14 08:00:00", 1, 20);
-- Error Code: 1644. Date entretien inferieure a la date courante

-- Test : la date de début est inférieur à la date de fin
INSERT INTO Entretiens VALUES(3, 10, "2020-12-14 09:00:00", "2020-12-14 08:30:00", 1, 20);
-- Error Code: 1644. Date début entretiens inferieure a la date de fin

-- Test : les horraires sont entre 8h et 18h
INSERT INTO Entretiens VALUES(3, 10, "2020-12-14 06:00:00", "2020-12-14 08:30:00", 1, 20);
-- Error Code: 1644. Horaires entretiens : 8h-18h
INSERT INTO Entretiens VALUES(3, 10, "2020-12-14 18:00:00", "2020-12-14 20:00:00", 1, 20);
-- Error Code: 1644. Horaires entretiens : 8h-18h

-- Test : les notes sont entre 0 et 20
INSERT INTO Entretiens VALUES(3, 10, "2020-12-14 08:00:00", "2020-12-14 08:30:00", 1, 21);
-- Error Code: 1644. Notes entre 0 et 20
INSERT INTO Entretiens VALUES(3, 10, "2020-12-14 08:00:00", "2020-12-14 08:30:00", 1, -1);
-- Error Code: 1644. Notes entre 0 et 20

-- Test : vérifier si les dates d'un entretien n'empiètent pas sur l'entretien d'un même jury
INSERT INTO Entretiens VALUES(7, 10, "2020-01-01 09:00:00", "2020-01-01 09:15:00", 2, 18);
-- OK
INSERT INTO Entretiens VALUES(12, 10, "2020-01-01 09:00:00", "2020-01-01 09:15:00", 3, 18);
-- Error Code: 1644. Jury non disponible
INSERT INTO Entretiens VALUES(27, 10, "2020-01-01 08:30:00", "2020-01-01 09:10:00", 4, 18);
-- Error Code: 1644. Jury non disponible
INSERT INTO Entretiens VALUES(29, 10, "2020-01-01 09:10:00", "2020-01-01 09:30:00", 5, 18);
-- Error Code: 1644. Jury non disponible

-- Test : vérifier si les dates d'un entretien n'empiètent pas sur l'entretien d'un même candidat
INSERT INTO Entretiens VALUES(3, 2, "2020-01-01 09:00:00", "2020-01-01 09:15:00", 6, 18);
-- OK
INSERT INTO Entretiens VALUES(3, 3, "2020-01-01 09:00:00", "2020-01-01 09:15:00", 7, 18);
-- Error Code: 1644. Candidat non disponible
INSERT INTO Entretiens VALUES(3, 4, "2020-01-01 08:30:00", "2020-01-01 09:10:00", 8, 18);
-- Error Code: 1644. Candidat non disponible
INSERT INTO Entretiens VALUES(3, 5, "2020-01-01 09:10:00", "2020-01-01 09:30:00", 9, 18);
-- Error Code: 1644. Candidat non disponible

-- Test : vérifier si l'entretien ne se passe pas dans la même salle au même moment
INSERT INTO Entretiens VALUES(12, 1, "2020-01-02 09:00:00", "2020-01-02 09:15:00", 6, 18);
-- OK
INSERT INTO Entretiens VALUES(17, 2, "2020-01-02 09:00:00", "2020-01-02 09:15:00", 6, 18);
-- Error Code: 1644. Salle non disponible
INSERT INTO Entretiens VALUES(27, 3, "2020-01-02 09:00:00", "2020-01-02 09:15:00", 6, 18);
-- Error Code: 1644. Salle non disponible
INSERT INTO Entretiens VALUES(28, 4, "2020-01-02 09:00:00", "2020-01-02 09:15:00", 6, 18);
-- Error Code: 1644. Salle non disponible

/* Les mêmes tests sont possibles sur les modifications */



/* Tests trigger table Candidats */
SELECT * FROM Candidats;

-- Test : un utilisateur ayant déjà un rôle ne peut pas être candidat
INSERT INTO Candidats (fk_idCandidat) VALUES(5);
-- Error Code: 1644. Cet utilisateur possède déjà un rôle

-- Test : un utilisateur ajouté dans la table Candidat obtient le rôle candidat dans la table Possede
CALL ajoutUtilisateur("Boudebs","Julie","JulieBoudebs@mail.com","leMeilleurMDP"); -- commande à réaliser si cela n'a pas été fait dans tests_fonctionnalites.sql
CALL ajoutCandidat("JulieBoudebs@mail.com"); -- de même

SELECT * FROM UtilisateursEtRoles WHERE courriel="JulieBoudebs@mail.com";
-- OK : on retrouve bien Julie Boudebs dans la table Possede avec le rôle Candidat

-- Test : il est impossible de modifier l'identifiant d'un candidat depuis la table Candidat
UPDATE Candidats SET fk_idCandidat = 5 WHERE fk_idCandidat = 3;
-- 0 Error Code: 1644. Impossible de modifier un identifiant de candidat sur cette table

-- Test : si on supprime un candidat de la table Candidat, son rôle est supprimé ( dans la table possede )
CALL supprimerCandidat("JulieBoudebs@mail.com");

SELECT * FROM UtilisateursEtRoles WHERE courriel="JulieBoudebs@mail.com";
-- OK : il n'y a plus Julie dans la table possede



/* Tests trigger table Fait_Partie_De */
SELECT * FROM Fait_Partie_De;

-- Test : insérer un candidat dans un jury
INSERT INTO Fait_Partie_De VALUES(8,3); -- candidat n°3 dans le jury 8
-- Error Code: 1644. Cet utilisateur ne peut pas faire parti d'un jury

-- Test : insérer un étudiant dans un jury
INSERT INTO Fait_Partie_De VALUES(8,39); -- etudiant n°39 dans le jury 8
-- Error Code: 1644. Cet utilisateur ne peut pas faire parti d'un jury

-- Test : un jury ne peut pas être composé de plus de 5 utilisateurs
INSERT INTO Fait_Partie_De VALUES(2,87); -- il y a déjà 5 utlisateurs dans le jury 2
-- Error Code: 1644. Le jury est plein

-- Test : un utilisateur ne peut appartenir qu'à un seul jury
INSERT INTO Fait_Partie_De VALUES(3,1); -- l'utilisateur 1 est déjà dans le jury 1
-- Error Code: 1644. Cet utilisateur fait déjà parti d'un jury

/* Les mêmes tests sont possibles sur les modifications */


/* Tests triggers table Hist_Statuts */

-- Test : l'utilisateur qui procède au changement de statut doit être un gestionnaire de concours ou de la scolarité
CALL ajoutHistStatuts("JulieBoudebs@mail.com","EvelynClark@mail.com","inscrit"); -- Evelyn Clark possède le rôle Admin
-- Eror Code: 1644. Cet utilisateur ne possède pas le rôle nécessaire pour changer un candidat de statut.

-- Test : un candidat doit être inscrit avant d'être admissible ou admis */
CALL ajoutHistStatuts("JulieBoudebs@mail.com","PatriceStruillou@mail.com","admissible");
-- Error Code: 1644. Un candidat doit être inscrit avant admissible ou admis
CALL ajoutHistStatuts("JulieBoudebs@mail.com","PatriceStruillou@mail.com","admis");
-- Error Code: 1644. Un candidat doit être inscrit avant admissible ou admis

-- Test un candidat doit être admissble avant d'être admis */
CALL ajoutHistStatuts("JulieBoudebs@mail.com","PatriceStruillou@mail.com","inscrit");
CALL ajoutHistStatuts("JulieBoudebs@mail.com","PatriceStruillou@mail.com","admis");
-- Error Code: 1644. Un candidat doit être admissible avant d'être admis


/* Tests triggers table Possede */

-- Test : un utilisateur étant déjà candidat ou étudiant ne peut pas avoir d'autre rôle
INSERT INTO Possede VALUES (1, 34); -- l'utilisateur 34 est déjà candidat
-- Error Code: 1644. Cet utilisateur ne peut pas avoir un autre rôle
INSERT INTO Possede VALUES (1, 14); -- l'utilisateur 34 est déjà étudiant
-- Error Code: 1644. Cet utilisateur ne peut pas avoir un autre rôle



/* Tests triggers table Utilisateurs */

-- Test : le courriel doit avoir une forme valide
CALL ajoutUtilisateur("Boudebs","Julie","JulieBoudebs@mail.","leMeilleurMDP");
-- Error Code: 1644. courriel invalide
CALL ajoutUtilisateur("Boudebs","Julie","Juliemail.com","leMeilleurMDP");
-- Error Code: 1644. courriel invalide
CALL ajoutUtilisateur("Boudebs","Julie","Boudebs@.com","leMeilleurMDP");
-- Error Code: 1644. courriel invalide

/* Les mêmes tests sont possibles sur les modifications */