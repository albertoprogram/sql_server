-- Email validator / Validador de email

-- IMPORTANT / IMPORTANTE
-- This script is tested on the Modern_Spanish_CI_AS collation
-- Este script está probado sobre el collation Modern_Spanish_CI_AS

-- Developed and tested by: Alberto Chirinos
-- Desarrollado y probado por: Alberto Chirinos

DECLARE @email NVARCHAR(250)

SET @email = 'email_1-ñ-2_other@domainname.com.ec'

IF (
-- Start with one letter, continue with the rest, then an at sign,
-- then the domain name,
-- followed by a period and at least two letters.
-- Empieza por una letra, sigue con el resto, luego un arroba,
-- luego el nombre del dominio,
-- seguido de un punto y por lo menos dos letras.
@email LIKE '[A-Z]%@%.[A-Z][A-Z]%'
-- Can not have spaces
-- No puede tener espacios
AND @email NOT LIKE '% %'
-- It cannot have a closing bracket
-- No puede tener corchete de cierre
AND @email NOT LIKE '%]%'
-- It cannot contain any of the following characters
-- The penultimate character (White space is Alt 32)
-- No puede contener ninguno de los siguientes caracteres
-- El penúltimo caracter (Espacio en blanco es Alt 32)
AND @email NOT LIKE '%[¿?¡!"#%&/\()[={}*$'',+^`´|~ºª·€¬ç¨:;<>áéíóúàèìòùäëïöüâêîôûåæÆÿø£×ƒ®½¼«»░©¢¥ãõ¤ðßµþÞý▀±¾¶§÷¸° •]%'
-- It cannot have a period before the at sign
-- No puede tener un punto antes del arroba
AND @email NOT LIKE '%.@%'
-- It cannot contain two arrobas
-- No puede contener dos arrobas
AND @email NOT LIKE '%@%@%'
-- It cannot end in any of the following characters
-- No puede terminar en ninguno de los siguientes caracteres
AND @email NOT LIKE '%[.-_0-9]'
-- It cannot have after a period, after the at sign the specified characters
-- No puede tener después de un punto, posterior al arroba los caracteres especificados
AND @email NOT LIKE '%@%.%[-_0-9]%'
-- Can't have two points in a row
-- No puede tener dos puntos seguidos
AND @email NOT LIKE '%@%..%'
-- You cannot have after the at sign and the domain name a period with a single letter and then another period
-- It would be a wrong domain extension
-- No puede tener después del arroba y del nombre del dominio un punto con una sola letra y luego otro punto
-- Sería una extensión de dominio incorrecta
AND @email NOT LIKE '%@%.[A-Z].%'
-- It cannot end with a period and a single letter
-- It would be a wrong domain extension
-- No puede terminar con un punto y una sola letra
-- Sería una extensión de dominio incorrecta
AND @email NOT LIKE '%.[A-Z]'
-- The at sign must be in a position less than or equal to 60
-- El signo de arroba debe estar en una posición menor o igual a 60
AND CHARINDEX('@', @email) <= 60
)
	BEGIN
		PRINT @email + ' VALID / ES VÁLIDO'
	END
ELSE
	BEGIN
		PRINT @email + ' It is not valid / NO es válido'
	END