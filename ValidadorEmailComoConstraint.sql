--Validador de Email Como Constraint de tabla
ALTER TABLE Authors
ADD CONSTRAINT ValidAuthorEmail CHECK (-- Empieza por una letra, sigue con el resto, luego un arroba,
-- luego el nombre del dominio,
-- seguido de un punto y por lo menos dos letras.
Email LIKE '[A-Z]%@%.[A-Z][A-Z]%'
-- No puede tener espacios
AND Email NOT LIKE '% %'
-- No puede tener corchete de cierre
AND Email NOT LIKE '%]%'
-- No puede contener ninguno de los siguientes caracteres
-- El penúltimo caracter (Espacio en blanco es Alt 32)
AND Email NOT LIKE '%[¿?¡!"#%&/\()[={}*$'',+^`´|~ºª·€¬ç¨:;<>áéíóúàèìòùäëïöüâêîôûåæÆÿø£×ƒ®½¼«»░©¢¥ãõ¤ðßµþÞý▀±¾¶§÷¸° •]%'
-- No puede tener un punto antes del arroba
AND Email NOT LIKE '%.@%'
-- No puede contener dos arrobas
AND Email NOT LIKE '%@%@%'
-- No puede terminar en ninguno de los siguientes caracteres
AND Email NOT LIKE '%[.-_0-9]'
-- No puede tener después de un punto, posterior al arroba los caracteres especificados
AND Email NOT LIKE '%@%.%[-_0-9]%'
-- No puede tener dos puntos seguidos
AND Email NOT LIKE '%@%..%'
-- No puede tener después del arroba y del nombre del dominio un punto con una sola letra y luego otro punto
-- Sería una extensión de dominio incorrecta
AND Email NOT LIKE '%@%.[A-Z].%'
-- No puede terminar con un punto y una sola letra
-- Sería una extensión de dominio incorrecta
AND Email NOT LIKE '%.[A-Z]'
-- No puede haber un punto luego del arroba
AND Email NOT LIKE '%@.%'
-- El signo de arroba debe estar en una posición menor o igual a 60
AND CHARINDEX('@', Email) <= 60)