DELIMITER $$

/*  Fonction permettant de récupérer une chaine de caractère aléatoire de taille
    length */
CREATE FUNCTION RandString(length INT) RETURNS VARCHAR(100)
BEGIN

    SET @returnStr = '';
    SET @allowedChars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    SET @i = 0;

    WHILE (@i < length) DO
        SET @returnStr = CONCAT(@returnStr, substring(@allowedChars, FLOOR(RAND() * LENGTH(@allowedChars) + 1), 1));
        SET @i = @i + 1;
    END WHILE;

    RETURN @returnStr;
END $$

DELIMITER ;