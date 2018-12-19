INSERT into viajes_claros.listas_valores (id_lista, nombre_lista, habilitada) VALUES (326,'denominacion_partida_viaticos',1);
INSERT INTO viajes_claros.listas_valores (id_lista, nombre_lista, habilitada) VALUES (327, 'pasaje_aereo', true);
INSERT INTO viajes_claros.listas_valores (id_lista, nombre_lista, habilitada) VALUES (328, 'pasaje_terrestre', true);
INSERT INTO viajes_claros.listas_valores (id_lista, nombre_lista, habilitada) VALUES (329, 'cve_pasaje_aereo', true);
INSERT INTO viajes_claros.listas_valores (id_lista, nombre_lista, habilitada) VALUES (330, 'cve_pasaje_terrestre', true);

update viajes_claros.campos_dinamicos set id_lista=326 where nombre_campo = 'denominacion_pviaticos';
update viajes_claros.campos_dinamicos set id_lista=327 where nombre_campo='denominacion_partida_VP';
update viajes_claros.campos_dinamicos set id_lista=328 where nombre_campo='denominacion_ppasajes';
update viajes_claros.campos_dinamicos set id_lista=329 where nombre_campo='cve_partida_VP';
update viajes_claros.campos_dinamicos set id_lista=330 where nombre_campo='cve_partida_pasaje';

INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (326, 'N/A','N/A',1);
INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (326, '37504','Viáticos nacionales para servidores públicos en el desempeño de funciones oficiales',1);
INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (326, '37602','Viáticos en el extranjero para servidores públicos en el desempeño de comisiones y funciones oficiales',1);


INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (327, 'N/A', 'N/A', 1);
INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (327, '37104', 'Pasajes aéreos nacionales para servidores públicos de mando en el desempeño de comisiones y funciones oficiales', 1);
INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (327, '37106', 'Pasajes aéreos internacionales para servidores públicos de mando en el desempeño de comisiones y funciones oficiales', 1);

INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (328, 'N/A', 'N/A', 1);
INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (328, '37201', 'Pasajes terrestres nacionales para labores en campo y de supervisión', 1);
INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (328, '37204', 'Pasajes terrestres nacionales para servidores públicos de mando en el desempeño de comisiones y funciones oficiales', 1);
INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (328, '37206', 'Pasajes terrestres internacionales para servidores públicos en el desempeño de comisiones y funciones oficiales', 1);

INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (329, 'N/A', 'N/A', 1);
INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (329, '37104', '37104', 1);
INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (329, '37106', '37106', 1);

INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (330, 'N/A', 'N/A', 1);
INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (330, '37201', '37201', 1);
INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (330, '37204', '37204', 1);
INSERT INTO viajes_claros.valores_dinamicos (id_lista, codigo, valor, activo) VALUES (330, '37206', '37206', 1);

INSERT INTO  viajes_claros.flujos_campos_config (id_flujo,tabla,campo,etiqueta,lista_habilitada,obligatorio,id_tipo_persona,id_seccion_formulario,orden,subtipo,solo_lectura,clase)values (2,'','denominacion_pviaticos','Denominación de partida de viáticos',1,1,2,19,57,'SIMPLE',1,null);
update viajes_claros.flujos_campos_config set clase = 'fechaCompraIda' where campo = 'fecha_compra_p_ida' and id_flujo = 3;
update viajes_claros.flujos_campos_config set clase = 'fechaCompraVuelta' where campo = 'fecha_compra_p_vuelta' and id_flujo = 3;
update viajes_claros.flujos_campos_config set clase = 'gastosPasaje' where campo = 'gasto_total_pasaje' and id_flujo = 3;

update viajes_claros.flujos_campos_config set clase='numeroAcompaniantes' where campo='numero_acompaniantes' and id_flujo=3; 
update viajes_claros.flujos_campos_config set clase='importeAcompaniantes' where campo='importe_acompaniantes' and id_flujo=3; 

update viajes_claros.flujos_campos_config set clase='gastoGasolina' where campo='gasto_gasolina' and id_flujo=3; 
update viajes_claros.flujos_campos_config set clase='gastoPeaje' where campo='gasto_peaje' and id_flujo=3;
update viajes_claros.flujos_campos_config set clase='gastoAutobus' where campo='gasto_autobus' and id_flujo=3;

update viajes_claros.flujos_campos_config set clase='tipoCambioTarifa' where campo='tipo_de_cambio_viaticos' and id_flujo=3;

update viajes_claros.flujos_campos_config set clase='costoVuelo' where campo='costo_vuelo' and id_flujo=3; 
update viajes_claros.flujos_campos_config set clase='costoCambioVuelo' where campo='costo_cambio_vuelta' and id_flujo=3; 

update viajes_claros.flujos_campos_config set clase='tipoPago' where campo='tipo_de_pago' and id_flujo=1; 
update viajes_claros.flujos_campos_config set clase='tipoPago' where campo='tipo_de_pago' and id_flujo=2; 
update viajes_claros.flujos_campos_config set clase='tipoPago' where campo='tipo_de_pago' and id_flujo=3; 