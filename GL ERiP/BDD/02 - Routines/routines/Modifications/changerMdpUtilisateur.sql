DELIMITER $$

/* Procédure permettant de modifier le mot de passe d'un utilisateur */
CREATE PROCEDURE changerMdpUtilisateur(IN mail char(45), IN mdp varchar(45))
BEGIN

    DECLARE salt CHAR(32);
    DECLARE mdpHash CHAR(32);
    DECLARE mdpToHash VARCHAR(100);

    /* On récupère le sel */
    SELECT motDePasse_salt FROM Utilisateurs WHERE courriel = mail INTO @salt;
    SELECT CONCAT(mdp,@salt) INTO @mdpToHash;
    /* On hache le nouveau mdp */
    SELECT md5(@mdpToHash) INTO @mdpHash;

   

    /* On modifie la table */
    UPDATE Utilisateurs SET motDePasse_hash=@mdpHash WHERE courriel = mail;  
    UPDATE Utilisateurs SET motDePasse_salt=@salt WHERE courriel = mail;   
    
END$$

DELIMITER ;