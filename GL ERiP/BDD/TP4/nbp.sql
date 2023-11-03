delimiter //

DROP FUNCTION nbp //


CREATE FUNCTION nbp(four VARCHAR(3)) RETURNS INT
BEGIN
	RETURN (SELECT COUNT(produit) FROM Fourniture WHERE fournisseur=four);
END;

//


delimiter ;
