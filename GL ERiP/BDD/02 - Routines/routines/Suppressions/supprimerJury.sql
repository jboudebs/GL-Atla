DELIMITER $$

/* 	Procédure permettant de supprimer un jury à partir de
	son id
	*/
CREATE PROCEDURE supprimerJury(numJury INT)
BEGIN

	DELETE FROM Jury
	WHERE  idJury = numJury;

END $$

DELIMITER ;