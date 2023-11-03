delimiter //

DROP PROCEDURE inc20 //


CREATE PROCEDURE inc20(four VARCHAR(3))
BEGIN
	UPDATE Fourniture SET quantite=quantite+20 WHERE quantite<5 AND fournisseur=four;
END;

//


delimiter ;
