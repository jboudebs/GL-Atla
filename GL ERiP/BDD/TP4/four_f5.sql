delimiter //

DROP TRIGGER four_f5_insert //
DROP TRIGGER four_f5_update //
DROP PROCEDURE verification //


CREATE TRIGGER four_f5_insert
BEFORE INSERT
ON Fourniture 
FOR EACH ROW 
IF new.fournisseur = 'f5' THEN
CALL verification(new.produit);
END IF

//


CREATE TRIGGER four_f5_update
BEFORE UPDATE
ON Fourniture 
FOR EACH ROW 
IF new.fournisseur = 'f5' THEN
CALL verification(new.produit);
END IF

//

CREATE PROCEDURE verification(prod VARCHAR(3))
BEGIN
	DECLARE mauvaise_origine CONDITION FOR SQLSTATE '45000';
	IF (SELECT Produit.origine FROM Produit WHERE id=prod) != 'Riec' THEN
		SIGNAL mauvaise_origine 
		SET MESSAGE_TEXT = 'Le produit ne vient pas de Riec';
	END IF;
END;

//


delimiter ;
