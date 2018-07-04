use viajes_claros;

DELIMITER ;;
DROP PROCEDURE IF EXISTS `valida_dato`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `valida_dato`(tabla text, campo text, filtro text)
BEGIN
   if tabla is not null and tabla <> '' then
	 SET @s = CONCAT("SELECT count(*) FROM ",tabla," WHERE ",campo, " = '", filtro, "'");
     PREPARE stmt FROM @s;
     EXECUTE stmt;
     DEALLOCATE PREPARE stmt;
   else
	  select count(*)
	  from viajes_claros.interfaz_config ic
       ,viajes_claros.campos_dinamicos cd
       ,viajes_claros.listas_valores lv
       ,viajes_claros.valores_dinamicos vd
      where 1=1
	  and ic.campo = campo
	  and vd.codigo = filtro
	  and ic.campo = cd.nombre_campo
	  and lv.id_lista = cd.id_lista
	  and lv.id_lista = vd.id_lista;
   end if;
    
END ;;
DELIMITER ;;


DELIMITER ;;
DROP PROCEDURE IF EXISTS viajes_claros.`valida_dato`;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `valida_dato`(tabla text, campo text, filtro text) 

BEGIN
   if tabla is not null and tabla <> '' then
	 SET @s = CONCAT("SELECT count(*) FROM ",tabla," WHERE ",campo, " = '", filtro, "'");
     PREPARE stmt FROM @s;
     EXECUTE stmt;
     DEALLOCATE PREPARE stmt;
   else
	  select count(*)
	  from viajes_claros.interfaz_config ic
       ,viajes_claros.campos_dinamicos cd
       ,viajes_claros.listas_valores lv
       ,viajes_claros.valores_dinamicos vd
      where 1=1
	  and ic.campo = campo
	  and vd.codigo = filtro
	  and ic.campo = cd.nombre_campo
	  and lv.id_lista = cd.id_lista
	  and lv.id_lista = vd.id_lista;
   end if;
    
END;;
DELIMITER ;;

DELIMITER ;;
DROP PROCEDURE IF EXISTS  `get_viaje_datos_por_categoria`;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viaje_datos_por_categoria`(IN idViaje INT(11), 
	IN codigoCat VARCHAR(60))
BEGIN
	
	SELECT IFNULL(b.despliegue, d.despliegue) AS despliegue,
	CASE WHEN v.valor_texto IS NULL THEN (
		CASE WHEN v.valor_numerico IS NULL THEN 
			v.valor_fecha 
		ELSE v.valor_numerico END) 
	ELSE (CASE WHEN EXISTS (
						SELECT vd.valor AS valor
                        FROM valores_dinamicos vd 
						INNER JOIN campos_dinamicos cd ON vd.id_lista = cd.id_lista
						INNER JOIN viajes_claros_detalle vcd ON cd.nombre_campo = vcd.campo
						WHERE vcd.id_viaje = v.id_viaje and vcd.campo = v.campo and vd.codigo = v.valor_texto
                    ) THEN 
					(
						SELECT vd.valor AS valor
                        FROM valores_dinamicos vd 
						INNER JOIN campos_dinamicos cd ON vd.id_lista = cd.id_lista
						INNER JOIN viajes_claros_detalle vcd ON cd.nombre_campo = vcd.campo
						WHERE vcd.id_viaje = v.id_viaje and vcd.campo = v.campo and vd.codigo = v.valor_texto
                    )
		ELSE v.valor_texto END) END as valor
	FROM viajes_claros_detalle v 
	LEFT JOIN campos_base b ON b.tabla=v.tabla AND b.campo=v.campo
	LEFT JOIN campos_dinamicos d ON d.nombre_campo=v.campo AND v.tabla=''
	where v.id_viaje=idViaje
	AND (b.categoria=codigoCat OR d.categoria=codigoCat);
	
END;;
DELIMITER ;;

DELIMITER ;;
DROP PROCEDURE IF EXISTS  `get_viajes_por_dependencia`;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viajes_por_dependencia`(IN idDependencia INT(11))
BEGIN
	

SET SESSION group_concat_max_len = 1000000;


SET @qry_select = (SELECT 
	GROUP_CONCAT(DISTINCT CONCAT("MAX(CASE WHEN (tabla = '", tabla, "' AND campo = '", campo, "') THEN valor ELSE '' END) AS '", campo, "'") SEPARATOR ',')
FROM buscador_despliegue_config des
WHERE id_dependencia = idDependencia);


set @query = CONCAT('SELECT id_viaje, ', (CASE WHEN (@qry_select is null) THEN '''' ELSE @qry_select END), ' FROM
(
	SELECT v.id_viaje, v.tabla, v.campo, 
	CASE WHEN v.valor_texto IS NULL THEN CASE WHEN v.valor_numerico IS NULL THEN 
		DATE_FORMAT(v.valor_fecha, ''%d/%m/%Y %H:%i'') ELSE v.valor_numerico END 
		ELSE (CASE WHEN EXISTS (
						SELECT vd.valor AS valor
                        FROM valores_dinamicos vd 
						INNER JOIN campos_dinamicos cd ON vd.id_lista = cd.id_lista
						INNER JOIN viajes_claros_detalle vcd ON cd.nombre_campo = vcd.campo
						WHERE vcd.id_viaje = v.id_viaje and vcd.campo = v.campo and vd.codigo = v.valor_texto
                    ) THEN 
					(
						SELECT vd.valor AS valor
                        FROM valores_dinamicos vd 
						INNER JOIN campos_dinamicos cd ON vd.id_lista = cd.id_lista
						INNER JOIN viajes_claros_detalle vcd ON cd.nombre_campo = vcd.campo
						WHERE vcd.id_viaje = v.id_viaje and vcd.campo = v.campo and vd.codigo = v.valor_texto
                    )
		ELSE v.valor_texto END) END AS valor
	FROM viajes_claros_detalle v 
	INNER JOIN viajes_claros_instancias ins ON ins.id_viaje = v.id_viaje
	WHERE ins.id_dependencia=', idDependencia, 
	' ORDER BY v.id_viaje
) A
GROUP BY id_viaje');


PREPARE QUERY FROM @query;
EXECUTE QUERY;

END;;
DELIMITER ;;

DELIMITER ;;
DROP PROCEDURE IF EXISTS  `get_viajes_por_filtros`;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viajes_por_filtros`(IN idDependencia INT(11), IN filtros VARCHAR(2000))
BEGIN
	
SET SESSION group_concat_max_len = 1000000;


SET @qry_select_final = (SELECT GROUP_CONCAT(DISTINCT campo SEPARATOR ',')
FROM buscador_despliegue_config des
WHERE id_dependencia = idDependencia);


SET @qry_select = (SELECT 
	GROUP_CONCAT(DISTINCT CONCAT("MAX(CASE WHEN (tabla = '", tabla, "' AND campo = '", campo, "') THEN valor ELSE '' END) AS '", campo, "'") SEPARATOR ',')
FROM 
(
	SELECT id_dependencia, tabla, campo FROM buscador_filtros_config
	UNION ALL
	SELECT id_dependencia, tabla, campo FROM buscador_despliegue_config
) T
WHERE id_dependencia = idDependencia);


set @query = CONCAT('SELECT id_viaje, ', (CASE WHEN (@qry_select is null) THEN '''' ELSE @qry_select END), ' FROM
(
	SELECT v.id_viaje, v.tabla, v.campo, 
	CASE WHEN v.valor_texto IS NULL THEN 
		CASE WHEN v.valor_numerico IS NULL THEN 
			DATE_FORMAT(v.valor_fecha, ''%d/%m/%Y %H:%i'') 
		ELSE v.valor_numerico END 
	ELSE (CASE WHEN EXISTS (
						SELECT vd.valor AS valor
                        FROM valores_dinamicos vd 
						INNER JOIN campos_dinamicos cd ON vd.id_lista = cd.id_lista
						INNER JOIN viajes_claros_detalle vcd ON cd.nombre_campo = vcd.campo
						WHERE vcd.id_viaje = v.id_viaje and vcd.campo = v.campo and vd.codigo = v.valor_texto
                    ) THEN 
					(
						SELECT vd.valor AS valor
                        FROM valores_dinamicos vd 
						INNER JOIN campos_dinamicos cd ON vd.id_lista = cd.id_lista
						INNER JOIN viajes_claros_detalle vcd ON cd.nombre_campo = vcd.campo
						WHERE vcd.id_viaje = v.id_viaje and vcd.campo = v.campo and vd.codigo = v.valor_texto
                    )
		ELSE v.valor_texto END) END AS valor
	FROM viajes_claros_detalle v 
	INNER JOIN viajes_claros_instancias ins ON ins.id_viaje = v.id_viaje
	WHERE ins.id_dependencia=', idDependencia, 
	' ORDER BY v.id_viaje
) A
GROUP BY id_viaje');



set @query_where = CONCAT('SELECT id_viaje, ', (CASE WHEN (@qry_select_final is null) THEN '''' ELSE @qry_select_final END), ' FROM (', @query, ') B WHERE 1=1 ', filtros);

PREPARE QUERY FROM @query_where;
EXECUTE QUERY;
	
END;;
DELIMITER ;;