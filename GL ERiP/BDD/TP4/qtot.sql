delimiter //

DROP FUNCTION qtot //


CREATE FUNCTION qtot(four VARCHAR(3)) RETURNS INT
BEGIN
	RETURN (SELECT SUM(quantite) FROM Fourniture WHERE fournisseur=four);
END;

//


delimiter ;
