delimiter //

DROP TRIGGER test_rem_insert //
DROP TRIGGER test_rem_update //
DROP PROCEDURE verif //


CREATE TRIGGER test_rem_insert 
BEFORE INSERT
ON Fournisseur 
FOR EACH ROW CALL verif(new.remise);

//


CREATE TRIGGER test_rem_update 
BEFORE UPDATE
ON Fournisseur 
FOR EACH ROW CALL verif(new.remise);

//

CREATE PROCEDURE verif(nb INT)
BEGIN
	DECLARE remise_trop_elevee CONDITION FOR SQLSTATE '45000';
	IF nb>50 THEN
		SIGNAL remise_trop_elevee 
		SET MESSAGE_TEXT = 'La remise doit être inférieure à 50%';
	END IF;
END;

//


delimiter ;
