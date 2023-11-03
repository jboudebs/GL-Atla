/* Fichier de tests pour les différentes fonctionnalités */
/* à suivre pas à pas */

/* Inscription d'un candidat */
CALL ajoutUtilisateur("Boudebs","Julie","JulieBoudebs@mail.com","leMeilleurMDP");
CALL ajoutCandidat("JulieBoudebs@mail.com");

/* Ces deux procédures nous permettent d'avoir dans notre base une nouvelle candidate ( ici Julie Boudebs ),
Julie fait partie des tables Utilisateurs et Candidats, elle n'a fournit aucun document comme 
on peut le voir dans la table Candidats */


/* Dépot des pièces justificatives */
CALL changerDocuments("JulieBoudebs@mail.com",TRUE,TRUE,TRUE,TRUE,TRUE);

/* Cet appel permet de modifier la ligne de Julie dans la table Candidats pour préciser qu'elle a rendu les 
5 pièces justificatives nécessaires */


/* Candidat inscrit */
CALL ajoutHistStatuts("JulieBoudebs@mail.com","PatriceStruillou@mail.com","inscrit");

/* Le gestionnaire de concours Patrice Struillou a notifié que la candidate Julie était maintenant inscrite,
ce changement est inséré dans la table Hist_Statuts */

/* Candidat admissible */
CALL ajoutHistStatuts("JulieBoudebs@mail.com","PatriceStruillou@mail.com","admissible");

/* Il a par ailleurs après lecture de ses documents décrété que Julie était admissible */


/* Entretiens */
CALL ajoutEntretien("JulieBoudebs@mail.com",5,"B","2020-01-12 14:00:00","2020-01-12 15:00:00");

/* Julie a désormais un entretien de prévu le 12/01/2020 à 14h jusqu'à 15h avec le jury n°5 dans la salle "B" */


/* Suivi */
CALL afficheEntretienSelonCandidat("JulieBoudebs@mail.com");

/* Grâce à cette fonction Julie peut voir son futur entretien et se préparer convenablement */


CALL afficheEntretienSelonJury(5);

/* Par ailleurs les membres du jury 5 peuvent voir leurs futurs entretiens */

/* Modification entretien */

CALL changerDatesHeuresEntretien("2020-01-12 14:00:00","B","2020-02-12 15:00:00","2020-02-12 16:00:00");

/* Au cas où il y aurait un problème, grâce à cette procédure on peut décaler la date d'un entretien */

CALL changerSalleEntretien("2020-02-12 15:00:00","B","A");

/* Où même changer la salle si nécessaire */

/* Notation */

CALL changerNoteEntretien("2020-02-12 15:00:00","A",16);

/* Julie a donc eu 16 à son entretien */

/* Candidat admis */
CALL ajoutHistStatuts("JulieBoudebs@mail.com","PatriceStruillou@mail.com","admis");

/* Julie est donc maintenant admise dans l'école */


/* Suivi */
CALL afficheStatutSelonCandidat("JulieBoudebs@mail.com");

/* Julie peut suivre l'évolution de son statut via cette procédure */


/* Ajout de jury et jurés */
CALL ajoutJury();
CALL ajoutUtilisateurToJury("AnnieRizo@mail.com",11);
CALL ajoutUtilisateurToJury("AlanSmith@mail.com",11);
CALL ajoutUtilisateurToJury("MarkKaur@mail.com",11);

/* Cette suite de procédure permet de créer un nouveau jury et d'y ajouter trois utilisateurs Annie Rizo, Alan Smith et MarkKaur */

SELECT * FROM Jures;

/* On peut voir leur présence dans le jury 11 grâce à cette vue */


/* Ajout de rôles à un utilisateur */
SELECT * FROM UtilisateursEtRoles;

/* On peut grâce à cette vue voir les rôles de chacun des utilisateurs */

CALL ajoutRoleToUtilisateur("EricArnold@mail.com","GestionnaireDeConcours");

/* Eric Arnold était déjà enseignant et on lui ajoute grâce à cette commande le rôle de GestionnaireDeConcours */

SELECT * FROM UtilisateursEtRoles WHERE courriel="EricArnold@mail.com");

/* On peut effectivement voir les deux rôles de Eric Arnold */