DELIMITER $$

/*  Procédure permettant l'ajout d'un utilisateur à partir de
    nom
    prenom
    courriel
    mdp ( en clair )
    */
CREATE PROCEDURE ajoutUtilisateur( IN nom VARCHAR(45), IN prenom VARCHAR(45), IN courriel VARCHAR(45), IN mdp VARCHAR(50) )
BEGIN

    DECLARE salt CHAR(32);
    DECLARE mdpHash CHAR(32);
    DECLARE mdpToHash VARCHAR(100);


    /* On créer un sel et on hash le mdp */
    SELECT RandString(32) INTO @salt;
    SELECT CONCAT(mdp,@salt) INTO @mdpToHash;
    SELECT md5(@mdpToHash) INTO @mdpHash;

    /* On l'insère dans la table */
    INSERT INTO Utilisateurs( nom, prenom, courriel, motDePasse_hash, motDePasse_salt) VALUES
    ( nom, prenom, courriel, @mdpHash, @salt );


END $$

DELIMITER ;