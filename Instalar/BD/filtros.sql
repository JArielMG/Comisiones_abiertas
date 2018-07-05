use viajes_claros;

DROP PROCEDURE IF EXISTS `get_listas_valores_filtradas`;
DROP PROCEDURE IF EXISTS `get_valores_dinamicos_filtro`;
DROP PROCEDURE IF EXISTS `get_campos_dinamicos_filtrados`;
DROP PROCEDURE IF EXISTS `get_listas_valores_ordenada`;
DROP PROCEDURE IF EXISTS `get_catalogo_tabla_campo`;
DROP PROCEDURE IF EXISTS `get_campos_config_disponibles`;
DROP PROCEDURE IF EXISTS `get_columnas_carga`;
DROP PROCEDURE IF EXISTS `update_secuencias`;
DROP PROCEDURE IF EXISTS `get_viaje_datos_suscripcion`;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_listas_valores_filtradas`(filtro VARCHAR(200))
BEGIN
	SELECT DISTINCT L.id_lista, L.nombre_lista, L.habilitada, 
		CASE WHEN V.id_lista IS NULL THEN (CASE WHEN D.id_lista IS NULL THEN false ELSE true END) ELSE true END as constraint_fails
	FROM listas_valores L
	LEFT JOIN valores_dinamicos V ON V.id_lista = L.id_lista
	LEFT JOIN campos_dinamicos D ON D.id_lista = L.id_lista
	WHERE L.nombre_lista LIKE CONCAT('%',filtro,'%');

END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_valores_dinamicos_filtro`(idLista INT, filtro VARCHAR(200))
BEGIN
SET @qry1 = 'SELECT v.id_lista, v.codigo, v.valor, l.nombre_lista, l.habilitada
FROM valores_dinamicos v
INNER JOIN listas_valores l ON l.id_lista = v.id_lista';
	
IF idLista IS NULL THEN
	SET @query = CONCAT(@qry1, ' WHERE v.valor LIKE ''%',  filtro, '%''');
ELSE
	SET @query = CONCAT(@qry1, ' WHERE v.id_lista=', idLista, ' AND v.valor LIKE ''%',  filtro, '%''');
END IF;

PREPARE QUERY FROM @query;
EXECUTE QUERY;

END ;;
DELIMITER ;


DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_campos_dinamicos_filtrados`(filtro VARCHAR(200))
BEGIN
SELECT nombre_campo, id_lista, descripcion, despliegue, busqueda_defecto, tipo_dato as id_tipo_dato, tipo_control as id_tipo_control,
	CASE WHEN tipo_dato=1 THEN 'NUMERO' ELSE (CASE WHEN tipo_dato=2 THEN 'TEXTO' ELSE (CASE WHEN tipo_dato=3 THEN 'FECHA' ELSE 'UNDEFINED' END)  END) END as tipo_dato, 
	CASE WHEN tipo_control=1 THEN 'TEXTO' ELSE (CASE WHEN tipo_control=2 THEN 'LISTA' ELSE (CASE WHEN tipo_control=3 THEN 'CALENDARIO' ELSE 'UNDEFINED' END) END) END as tipo_control,
	nombre_lista, categoria, constraint_fails
FROM 
	(
		SELECT DISTINCT D.nombre_campo, D.tipo_dato, D.id_lista, D.descripcion, D.despliegue, 
			D.busqueda_defecto, D.tipo_control, L.nombre_lista, cat.descripcion as categoria,
			CASE WHEN C.campo IS NULL THEN false ELSE true END AS constraint_fails
		FROM campos_dinamicos D
		LEFT JOIN listas_valores L ON L.id_lista = D.id_lista
		LEFT JOIN categoria_campo cat ON cat.categoria=D.categoria
		LEFT JOIN viajes_claros_config C ON C.tabla='' AND C.campo=D.nombre_campo
	) A
WHERE nombre_campo LIKE CONCAT('%',filtro,'%');
    
END ;;
DELIMITER ;


DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_listas_valores_ordenada`()
BEGIN
SELECT DISTINCT L.id_lista, L.nombre_lista, L.habilitada, 
	CASE WHEN V.id_lista IS NULL THEN (CASE WHEN D.id_lista IS NULL THEN false ELSE true END) ELSE true END as constraint_fails
FROM listas_valores L
LEFT JOIN valores_dinamicos V ON V.id_lista = L.id_lista
LEFT JOIN campos_dinamicos D ON D.id_lista = L.id_lista
ORDER BY L.nombre_lista;

END ;;
DELIMITER ;


DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_catalogo_tabla_campo`(IN tabla VARCHAR(50), IN campo VARCHAR(50))
BEGIN
	SET @IdColumn = (SELECT k.COLUMN_NAME
	FROM information_schema.table_constraints t
	LEFT JOIN information_schema.key_column_usage k
	USING(constraint_name,table_schema,table_name)
	WHERE t.constraint_type='PRIMARY KEY'
    AND t.table_schema=DATABASE()
    AND t.table_name=tabla);
    
SET @query = CONCAT('SELECT ', @IdColumn, ' as columna, ', campo, ' as campo FROM ', tabla, ' ORDER BY ', campo);
    
PREPARE QUERY FROM @query;
EXECUTE QUERY;

END ;;
DELIMITER ;



DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_campos_config_disponibles`(nombreTabla VARCHAR(50), filtro VARCHAR(200))
BEGIN
SET @qry1 = 'SELECT tabla, campo, conf 
	FROM
	(
	SELECT '''' as tabla, din.nombre_campo as campo, conf.campo as conf
	FROM campos_dinamicos din
	LEFT JOIN viajes_claros_config conf ON conf.tabla='''' AND conf.campo=din.nombre_campo
	UNION ALL
	SELECT b.tabla, b.campo, conf.campo as conf
	FROM campos_base b
	LEFT JOIN viajes_claros_config conf ON conf.tabla=b.tabla AND conf.campo=b.campo
	) A
	WHERE conf IS NULL';
	
IF nombreTabla IS NULL THEN
	SET @query = CONCAT(@qry1, ' AND campo LIKE ''', '%', filtro, '%''');
ELSE
	SET @query = CONCAT(@qry1, ' AND tabla=''', nombreTabla, '''', ' AND campo LIKE ''', '%', filtro, '%''');
END IF;
	
	
PREPARE QUERY FROM @query;
EXECUTE QUERY;
	
END ;;
DELIMITER ;


DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_columnas_carga`(idDependencia INT(11), secuencia INT)
BEGIN

select i.id_dependencia, i.tabla, i.campo, 
	i.etiqueta, i.editable, i.secuencia, i.lista_habilitada
from interfaz_config i
WHERE i.id_dependencia = idDependencia
AND i.secuencia >= secuencia
ORDER BY i.secuencia;

END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_secuencias`(inSecuencia INT, inTabla VARCHAR(50), inCampo VARCHAR(50), inDependencia INT)
BEGIN

UPDATE interfaz_config SET secuencia = inSecuencia WHERE tabla = inTabla and campo = inCampo and id_dependencia = inDependencia;

END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viaje_datos_suscripcion`(idViaje INT(11))
BEGIN
	
SET SESSION group_concat_max_len = 1000000;

SET @idDep = (SELECT id_dependencia FROM viajes_claros_instancias WHERE id_viaje=idViaje);

SET @qry_select = (SELECT 
	GROUP_CONCAT(DISTINCT CONCAT("MAX(CASE WHEN (campo = '", campo, "') THEN valor ELSE NULL END) AS '", cd.descripcion, "'") SEPARATOR ',')
FROM suscripcion_config conf inner join campos_dinamicos cd on conf.campo = cd.nombre_campo
WHERE id_dependencia = @idDep);

set @query = CONCAT('SELECT id_viaje, ', (CASE WHEN (@qry_select is null) THEN '''' ELSE @qry_select END), ' FROM
(
	SELECT v.id_viaje, v.tabla, v.campo, 
	CASE WHEN v.valor_texto IS NULL THEN CASE WHEN v.valor_numerico IS NULL THEN DATE_FORMAT(v.valor_fecha, ''%d/%m/%Y %H:%i'') ELSE v.valor_numerico END ELSE v.valor_texto END AS valor
	FROM viajes_claros_detalle v 
	INNER JOIN viajes_claros_instancias ins ON ins.id_viaje = v.id_viaje
	WHERE v.id_viaje=', idViaje, 
') A
GROUP BY id_viaje');

PREPARE QUERY FROM @query;
EXECUTE QUERY;

END ;;
DELIMITER ;

INSERT INTO `viajes_claros`.`suscripcion_config` (`id_dependencia`, `campo`) VALUES ('4', 'motivo_encargo');
commit;