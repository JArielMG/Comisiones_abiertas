DROP PROCEDURE IF EXISTS `get_datos_servidor_publico`;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_datos_servidor_publico`(IN idViaje INT(11))
BEGIN

SELECT CONCAT(nombre.valor_texto,' ',app.valor_texto,' ',apm.valor_texto), dep.nombre_dependencia
FROM viajes_claros.viajes_claros_instancias ins
INNER JOIN viajes_claros.viajes_claros_detalle nombre ON ins.id_viaje = nombre.id_viaje and nombre.tabla = 'personas' and nombre.campo = 'nombres'
INNER JOIN viajes_claros.viajes_claros_detalle app ON ins.id_viaje = app.id_viaje and app.tabla = 'personas' and app.campo = 'apellido_paterno'
INNER JOIN viajes_claros.viajes_claros_detalle apm ON ins.id_viaje = apm.id_viaje and apm.tabla = 'personas' and apm.campo = 'apellido_materno'
INNER JOIN viajes_claros.dependencias dep ON ins.id_dependencia = dep.id_dependencia
WHERE ins.id_viaje = idViaje;

END ;;
DELIMITER ;