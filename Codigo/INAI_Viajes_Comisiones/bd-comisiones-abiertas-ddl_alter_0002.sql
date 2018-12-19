--/
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_comision_detalle_by_id_comision`(IN idComision INT(11))
BEGIN
SELECT cd.id_detalle, cd.id_comision, cd.tabla, cd.campo, cd.valor_texto, cd.valor_numerico, cd.valor_fecha
FROM comisiones_detalle cd
WHERE cd.id_comision=idComision;
END
/

--/
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_reporte_comision_cargo_por_flujo`(IN idComision INT(11),IN idFlujo INT(11))
BEGIN	
SELECT c.id_comision,p.nombres,p.apellido_paterno,p.apellido_materno,ab.respuesta, f.nombre_flujo, p.cargo
FROM  comisiones c
inner join (
	select id_comision,id_flujo,id_funcionario,respuesta
    from aprobaciones_bitacora
    where id_instancia in(
		select max(id_instancia)
		from aprobaciones_bitacora
        where id_comision = idComision GROUP BY id_flujo)
	) ab on c.id_comision = ab.id_comision
inner join flujos_trabajo f on ab.id_flujo = f.id_flujo
inner join personas p on ab.id_funcionario = p.id_persona
where c.id_comision=idComision and ab.id_flujo = idFlujo; 
END
/

--/
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_tr_pp_by_cve_pp`(IN  cvePp varchar(245))
BEGIN
	SELECT id_programa_presupuestal , cve_pp, descripcion_pp, anio
    FROM viajes_claros.tr_programa_presupuestal where cve_pp = cvePp Limit 1;
END
/