
CREATE DEFINER=`root`@`localhost` PROCEDURE get_unidadAdministrativa_comisionados(IN inUsuario VARCHAR(254))
BEGIN
  DECLARE id_area INTEGER;
  
  SET id_area = (SELECT u.id_area
				FROM viajes_claros.usuarios u
				INNER JOIN viajes_claros.personas p on u.id_persona = p.id_persona
				WHERE u.usuario = inUsuario);
				
   select a.nombre_area from viajes_claros.areas a where id_area = a.id_area;
  
END

