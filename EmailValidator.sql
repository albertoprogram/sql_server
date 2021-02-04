-- IMPORTANTE
-- El collate de la base de datos es CI_AI
--***PROBARLO EN UN COLLATE NO CI_AI***

DECLARE @dato NVARCHAR(250)

--SET @dato = 'a1.e-i_ou_abcdefghijklmnño.pq.rstuvwxyzchllra1.e-i_ou_abcdefghij@microsoft.edu.co'
--SET @dato = 'a1.e-i_ou_abcdefghijklmnño.pq.rstuvwxyzchllr@microsoft.edu.co'
--SET @dato = 'benfatto3@gmail.com'
SET @dato = 'achirinos1.3@domiñio.ed.ve'

IF (
-- Empieza por una letra, sigue con el resto, luego un arroba,
-- luego el nombre del dominio y posibles subdominios,
-- seguido de un punto y por lo menos dos letras.
@dato LIKE '[A-Z]%@%.[A-Z][A-Z]%'
-- No puede tener espacios
AND @dato NOT LIKE '% %'
-- No puede tener corchete de cierre
AND @dato NOT LIKE '%]%'
-- No puede contener ninguno de los siguientes caracteres
-- El penúltimo caracter (Espacio en blanco es Alt 32)
AND @dato NOT LIKE '%[¿?¡!"#%&/\()[={}*$'',+^`´|~ºª·€¬ç¨:;<>áéíóúàèìòùäëïöüâêîôûåæÆÿø£×ƒ®½¼«»░©¢¥ãõ¤ðßµþÞý▀±¾¶§÷¸° •]%'
-- No puede tener un punto antes del arroba
AND @dato NOT LIKE '%.@%'
-- No puede contener dos arrobas
AND @dato NOT LIKE '%@%@%'
-- No puede terminar en ninguno de los siguientes caracteres
AND @dato NOT LIKE '%[.-_0-9]'
-- No puede tener dos puntos seguidos
AND @dato NOT LIKE '%@%..%'
-- No puede tener después del arroba y del nombre del dominio un punto con una sola letra y luego otro punto
-- Sería una extensión de dominio incorrecta
AND @dato NOT LIKE '%@%.[A-Z].%'
-- No puede terminar con un punto y una sola letra
-- Sería una extensión de dominio incorrecta
AND @dato NOT LIKE '%.[A-Z]'
-- El signo de arroba debe estar en una posición menor o igual a 65
AND CHARINDEX('@', @dato) <= 65
)
	BEGIN
		PRINT @dato + ' ES VÁLIDO'
	END
ELSE
	BEGIN
		PRINT @dato + ' NO es válido'
	END