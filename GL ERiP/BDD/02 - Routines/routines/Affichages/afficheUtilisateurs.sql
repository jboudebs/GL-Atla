DELIMITER $$

/*  Procédure permettant l'affichage de tous les utilisateurs */
CREATE PROCEDURE afficheUtilisateurs() 
BEGIN

	SELECT * FROM Utilisateurs;

END$$


DELIMITER ;