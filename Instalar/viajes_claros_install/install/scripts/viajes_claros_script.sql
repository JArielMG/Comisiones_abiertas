CREATE DATABASE  IF NOT EXISTS `viajes_claros` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `viajes_claros`;

-- MySQL dump 10.13  Distrib 5.5.46, for Linux (x86_64)
--
-- Host: localhost    Database: viajes_claros
-- ------------------------------------------------------
-- Server version	5.5.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aprobaciones_bitacora`
--

DROP TABLE IF EXISTS `aprobaciones_bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aprobaciones_bitacora` (
  `id_instancia` bigint(20) NOT NULL,
  `id_flujo` int(11) NOT NULL,
  `id_comision` int(11) NOT NULL,
  `id_funcionario` int(11) NOT NULL,
  `respuesta` varchar(100) NOT NULL,
  `fecha_evento` datetime NOT NULL,
  PRIMARY KEY (`id_instancia`,`id_flujo`,`id_comision`,`id_funcionario`),
  KEY `fk_aprobaciones_bitacora_funcionarios1_idx` (`id_funcionario`),
  KEY `fk_aprobaciones_bitacora_flujos_instancias1_idx` (`id_instancia`,`id_flujo`,`id_comision`),
  CONSTRAINT `fk_aprobaciones_bitacora_flujos_instancias1` FOREIGN KEY (`id_instancia`, `id_flujo`, `id_comision`) REFERENCES `flujos_instancias` (`id_instancia`, `id_flujo`, `id_comision`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_aprobaciones_bitacora_funcionarios1` FOREIGN KEY (`id_funcionario`) REFERENCES `personas` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `archivo_lineas`
--

DROP TABLE IF EXISTS `archivo_lineas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archivo_lineas` (
  `id_error` int(11) NOT NULL AUTO_INCREMENT,
  `id_archivo` bigint(20) NOT NULL,
  `id_linea` int(11) NOT NULL,
  `estatus` varchar(30) DEFAULT NULL,
  `comentarios` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id_error`),
  KEY `fk_archivo_lineas_archivos_procesados2_idx` (`id_archivo`),
  CONSTRAINT `fk_archivo_lineas_archivos_procesados2` FOREIGN KEY (`id_archivo`) REFERENCES `archivos_procesados` (`id_archivo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=257965 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `archivos_procesados`
--

DROP TABLE IF EXISTS `archivos_procesados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archivos_procesados` (
  `id_archivo` bigint(20) NOT NULL,
  `nombre_archivo` varchar(200) NOT NULL,
  `fecha_carga` datetime NOT NULL,
  `total_registros` int(11) DEFAULT NULL,
  `total_aceptados` int(11) DEFAULT NULL,
  `total_rechazados` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_archivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areas` (
  `id_area` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_area` varchar(200) DEFAULT NULL,
  `id_dependencia` int(11) NOT NULL,
  PRIMARY KEY (`id_area`),
  KEY `fk_areas_dependencias1_idx` (`id_dependencia`),
  CONSTRAINT `fk_areas_dependencias1` FOREIGN KEY (`id_dependencia`) REFERENCES `dependencias` (`id_dependencia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1051 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `buscador_despliegue_config`
--

DROP TABLE IF EXISTS `buscador_despliegue_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buscador_despliegue_config` (
  `id_dependencia` int(11) NOT NULL,
  `tabla` varchar(50) NOT NULL,
  `campo` varchar(50) NOT NULL,
  `orden` tinyint(4) DEFAULT NULL,
  `mostrar` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_dependencia`,`tabla`,`campo`),
  KEY `fk_buscador_despliegue_config_viajes_claros_config1_idx` (`tabla`,`campo`),
  CONSTRAINT `fk_buscador_despliegue_config_dependencias1` FOREIGN KEY (`id_dependencia`) REFERENCES `dependencias` (`id_dependencia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_buscador_despliegue_config_viajes_claros_config1` FOREIGN KEY (`tabla`, `campo`) REFERENCES `viajes_claros_config` (`tabla`, `campo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `buscador_filtros_config`
--

DROP TABLE IF EXISTS `buscador_filtros_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buscador_filtros_config` (
  `id_dependencia` int(11) NOT NULL,
  `tabla` varchar(50) NOT NULL,
  `campo` varchar(50) NOT NULL,
  `operador` varchar(20) DEFAULT NULL,
  `orden` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_dependencia`,`tabla`,`campo`),
  KEY `fk_table1_viajes_claros_config1_idx` (`tabla`,`campo`),
  CONSTRAINT `fk_table1_dependencias1` FOREIGN KEY (`id_dependencia`) REFERENCES `dependencias` (`id_dependencia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_viajes_claros_config1` FOREIGN KEY (`tabla`, `campo`) REFERENCES `viajes_claros_config` (`tabla`, `campo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campos_base`
--

DROP TABLE IF EXISTS `campos_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campos_base` (
  `tabla` varchar(50) NOT NULL,
  `campo` varchar(50) NOT NULL,
  `tipo_dato` int(11) NOT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `despliegue` varchar(50) DEFAULT NULL,
  `busqueda_defecto` tinyint(1) DEFAULT NULL,
  `tipo_control` int(10) DEFAULT NULL,
  `categoria` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`tabla`,`campo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campos_dinamicos`
--

DROP TABLE IF EXISTS `campos_dinamicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campos_dinamicos` (
  `nombre_campo` varchar(50) NOT NULL,
  `tipo_dato` int(11) DEFAULT NULL,
  `id_lista` int(11) DEFAULT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `despliegue` varchar(250) DEFAULT NULL,
  `busqueda_defecto` tinyint(1) DEFAULT NULL,
  `tipo_control` int(11) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nombre_campo`),
  KEY `fk_campos_dinamicos_listas_valores1_idx` (`id_lista`),
  KEY `campos_dinamicos_categoria_campo_FK` (`categoria`),
  CONSTRAINT `campos_dinamicos_categoria_campo_FK` FOREIGN KEY (`categoria`) REFERENCES `categoria_campo` (`categoria`),
  CONSTRAINT `fk_campos_dinamicos_listas_valores1` FOREIGN KEY (`id_lista`) REFERENCES `listas_valores` (`id_lista`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(200) DEFAULT NULL,
  `tope_hospedaje` double DEFAULT NULL,
  `tope_viaticos` double DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categoria_campo`
--

DROP TABLE IF EXISTS `categoria_campo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria_campo` (
  `categoria` varchar(50) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ciudades`
--

DROP TABLE IF EXISTS `ciudades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ciudades` (
  `id_ciudad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_ciudad` varchar(250) NOT NULL,
  `id_pais` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `latitud` varchar(20) DEFAULT NULL,
  `longitud` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_ciudad`),
  KEY `fk_ciudades_paises1_idx` (`id_pais`),
  KEY `fk_ciudades_estados1_idx` (`id_estado`),
  CONSTRAINT `fk_ciudades_estados1` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id_estado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ciudades_paises1` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comisiones`
--

DROP TABLE IF EXISTS `comisiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comisiones` (
  `id_comision` int(11) NOT NULL AUTO_INCREMENT,
  `estatus` varchar(2) DEFAULT NULL,
  `id_dependencia` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_comision`),
  KEY `fk_comisiones_dependencias1_idx` (`id_dependencia`),
  KEY `fk_comisiones_personas1_idx` (`id_persona`),
  KEY `fk_comisiones_usuarios1_idx` (`id_usuario`),
  CONSTRAINT `fk_comisiones_dependencias1` FOREIGN KEY (`id_dependencia`) REFERENCES `dependencias` (`id_dependencia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comisiones_personas1` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comisiones_usuarios1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comisiones_desglose_gastos`
--

DROP TABLE IF EXISTS `comisiones_desglose_gastos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comisiones_desglose_gastos` (
  `id_desglose_gastos` int(11) NOT NULL AUTO_INCREMENT,
  `id_comision` int(11) NOT NULL,
  `tabla` varchar(50) DEFAULT NULL,
  `campo` varchar(50) DEFAULT NULL,
  `valor_texto` varchar(300) DEFAULT NULL,
  `valor_numerico` double DEFAULT NULL,
  `valor_fecha` datetime DEFAULT NULL,
  `id_registro_gasto_comision` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_desglose_gastos`),
  KEY `fk_id_comision` (`id_comision`),
  KEY `fk_id_registro_gasto` (`id_registro_gasto_comision`),
  CONSTRAINT `fk_comisiones_desglose_gastos_comision` FOREIGN KEY (`id_comision`) REFERENCES `comisiones` (`id_comision`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_registro_gasto_comision` FOREIGN KEY (`id_registro_gasto_comision`) REFERENCES `registros_gastos_comision` (`id_registro_gasto_comision`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comisiones_detalle`
--

DROP TABLE IF EXISTS `comisiones_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comisiones_detalle` (
  `id_detalle` int(11) NOT NULL AUTO_INCREMENT,
  `id_comision` int(11) NOT NULL,
  `tabla` varchar(50) DEFAULT NULL,
  `campo` varchar(50) DEFAULT NULL,
  `valor_texto` varchar(300) DEFAULT NULL,
  `valor_numerico` double DEFAULT NULL,
  `valor_fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `fk_comisiones_detalle_comisiones1_idx` (`id_comision`),
  CONSTRAINT `fk_comisiones_detalle_comisiones1` FOREIGN KEY (`id_comision`) REFERENCES `comisiones` (`id_comision`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1331 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `configuracion_aprobacion`
--

DROP TABLE IF EXISTS `configuracion_aprobacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuracion_aprobacion` (
  `id_conf_aprobacion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `id_flujo` int(11) NOT NULL,
  `id_dependencia` int(11) NOT NULL,
  `id_area` int(11) DEFAULT NULL,
  `id_jerarquia` int(11) NOT NULL,
  `editable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_conf_aprobacion`),
  KEY `fk_aprobadores_flujos_aprobacion1_idx` (`id_flujo`),
  KEY `fk_configuracion_aprobacion_dependencias1_idx` (`id_dependencia`),
  KEY `fk_configuracion_aprobacion_areas1_idx` (`id_area`),
  KEY `fk_configuracion_aprobacion_jerarquias1_idx` (`id_jerarquia`),
  CONSTRAINT `fk_aprobadores_flujos_aprobacion1` FOREIGN KEY (`id_flujo`) REFERENCES `flujos_trabajo` (`id_flujo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_configuracion_aprobacion_areas1` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id_area`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_configuracion_aprobacion_dependencias1` FOREIGN KEY (`id_dependencia`) REFERENCES `dependencias` (`id_dependencia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_configuracion_aprobacion_jerarquias1` FOREIGN KEY (`id_jerarquia`) REFERENCES `jerarquias` (`id_jerarquia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dependencias`
--

DROP TABLE IF EXISTS `dependencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dependencias` (
  `id_dependencia` int(11) NOT NULL AUTO_INCREMENT,
  `siglas` varchar(20) DEFAULT NULL,
  `nombre_dependencia` varchar(400) DEFAULT NULL,
  `predeterminada` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_dependencia`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estados` (
  `id_estado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_estado` varchar(300) DEFAULT NULL,
  `id_pais` int(11) NOT NULL,
  PRIMARY KEY (`id_estado`),
  KEY `fk_estados_paises1_idx` (`id_pais`),
  CONSTRAINT `fk_estados_paises1` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flujos_campos_config`
--

DROP TABLE IF EXISTS `flujos_campos_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flujos_campos_config` (
  `id_flujo` int(11) NOT NULL,
  `tabla` varchar(50) NOT NULL,
  `campo` varchar(50) NOT NULL,
  `etiqueta` varchar(100) DEFAULT NULL,
  `lista_habilitada` tinyint(1) DEFAULT NULL,
  `obligatorio` tinyint(4) DEFAULT '0',
  `id_tipo_persona` int(11) NOT NULL,
  `id_seccion_formulario` int(11) DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  `subtipo` varchar(150) DEFAULT NULL,
  `solo_lectura` tinyint(1) DEFAULT NULL,
  `clase` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_flujo`,`campo`,`id_tipo_persona`,`tabla`),
  KEY `fk_flujos_campos_config_flujos_trabajo1_idx` (`id_flujo`),
  KEY `fk_flujos_campos_config_tipo_persona` (`id_tipo_persona`),
  KEY `fk_flujos_campos_config_seccion` (`id_seccion_formulario`),
  CONSTRAINT `fk_flujos_campos_config_flujos_trabajo1` FOREIGN KEY (`id_flujo`) REFERENCES `flujos_trabajo` (`id_flujo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_flujos_campos_config_seccion1` FOREIGN KEY (`id_seccion_formulario`) REFERENCES `secciones_formulario` (`id_seccion`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flujos_instancias`
--

DROP TABLE IF EXISTS `flujos_instancias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flujos_instancias` (
  `id_instancia` bigint(20) NOT NULL,
  `id_flujo` int(11) NOT NULL,
  `id_comision` int(11) NOT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `asignado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_instancia`,`id_flujo`,`id_comision`),
  KEY `fk_flujos_instancias_flujos_trabajo1_idx` (`id_flujo`),
  KEY `fk_flujos_instancias_comisiones1_idx` (`id_comision`),
  CONSTRAINT `fk_flujos_instancias_comisiones1` FOREIGN KEY (`id_comision`) REFERENCES `comisiones` (`id_comision`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_flujos_instancias_flujos_trabajo1` FOREIGN KEY (`id_flujo`) REFERENCES `flujos_trabajo` (`id_flujo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flujos_trabajo`
--

DROP TABLE IF EXISTS `flujos_trabajo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flujos_trabajo` (
  `id_flujo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_flujo` varchar(50) DEFAULT NULL,
  `descripcion` varchar(300) DEFAULT NULL,
  `version` varchar(20) NOT NULL,
  PRIMARY KEY (`id_flujo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gastos_campos_config`
--

DROP TABLE IF EXISTS `gastos_campos_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gastos_campos_config` (
  `id_gasto_campo_config` int(11) NOT NULL,
  `tabla` varchar(50) NOT NULL,
  `campo` varchar(50) NOT NULL,
  `etiqueta` varchar(100) DEFAULT NULL,
  `lista_habilitada` tinyint(1) DEFAULT NULL,
  `obligatorio` tinyint(4) DEFAULT '0',
  `orden` int(11) DEFAULT NULL,
  `subtipo` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_gasto_campo_config`,`campo`,`tabla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `graficas`
--

DROP TABLE IF EXISTS `graficas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graficas` (
  `grafica` varchar(60) NOT NULL DEFAULT '',
  `descripcion` varchar(250) NOT NULL,
  `id_grafica` int(11) NOT NULL,
  PRIMARY KEY (`id_grafica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `graficas_config`
--

DROP TABLE IF EXISTS `graficas_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graficas_config` (
  `id_dependencia` int(11) NOT NULL,
  `id_grafica` int(11) NOT NULL,
  PRIMARY KEY (`id_dependencia`,`id_grafica`),
  KEY `graficas_config_graficas_FK` (`id_grafica`),
  CONSTRAINT `graficas_config_dependencias_FK` FOREIGN KEY (`id_dependencia`) REFERENCES `dependencias` (`id_dependencia`),
  CONSTRAINT `graficas_config_graficas_FK` FOREIGN KEY (`id_grafica`) REFERENCES `graficas` (`id_grafica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `interfaz_config`
--

DROP TABLE IF EXISTS `interfaz_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interfaz_config` (
  `tabla` varchar(50) NOT NULL,
  `campo` varchar(50) NOT NULL,
  `lista_habilitada` tinyint(1) NOT NULL,
  `etiqueta` varchar(30) DEFAULT NULL,
  `secuencia` int(11) NOT NULL,
  `id_dependencia` int(11) NOT NULL,
  `editable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`tabla`,`campo`,`id_dependencia`),
  KEY `fk_interfaz_config_viajes_claros_config1_idx` (`tabla`),
  KEY `interfaz_config_dependencias_FK` (`id_dependencia`),
  CONSTRAINT `interfaz_config_dependencias_FK` FOREIGN KEY (`id_dependencia`) REFERENCES `dependencias` (`id_dependencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`viajes_admin`@`localhost`*/ /*!50003 TRIGGER delete_on_buscador AFTER DELETE on interfaz_config
FOR EACH ROW
BEGIN
	
	DELETE FROM buscador_filtros_config 
    WHERE id_dependencia = OLD.id_dependencia
    	AND tabla=OLD.tabla
    	AND campo=OLD.campo;
    	
    DELETE FROM buscador_despliegue_config 
	WHERE id_dependencia = OLD.id_dependencia
    	AND tabla=OLD.tabla
    	AND campo=OLD.campo;
 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `jerarquia_miembros`
--

DROP TABLE IF EXISTS `jerarquia_miembros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jerarquia_miembros` (
  `id_miembro` int(11) NOT NULL AUTO_INCREMENT,
  `id_jerarquia` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_miembro`),
  KEY `fk_jerarquia_miembros_jerarquias1_idx` (`id_jerarquia`),
  KEY `fk_jerarquia_miembros_usuarios1_idx` (`id_usuario`),
  CONSTRAINT `fk_jerarquia_miembros_jerarquias1` FOREIGN KEY (`id_jerarquia`) REFERENCES `jerarquias` (`id_jerarquia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_jerarquia_miembros_usuarios1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jerarquias`
--

DROP TABLE IF EXISTS `jerarquias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jerarquias` (
  `id_jerarquia` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_jerarquia` varchar(200) DEFAULT NULL,
  `editable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_jerarquia`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `listas_valores`
--

DROP TABLE IF EXISTS `listas_valores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `listas_valores` (
  `id_lista` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_lista` varchar(50) NOT NULL,
  `habilitada` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_lista`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paises`
--

DROP TABLE IF EXISTS `paises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paises` (
  `id_pais` int(11) NOT NULL AUTO_INCREMENT,
  `clave_pais` varchar(3) NOT NULL,
  `nombre_pais` varchar(300) NOT NULL,
  `predeterminado` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `perfiles`
--

DROP TABLE IF EXISTS `perfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `perfiles` (
  `id_perfil` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_perfil` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personas` (
  `id_persona` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(200) DEFAULT NULL,
  `apellido_paterno` varchar(200) DEFAULT NULL,
  `apellido_materno` varchar(200) DEFAULT NULL,
  `titulo` varchar(200) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_tipo_persona` int(11) NOT NULL,
  `id_posicion` int(11) DEFAULT NULL,
  `cargo` varchar(200) DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  PRIMARY KEY (`id_persona`),
  KEY `fk_funcionarios_categoria1_idx` (`id_categoria`),
  KEY `fk_personas_tipo_persona1_idx` (`id_tipo_persona`),
  KEY `fk_personas_posiciones1_idx` (`id_posicion`),
  CONSTRAINT `fk_funcionarios_categoria1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_personas_posiciones1` FOREIGN KEY (`id_posicion`) REFERENCES `posiciones` (`id_posicion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_personas_tipo_persona1` FOREIGN KEY (`id_tipo_persona`) REFERENCES `tipo_persona` (`id_tipo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `posiciones`
--

DROP TABLE IF EXISTS `posiciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posiciones` (
  `id_posicion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_posicion` varchar(200) NOT NULL,
  PRIMARY KEY (`id_posicion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registros_gastos_comision`
--

DROP TABLE IF EXISTS `registros_gastos_comision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registros_gastos_comision` (
  `id_registro_gasto_comision` int(11) NOT NULL AUTO_INCREMENT,
  `id_comision` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_registro_gasto_comision`),
  KEY `fk_id_comision` (`id_comision`),
  CONSTRAINT `fk_id_comision` FOREIGN KEY (`id_comision`) REFERENCES `comisiones` (`id_comision`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `secciones_formulario`
--

DROP TABLE IF EXISTS `secciones_formulario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secciones_formulario` (
  `id_seccion` int(11) NOT NULL,
  `etiqueta` varchar(254) DEFAULT NULL,
  `nombre_seccion` varchar(150) NOT NULL,
  `id_flujo` int(11) NOT NULL,
  `orden_seccion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_seccion`),
  KEY `fk_id_seccion_formulario_flujo` (`id_flujo`),
  CONSTRAINT `fk_flujo_seccion` FOREIGN KEY (`id_flujo`) REFERENCES `flujos_trabajo` (`id_flujo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sesiones_login`
--

DROP TABLE IF EXISTS `sesiones_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sesiones_login` (
  `id_usuario` int(11) NOT NULL,
  `id_session` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id_session`,`id_usuario`),
  KEY `fk_sesiones_login_usuarios1_idx` (`id_usuario`),
  CONSTRAINT `fk_sesiones_login_usuarios1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `smtp_config`
--

DROP TABLE IF EXISTS `smtp_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smtp_config` (
  `id` int(11) NOT NULL,
  `host` varchar(100) DEFAULT NULL,
  `puerto` varchar(10) DEFAULT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suscripcion_config`
--

DROP TABLE IF EXISTS `suscripcion_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suscripcion_config` (
  `id_dependencia` int(11) NOT NULL,
  `campo` varchar(60) NOT NULL,
  PRIMARY KEY (`id_dependencia`,`campo`),
  KEY `suscripcion_config_campos_dinamicos_FK` (`campo`),
  CONSTRAINT `suscripcion_config_campos_dinamicos_FK` FOREIGN KEY (`campo`) REFERENCES `campos_dinamicos` (`nombre_campo`),
  CONSTRAINT `suscripcion_config_dependencias_FK` FOREIGN KEY (`id_dependencia`) REFERENCES `dependencias` (`id_dependencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suscripcion_email_config`
--

DROP TABLE IF EXISTS `suscripcion_email_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suscripcion_email_config` (
  `id_persona` int(11) NOT NULL,
  `email` varchar(200) NOT NULL,
  `nombres` varchar(200) NOT NULL DEFAULT '',
  `apellido1` varchar(200) NOT NULL DEFAULT '',
  `apellido2` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_persona`,`email`,`nombres`,`apellido1`,`apellido2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_persona`
--

DROP TABLE IF EXISTS `tipo_persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_persona` (
  `id_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_tipo` varchar(30) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(30) NOT NULL,
  `contrasena` varchar(300) NOT NULL,
  `salt` varchar(200) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `habilitado` tinyint(1) NOT NULL,
  `intentos` int(11) DEFAULT NULL,
  `jefe_area` tinyint(1) DEFAULT '0',
  `id_perfil` int(11) NOT NULL,
  `id_dependencia` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `id_area` int(11) NOT NULL,
  `id_bonita` mediumtext,
  PRIMARY KEY (`id_usuario`),
  KEY `fk_usuarios_perfiles_idx` (`id_perfil`),
  KEY `fk_usuarios_dependencias1_idx` (`id_dependencia`),
  KEY `fk_usuarios_funcionarios1_idx` (`id_persona`),
  KEY `fk_usuarios_areas1_idx` (`id_area`),
  CONSTRAINT `fk_usuarios_areas1` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id_area`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_dependencias1` FOREIGN KEY (`id_dependencia`) REFERENCES `dependencias` (`id_dependencia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_funcionarios1` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_perfiles` FOREIGN KEY (`id_perfil`) REFERENCES `perfiles` (`id_perfil`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `valores_dinamicos`
--

DROP TABLE IF EXISTS `valores_dinamicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valores_dinamicos` (
  `id_lista` int(11) NOT NULL,
  `codigo` varchar(30) NOT NULL,
  `valor` varchar(150) NOT NULL,
  PRIMARY KEY (`id_lista`,`codigo`),
  KEY `fk_valores_dinamicos_listas_valores1_idx` (`id_lista`),
  CONSTRAINT `fk_valores_dinamicos_listas_valores1` FOREIGN KEY (`id_lista`) REFERENCES `listas_valores` (`id_lista`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `viajes_claros_config`
--

DROP TABLE IF EXISTS `viajes_claros_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `viajes_claros_config` (
  `tabla` varchar(50) NOT NULL DEFAULT '',
  `campo` varchar(50) NOT NULL,
  PRIMARY KEY (`tabla`,`campo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `viajes_claros_detalle`
--

DROP TABLE IF EXISTS `viajes_claros_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `viajes_claros_detalle` (
  `id_viaje` int(11) NOT NULL,
  `tabla` varchar(50) NOT NULL,
  `campo` varchar(50) NOT NULL,
  `valor_texto` varchar(5000) DEFAULT NULL,
  `valor_numerico` double DEFAULT NULL,
  `valor_fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id_viaje`,`tabla`,`campo`),
  KEY `fk_viajes_claros_detalle_viajes_claros_config1_idx` (`tabla`,`campo`),
  CONSTRAINT `fk_viajes_claros_detalle_viajes_claros_instancias1` FOREIGN KEY (`id_viaje`) REFERENCES `viajes_claros_instancias` (`id_viaje`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `viajes_claros_instancias`
--

DROP TABLE IF EXISTS `viajes_claros_instancias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `viajes_claros_instancias` (
  `id_viaje` int(11) NOT NULL AUTO_INCREMENT,
  `id_dependencia` int(11) NOT NULL,
  `fecha_publicacion` datetime DEFAULT NULL,
  `id_comision` int(11) DEFAULT NULL,
  `id_archivo` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_viaje`),
  KEY `fk_viajes_claros_instancias_dependencias1_idx` (`id_dependencia`),
  KEY `fk_viajes_claros_instancias_archivos_procesados1_idx` (`id_archivo`),
  KEY `fk_viajes_claros_instancias_comisiones1_idx` (`id_comision`),
  CONSTRAINT `fk_viajes_claros_instancias_comisiones1` FOREIGN KEY (`id_comision`) REFERENCES `comisiones` (`id_comision`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_viajes_claros_instancias_dependencias1` FOREIGN KEY (`id_dependencia`) REFERENCES `dependencias` (`id_dependencia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11285 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'viajes_claros'
--
/*!50003 DROP FUNCTION IF EXISTS `actualiza_archivos_procesados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_archivos_procesados`(id bigint, tot int(11), rech int(11), acep int(11)) RETURNS int(11)
BEGIN

	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`archivos_procesados`
	where 1=1
	and id_archivo = id;

	if vn_existe > 0 then
		update `viajes_claros`.`archivos_procesados`
        set total_registros = tot,
			total_aceptados = rech,
			total_rechazados = acep
		where id_archivo = id;
        
        return 0;
		
	else
		return 1;
	end if;	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_area` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_area`(id integer, nombre text, id_dep integer) RETURNS int(11)
BEGIN
	update `viajes_claros`.`areas`
	set nombre_area = nombre
	   ,id_dependencia = id_dep
	where 1=1
    and id_area = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_categoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_categoria`(id int, nombre text, hospedaje double, viaticos double) RETURNS int(11)
BEGIN
	update `viajes_claros`.`categoria`
	set nombre_categoria = nombre
	   ,tope_hospedaje = hospedaje
	   ,tope_viaticos = viaticos
	where id_categoria = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_ciudad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_ciudad`(id integer, nombre text, pais integer, edo integer
																	 ,lat text, lon text) RETURNS int(11)
BEGIN
	update `viajes_claros`.`ciudades`
	set nombre_ciudad = nombre
	   ,id_pais = pais
	   ,id_estado = edo
	   ,latitud = lat
	   ,longitud = lon
	where 1=1
    and id_ciudad = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_contra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_contra`(id int, contra text, salt text) RETURNS int(11)
BEGIN
	update `viajes_claros`.`usuarios`
	set contrasena = contra
	    ,salt = salt
	where id_usuario = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_dependencia`(id integer, sig text, nombre text, pred boolean) RETURNS int(11)
BEGIN
	if pred = true then
		update `viajes_claros`.`dependencias`
		set predeterminada = false
		where 1=1;
	end if;

	update `viajes_claros`.`dependencias`
	set siglas = sig
       ,nombre_dependencia = nombre
	   ,predeterminada = pred
	where 1=1
    and id_dependencia = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_edo_comision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_edo_comision`(comision integer, edo text) RETURNS int(11)
BEGIN
	update `viajes_claros`.`comisiones`
	set estatus = edo
	where id_comision = comision;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_estado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_estado`(id integer, nombre text, pais integer) RETURNS int(11)
BEGIN
	update `viajes_claros`.`estados`
	set nombre_estado = nombre
	   ,id_pais = pais
	where 1=1
    and id_estado = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_grupo_aprobacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_grupo_aprobacion`(id integer, nom text, proc integer, dep integer, area integer, jerar integer) RETURNS int(11)
BEGIN
	update `viajes_claros`.`configuracion_aprobacion`
	set id_flujo = proc
	   ,id_dependencia = dep
	   ,id_area = area
	   ,id_jerarquia = jerar
	   ,nombre = nom
	where id_miembro = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_id_bonita` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_id_bonita`(id int, bonita long) RETURNS int(11)
BEGIN
	update `viajes_claros`.`usuarios`
	set id_bonita = bonita
	where id_usuario = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_instancia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_instancia`(flujo integer, inst long, comis integer, fin boolean, asig boolean) RETURNS int(11)
BEGIN
	if asig = true then
		update `viajes_claros`.`flujos_instancias`
		set asignado = asig
		where 1=1
		and flujo = flujo
		and inst = inst
		and comis = comis;

	elseif fin = true then
		update `viajes_claros`.`flujos_instancias`
		set fecha_fin = now()
		where 1=1
		and flujo = flujo
		and inst = inst
		and comis = comis;
	end if;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_jerarquia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_jerarquia`(id integer, nombre text) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`jerarquias`
	where 1=1
	and upper(nombre_jerarquia) = upper(nombre);

	if vn_existe > 0 then
		return 1;
	else
		update `viajes_claros`.`jerarquias`
		set nombre_jerarquia = nombre
		where id_jerarquia = id;

		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_miembro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_miembro`(id integer, id_jerar integer, id_usu integer) RETURNS int(11)
BEGIN
	update `viajes_claros`.`jerarquia_miembros`
	set id_jerarquia = id_jerar
	   ,id_usuario = id_usu
	where id_miembro = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_pais` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_pais`(id integer, codigo text, nombre text, predet boolean) RETURNS int(11)
BEGIN
	if predet = true then
		update `viajes_claros`.`paises`
		set predeterminado = false
		where 1=1;
	end if;

	update `viajes_claros`.`paises`
	set clave_pais = codigo
	   ,nombre_pais = nombre
	   ,predeterminado = predet
	where 1=1
    and id_pais = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_persona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_persona`(id int, nombre text, ape_Paterno text, ape_Materno text
																	  ,tit text, e_mail text, id_cat integer, id_tipo integer
																	  ,id_pos integer, car text, fec_ing datetime) RETURNS int(11)
BEGIN
	if id_pos = 0 then
		update `viajes_claros`.`personas`
		set nombres = nombre
		   ,apellido_paterno = ape_Paterno
		   ,apellido_materno = ape_Materno
		   ,titulo = tit
		   ,email = e_mail
		   ,id_categoria = id_cat
		   ,id_tipo_persona = id_tipo
		   ,id_posicion = null
		   ,cargo = car
		   ,fecha_ingreso = fec_ing
		where id_persona = id;
	
	else
		update `viajes_claros`.`personas`
		set nombres = nombre
		   ,apellido_paterno = ape_Paterno
		   ,apellido_materno = ape_Materno
		   ,titulo = tit
		   ,email = e_mail
		   ,id_categoria = id_cat
		   ,id_tipo_persona = id_tipo
		   ,id_posicion = id_pos
		   ,cargo = car
		   ,fecha_ingreso = fec_ing
		where id_persona = id;
	end if;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_posicion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_posicion`(id integer, nombre text) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`posiciones`
	where 1=1
	and upper(nombre_posicion) = upper(nombre);

	if vn_existe > 0 then
		return 1;
	else
		update `viajes_claros`.`posiciones`
		set nombre_posicion = nombre
		where id_posicion = id;

		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_usuario`(id integer, us text,contr text, descr text,hab boolean,ints integer,
																	   perf integer, dep integer, per integer, area integer,
																	   jf_area boolean) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`usuarios`
	where 1=1
	and upper(usuario) = upper(us);

	if vn_existe > 0 then
		return 1;
	else

		update `viajes_claros`.`usuarios`
		set descripcion = descr
		   ,habilitado = hab
		   ,id_perfil = perf
		   ,id_dependencia = dep
		   ,id_persona = per
		   ,id_area = area
		   ,intentos = CASE
						WHEN hab = true THEN 0
						ELSE intentos
						END
		   ,jefe_area = jf_area
		where 1=1
		and id_usuario = id;

		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `actualiza_viajes_claros_det` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_viajes_claros_det`(id int(11), tab text, camp text, valorT text, valorN double, valorF DateTime) RETURNS int(11)
BEGIN
	declare vn_existe int;
    
    select count(*)
    into vn_existe
    from viajes_claros.viajes_claros_detalle
    where id_viaje = id
    and tabla = tab
	and campo = camp;
    
    if(vn_existe > 0) then
		update viajes_claros.viajes_claros_detalle 
        set valor_texto = valorT,
			valor_numerico = valorN,
            valor_fecha = valorF
		where id_viaje = id
        and tabla = tab
        and campo = camp;
		
        return 0;
     else   
		return 1;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `elimina_area` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_area`(id int) RETURNS int(11)
BEGIN
	delete
	from `viajes_claros`.`areas`
	where id_area = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `elimina_categoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_categoria`(id int) RETURNS int(11)
BEGIN
	delete
	from `viajes_claros`.`categoria`
	where id_categoria = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `elimina_ciudad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_ciudad`(id int) RETURNS int(11)
BEGIN
	delete
	from `viajes_claros`.`ciudades`
	where id_ciudad = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `elimina_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_dependencia`(id int) RETURNS int(11)
BEGIN
	delete
	from `viajes_claros`.`dependencias`
	where id_dependencia = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `elimina_estado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_estado`(id int) RETURNS int(11)
BEGIN
	delete
	from `viajes_claros`.`estados`
	where id_estado = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `elimina_grupo_aprobacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_grupo_aprobacion`(id int) RETURNS int(11)
BEGIN
	delete
	from `viajes_claros`.`configuracion_aprobacion`
	where id_conf_aprobacion = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `elimina_jerarquia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_jerarquia`(id int) RETURNS int(11)
BEGIN
	delete
	from `viajes_claros`.`jerarquias`
	where id_jerarquia = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `elimina_miembro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_miembro`(id int) RETURNS int(11)
BEGIN
	delete
	from `viajes_claros`.`jerarquia_miembros`
	where id_miembro = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `elimina_pais` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_pais`(id int) RETURNS int(11)
BEGIN
	delete
	from `viajes_claros`.`paises`
	where id_pais = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `elimina_persona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_persona`(id int) RETURNS int(11)
BEGIN
	delete
	from `viajes_claros`.`personas`
	where id_persona = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `elimina_posicion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_posicion`(id int) RETURNS int(11)
BEGIN
	delete
	from `viajes_claros`.`posiciones`
	where id_posicion = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `elimina_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_usuario`(id int) RETURNS int(11)
BEGIN
	delete
	from `viajes_claros`.`usuarios`
	where id_usuario = id;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `elimina_viajes_claros_det` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_viajes_claros_det`(id int(11), tab text, camp text, valorT text, valorN double, valorF DateTime) RETURNS int(11)
BEGIN

	declare vn_existe int;    
    
	select count(*)
    into vn_existe
    from viajes_claros.viajes_claros_detalle
    where id_viaje = id;
    
    if(vn_existe > 0) then
		delete
        from viajes_claros.viajes_claros_detalle
		where id_viaje = id;
        
        delete
		from viajes_claros.viajes_claros_instancias
		where id_viaje = id;
                
        return  0;	
     else   
		return 1;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_area` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_area`(nombre text, id_dep integer) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`areas`
	where 1=1
	and upper(nombre_area) = upper(nombre)
	and id_dependencia = id_dep;

	if vn_existe > 0 then
		return 1;
	else
		insert into `viajes_claros`.`areas`
		values (default, nombre, id_dep);
		
		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_bitacora` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_bitacora`(inst bigint,flujo integer,com integer
																	,func integer,resp text) RETURNS int(11)
BEGIN
	insert into `viajes_claros`.`aprobaciones_bitacora`
	values (inst, flujo, com, func, resp, now());

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_categoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_categoria`(nombre text, hospedaje double, viaticos double) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`categoria`
	where 1=1
	and upper(nombre_categoria) = upper(nombre);

	if vn_existe > 0 then
		return 1;
	else
		insert into `viajes_claros`.`categoria`
		values (default, nombre, hospedaje, viaticos);
		
		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_ciudad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_ciudad`(nombre text, pais integer, edo integer
																	,lat text, lon text) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`ciudades`
	where 1=1
	and upper(nombre_ciudad) = upper(nombre)
	and id_pais = pais
	and id_estado = edo;

	if vn_existe > 0 then
		return 1;
	else
		insert into `viajes_claros`.`ciudades` (id_ciudad, nombre_ciudad, id_pais, id_estado, latitud, longitud)
		values (default, nombre, pais, edo, lat, lon);
		
		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_comision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_comision`(est text,idDep integer,idPers integer,idUsr integer) RETURNS int(11)
BEGIN
	INSERT INTO `viajes_claros`.`comisiones` VALUES(default, est, idDep, idPers, idUsr);
	RETURN LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_dependencia`(sig text, nombre text, pred boolean) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`dependencias`
	where 1=1
	and upper(siglas) = upper(sig);

	if vn_existe > 0 then
		return 1;
	else
		if pred = true then
			update `viajes_claros`.`dependencias`
			set predeterminada = false
			where 1=1;
		end if;

		insert into `viajes_claros`.`dependencias`
		values (default, sig, nombre, pred);
		
		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_estado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_estado`(nombre text, pais integer) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`estados`
	where 1=1
	and upper(nombre_estado) = upper(nombre)
	and id_pais = pais;

	if vn_existe > 0 then
		return 1;
	else
		insert into `viajes_claros`.`estados`
		values (default, nombre, pais);
		
		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_grupo_aprobacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_grupo_aprobacion`(nom text, proc integer, dep integer, area integer, jerar integer) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`configuracion_aprobacion`
	where 1=1
	and id_flujo = proc
	and id_dependencia = dep
	and id_area = area
	and id_jerarquia = jerar;

	if vn_existe > 0 then
		return 1;
	else
		insert into `viajes_claros`.`configuracion_aprobacion` (id_conf_aprobacion, nombre, id_flujo, id_dependencia
																,id_area, id_jerarquia, editable)
		values (default, nom, proc, dep, area, jerar, true);

		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_instancia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_instancia`(flujo integer, inst long, comis integer) RETURNS int(11)
BEGIN
	insert into `viajes_claros`.`flujos_instancias`
	values (inst, flujo, comis, now(), null, 0);

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_jerarquia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_jerarquia`(nombre text) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`jerarquias`
	where 1=1
	and upper(nombre_jerarquia) = upper(nombre);

	if vn_existe > 0 then
		return 1;
	else
		insert into `viajes_claros`.`jerarquias`
		values (default, nombre, true);

		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_miembro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_miembro`(id_jerar integer, id_usu integer) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`jerarquia_miembros`
	where 1=1
	and id_jerarquia = id_jerar
	and id_usuario = id_usu;

	if vn_existe > 0 then
		return 1;
	else
		insert into `viajes_claros`.`jerarquia_miembros`
		values (default, id_jerar, id_usu);

		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_pais` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_pais`(codigo text, nombre text, predet boolean) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`paises`
	where 1=1
	and upper(clave_pais) = upper(codigo);

	if vn_existe > 0 then
		return 1;
	else
		if predet = true then
			update `viajes_claros`.`paises`
			set predeterminado = false
			where 1=1;
		end if;

		insert into `viajes_claros`.`paises`
		values (default, codigo, nombre, predet);
		
		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_persona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_persona`(nombre text, ape_Paterno text, ape_Materno text
																	,tit text, e_mail text, id_cat integer
																	,id_tipo integer, id_pos integer, car text
																	,fec_ing datetime) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`personas`
	where 1=1
	and upper(email) = upper(e_mail);

	if vn_existe > 0 then
		return 1;
	else
		if id_pos = 0 then
			insert into `viajes_claros`.`personas` (id_persona, nombres, apellido_paterno, apellido_materno, titulo
													,email, id_categoria, id_tipo_persona, id_posicion, cargo, fecha_ingreso)
			values (default, nombre, ape_Paterno, ape_Materno, tit, e_mail, id_cat, id_tipo, null, car, fec_ing);
		else
			insert into `viajes_claros`.`personas` (id_persona, nombres, apellido_paterno, apellido_materno, titulo
													,email, id_categoria, id_tipo_persona, id_posicion, cargo, fecha_ingreso)
			values (default, nombre, ape_Paterno, ape_Materno, tit, e_mail, id_cat, id_tipo, id_pos, car, fec_ing);

		end if;
		
		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_posicion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_posicion`(nombre text) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`posiciones`
	where 1=1
	and upper(nombre_posicion) = upper(nombre);

	if vn_existe > 0 then
		return 1;
	else
		insert into `viajes_claros`.`posiciones`
		values (default, nombre);

		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_registro_gasto_comision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_registro_gasto_comision`(idComision integer) RETURNS int(11)
BEGIN
	INSERT INTO `viajes_claros`.`registros_gastos_comision` VALUES(default, idComision);
	RETURN LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_usuario`(us text, contr text, salt text, descr text,hab boolean,
																	 ints integer,perf integer, dep integer, per integer,
																	 area integer, jefe_area boolean) RETURNS int(11)
BEGIN
	declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`usuarios`
	where 1=1
	and upper(usuario) = upper(us);

	if vn_existe > 0 then
		return 1;
	else
		insert into `viajes_claros`.`usuarios` (id_usuario, usuario, contrasena, salt, descripcion, habilitado, intentos,
												id_perfil, id_dependencia, id_persona, id_area, jefe_area)
		values (default, us, contr, salt, descr, hab, ints, perf, dep, per, area, jefe_area);
		
		return 0;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_viajes_claros_det` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_viajes_claros_det`(id_viaje int(11), tabla text, campo text, valorT text, valorN double, valorF DateTime) RETURNS int(11)
BEGIN

		insert into `viajes_claros`.`viajes_claros_detalle`
		values (id_viaje, tabla, campo, valorT, valorN, valorF);
		
		return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `inserta_viajes_claros_instancias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_viajes_claros_instancias`(id_dep int(11), id_arch bigint) RETURNS int(11)
BEGIN
	
		insert into `viajes_claros`.`viajes_claros_instancias`
		values (default, id_dep, now(), null, id_arch);
		
		return LAST_INSERT_ID();
	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `publica_viaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `publica_viaje`(comision integer, depen integer) RETURNS int(11)
BEGIN
	declare v_id int;

	insert into viajes_claros.viajes_claros_instancias
	values (default, depen, now(), comision, null);

	SELECT LAST_INSERT_ID() INTO v_id;

	insert into viajes_claros.viajes_claros_detalle
	select v_id, tabla, campo, valor_texto, valor_numerico, valor_fecha
	from viajes_claros.comisiones_detalle
	where id_comision = comision;

	return 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `valida_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `valida_usuario`(usuario text, contra text) RETURNS int(11)
BEGIN
	declare existe int;
	declare ints int;

	select count(*)
	into existe
	from `viajes_claros`.`usuarios`
	where 1=1
	and usuario = usuario
	and contrasena = contra
	and habilitado = true;

	if (existe = 1) then
		select count(*)
		into existe
		from `viajes_claros`.`usuarios`
		where 1=1
		and usuario = usuario;

		if existe > 0 then
			update `viajes_claros`.`usuarios`
			set intentos = intentos + 1
			where 1=1
			and usuario = usuario;

			select intentos
			into ints
			from `viajes_claros`.`usuarios`
			where 1=1
			and usuario = usuario;

			if ints = 5 then
				update `viajes_claros`.`usuarios`
				set habilitado = false
				where 1=1
				and usuario = usuario;
			end if;

		end if;

		return ints;
	else
		update `viajes_claros`.`usuarios`
		set intentos = 0
		where 1=1
		and usuario = usuario;

		return 0;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_buscador_despliegue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_buscador_despliegue`(idDep INT, nombreTabla VARCHAR(50), nombreCampo VARCHAR(50))
BEGIN
	
	DELETE FROM buscador_despliegue_config
	WHERE id_dependencia = idDep
	AND tabla = nombreTabla
	AND campo = nombreCampo;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_buscador_filtro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_buscador_filtro`(idDep INT, 
		nombreTabla VARCHAR(50), nombreCampo VARCHAR(50))
BEGIN
	
	DELETE FROM buscador_filtros_config 
	WHERE id_dependencia=idDep
	AND tabla=nombreTabla
	AND campo=nombreCampo;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_campo_dinamico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_campo_dinamico`(nombreCampo VARCHAR(50))
BEGIN
	
	DELETE FROM campos_dinamicos WHERE nombre_campo=nombreCampo;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_flujos_campos_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_flujos_campos_config`(
		IN idFlujo INT(11), IN idTipoPersona INT(11), 
		IN inTabla VARCHAR(100), IN inCampo VARCHAR(100))
BEGIN
	
	
DELETE FROM  flujos_campos_config
WHERE id_flujo=idFlujo AND id_tipo_persona=idTipoPersona AND tabla=inTabla AND campo=inCampo;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_gasto_campo_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_gasto_campo_config`(
		IN idGastoCampoConfig INT(11))
BEGIN
	
	
DELETE FROM  gastos_campos_config
WHERE id_gasto_campo_config=idGastoCampoConfig;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_graficas_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_graficas_dependencia`(idDependencia INT(11))
BEGIN
	
	
DELETE FROM graficas_config WHERE id_dependencia=idDependencia;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_interfaz_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_interfaz_config`(inTabla VARCHAR(100), inCampo VARCHAR(100),
	idDependencia INT(11))
BEGIN

	
DELETE FROM  viajes_claros.interfaz_config
WHERE tabla=inTabla AND campo=inCampo AND id_dependencia=idDependencia;


	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_listas_valores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_listas_valores`(idLista INT)
BEGIN
	
	DELETE FROM listas_valores WHERE id_lista=idLista;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_registro_gastos_id_comision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_registro_gastos_id_comision`(IN idComision INT(11),IN idRegistroGastoComision INT(11))
BEGIN	
DELETE FROM comisiones_desglose_gastos WHERE id_registro_gasto_comision=idRegistroGastoComision;
DELETE FROM registros_gastos_comision WHERE id_comision = idComision AND id_registro_gasto_comision=idRegistroGastoComision;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_seccion_formulario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_seccion_formulario`(idSeccion INT(11))
BEGIN
	
	
DELETE FROM  viajes_claros.secciones_formulario
WHERE id_seccion=idSeccion;
	
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_suscripcion_config_por_dep` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_suscripcion_config_por_dep`(IN idDependencia INT(11))
BEGIN
	
DELETE FROM suscripcion_config WHERE id_dependencia=idDependencia;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_valores_dinamicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_valores_dinamicos`(IN idLista INT(10), IN inCodigo VARCHAR(30))
BEGIN
	
	DELETE FROM valores_dinamicos WHERE id_lista=idLista AND codigo=inCodigo;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_viajes_claros_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_viajes_claros_config`(nombreTabla VARCHAR(50), nombreCampo VARCHAR(50))
BEGIN
	
	DELETE FROM  viajes_claros_config
WHERE tabla=nombreTabla AND campo=nombreCampo;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `elimina_procesados_det` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `elimina_procesados_det`(id_arch bigint)
BEGIN
	delete from `viajes_claros`.`archivo_lineas`
	where id_archivo = id_arch;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `es_comision_nacional` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `es_comision_nacional`(com integer)
BEGIN
	select count(*)
	from viajes_claros.comisiones_detalle cd
		,viajes_claros.paises p
	where 1=1
	and cd.id_comision = com
	and cd.campo = 'pais_destino'
	and p.predeterminado = 1
	and p.nombre_pais = cd.valor_texto;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `exists_valor_dinamico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `exists_valor_dinamico`(IN idLista INT(10), IN inCodigo VARCHAR(30))
BEGIN
	
	SELECT id_lista,codigo FROM valores_dinamicos WHERE id_lista=idLista AND codigo=inCodigo;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_areas_con_comisiones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_areas_con_comisiones`()
BEGIN

SELECT a.id_area AS id_area, a.nombre_area AS nombre_area
FROM areas a
INNER JOIN usuarios u ON u.id_area=a.id_area
INNER JOIN personas p ON p.id_persona=u.id_persona
INNER JOIN comisiones c ON c.id_persona=p.id_persona
WHERE a.id_dependencia = 4
GROUP BY id_area
UNION
SELECT a.id_area AS id_area, a.nombre_area AS nombre_area
FROM areas a
INNER JOIN viajes_claros_detalle vcd ON a.id_area = vcd.valor_numerico AND vcd.campo = 'id_area' AND vcd.tabla = 'areas'
INNER JOIN viajes_claros_instancias vci ON vcd.id_viaje = vci.id_viaje
GROUP BY id_area;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_areas_con_comisiones_calendar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_areas_con_comisiones_calendar`(mes INT(11), anio INT(11))
BEGIN
	
	
SELECT a.id_area, a.nombre_area 
FROM areas a
INNER JOIN usuarios u ON u.id_area=a.id_area
INNER JOIN personas p ON p.id_persona=u.id_persona
INNER JOIN comisiones c ON c.id_persona=p.id_persona
INNER JOIN comisiones_detalle ini ON ini.id_comision=c.id_comision AND ini.tabla='' AND ini.campo='fecha_hora_salida'
WHERE YEAR(ini.valor_fecha)=anio
AND MONTH(ini.valor_fecha)=mes
GROUP BY id_area;

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_calendario_eventos_mes_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_calendario_eventos_mes_anio`(IN mes INT, IN anio INT, IN idArea INT, IN idFunc INT, IN status VARCHAR(10))
BEGIN
 
	

SELECT d.id_comision, 
		CONCAT(p.nombres, ' ', p.apellido_paterno, ' ', p.apellido_materno) AS title, 
		DATE_FORMAT(d.valor_fecha, '%Y-%m-%d')  as start,
		DATE_FORMAT(d.valor_fecha, '%d/%m/%Y')  as startShowed, 
		IFNULL(DATE_FORMAT(DATE_ADD(fin.valor_fecha, INTERVAL 1 DAY) , '%Y-%m-%d'), '')  as end,
		IFNULL(DATE_FORMAT(fin.valor_fecha, '%d/%m/%Y'), '')  as endShowed,
		a.nombre_area, IFNULL(cd.valor_texto, '') as ciudad_destino,
		IFNULL(pa.valor_texto, '') as pais_destino,
		CASE WHEN com.estatus='P' THEN 'COMISIÃ“N PUBLICADA' 
			ELSE CASE WHEN com.estatus='EA' THEN 'COMISIÃ“N EN ESPERA DE APROBACIÃ“N' 
				ELSE CASE WHEN com.estatus='R' THEN 'COMISIÃ“N RECHAZADA' 
					ELSE CASE WHEN com.estatus='A' THEN 'COMISIÃ“N AUTORIZADA' 
						ELSE CASE WHEN com.estatus='EV' THEN 'COMISIÃ“N EN APROBACIÃ“N DE VIÃTICO' 
							ELSE CASE WHEN com.estatus='RV' THEN 'COMISIÃ“N RECHAZADA EN VIÃTICOS' 
								ELSE CASE WHEN com.estatus='F' THEN 'COMISIÃ“N FONDEADA' 
									ELSE CASE WHEN com.estatus='EG' THEN 'COMISIÃ“N EN APROBACIÃ“N DE GASTOS' 
										ELSE CASE WHEN com.estatus='RG' THEN 'COMISIÃ“N RECHAZADA EN GASTOS' 
											ELSE CASE WHEN com.estatus='CM' THEN 'COMISIÃ“N COMPROBADA' 
												ELSE CASE WHEN com.estatus='EP' THEN 'COMISIÃ“N EN ESPERA DE PUBLICACIÃ“N' 
													ELSE CASE WHEN com.estatus='RP' THEN 'COMISIÃ“N RECHAZADA EN PUBLICACIÃ“N' 
			ELSE '' END END END END END END END END END END END END as estatus,
		CASE WHEN com.estatus='P' THEN '#7AC2D2' 
			eLSE CASE WHEN com.estatus IN('R', 'RV', 'RG', 'RP') THEN '#FFA07D'
				ELSE '#f2df6d'  END END as color  
FROM comisiones_detalle d
INNER JOIN comisiones com ON com.id_comision=d.id_comision
INNER JOIN personas p ON p.id_persona=com.id_persona
INNER JOIN usuarios u ON u.id_persona=p.id_persona
INNER JOIN areas a ON a.id_area=u.id_area
LEFT JOIN comisiones_detalle fin ON fin.id_comision=d.id_comision AND fin.tabla='' AND fin.campo='fecha_hora_regreso'
LEFT JOIN comisiones_detalle cd ON cd.id_comision=d.id_comision AND cd.tabla='' AND cd.campo='ciudad_destino'
LEFT JOIN comisiones_detalle pa ON pa.id_comision=d.id_comision AND pa.tabla='' AND pa.campo='pais_destino'
WHERE d.tabla='' AND d.campo='fecha_hora_salida'
AND YEAR(d.valor_fecha)=anio
AND (MONTH(d.valor_fecha)=mes or MONTH(d.valor_fecha)=mes-1 or MONTH(d.valor_fecha)=mes+1)
AND CASE WHEN idArea IS NULL THEN true ELSE a.id_area=idArea END
AND CASE WHEN idFunc IS NULL THEN true ELSE p.id_persona=idFunc END
AND CASE WHEN (status='' OR status IS NULL) THEN true 
	ELSE CASE WHEN status='PUBLICADO' THEN com.estatus='P'
		ELSE CASE WHEN status='RECHAZADO' THEN com.estatus in ('R', 'RV', 'RG', 'RP')
			ELSE CASE WHEN status='PENDIENTE' THEN com.estatus not in ('P', 'R', 'RV', 'RG', 'RP')
				END END END END

UNION ALL
SELECT i.id_viaje, CONCAT(n.valor_texto, ' ', a1.valor_texto, ' ', IFNULL(a2.valor_texto, '')) as title,
	DATE_FORMAT(ini.valor_fecha, '%Y-%m-%d')  as start, 
	DATE_FORMAT(ini.valor_fecha, '%d/%m/%Y')  as startShowed,
	IFNULL(DATE_FORMAT(DATE_ADD(fin.valor_fecha, INTERVAL 1 DAY) , '%Y-%m-%d'), '')  as end,
	IFNULL(DATE_FORMAT(fin.valor_fecha, '%d/%m/%Y'), '')  as endShowed,
	'' as nombre_area,
	IFNULL(cd.valor_texto, '') as ciudad_destino,
	IFNULL(pa.valor_texto, '') as pais_destino,
	'COMISIÃ“N PUBLICADA'  as estatus,
	'#7AC2D2' as coloe
FROM viajes_claros_instancias i
INNER JOIN viajes_claros_detalle ini ON ini.id_viaje=i.id_viaje AND ini.tabla='' AND ini.campo='fecha_hora_salida'
LEFT JOIN viajes_claros_detalle fin ON fin.id_viaje=i.id_viaje AND fin.tabla='' AND fin.campo='fecha_hora_regreso'
INNER JOIN viajes_claros_detalle n ON n.id_viaje=i.id_viaje AND n.tabla='personas' AND n.campo='nombres'
INNER JOIN viajes_claros_detalle a1 ON a1.id_viaje=i.id_viaje AND a1.tabla='personas' AND a1.campo='apellido_paterno'
LEFT JOIN viajes_claros_detalle a2 ON a2.id_viaje=i.id_viaje AND a2.tabla='personas' AND a2.campo='apellido_materno'
LEFT JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='' AND cd.campo='ciudad_destino'
LEFT JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='' AND pa.campo='pais_destino'
WHERE i.id_dependencia=1 
AND i.id_comision IS NULL
AND YEAR(ini.valor_fecha)=anio
AND (MONTH(ini.valor_fecha)=mes or MONTH(ini.valor_fecha)=mes-1 or MONTH(ini.valor_fecha)=mes+1)
AND CASE WHEN (idArea IS NOT NULL or idFunc IS NOT NULL) THEN false ELSE true END
AND CASE WHEN (status='' OR status IS NULL OR status='PUBLICADO') THEN true ELSE false END
;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_campos_base` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_campos_base`()
BEGIN
	
SELECT tabla, campo, descripcion, despliegue, busqueda_defecto, tipo_dato as id_tipo_dato, tipo_control as id_tipo_control,
CASE WHEN tipo_dato=1 THEN 'INT' ELSE (CASE WHEN tipo_dato=2 THEN 'VARCHAR' ELSE (CASE WHEN tipo_dato=3 THEN 'DATE' ELSE 'UNDEFINED' END)  END) END as tipo_dato, 
CASE WHEN tipo_control=1 THEN 'TEXT' ELSE (CASE WHEN tipo_control=2 THEN 'SELECT' ELSE (CASE WHEN tipo_control=3 THEN 'DATE' ELSE 'UNDEFINED' END) END) END as tipo_control
FROM 
(
SELECT tabla, campo, tipo_dato, descripcion, despliegue, busqueda_defecto, tipo_control
FROM viajes_claros.campos_base
) A;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_campos_carga_disponibles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_campos_carga_disponibles`(IN idDependencia INT(11), IN inTabla VARCHAR(200))
BEGIN

	
SELECT conf.tabla, conf.campo, i.campo as disponible, i.id_dependencia
FROM viajes_claros_config conf
LEFT JOIN interfaz_config i ON i.tabla=conf.tabla AND i.campo=conf.campo AND i.id_dependencia=idDependencia
WHERE conf.tabla=inTabla
AND i.campo IS NULL;


	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_campos_config_disponibles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_campos_config_disponibles`(nombreTabla VARCHAR(50))
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
	SET @query = @qry1;
ELSE
	SET @query = CONCAT(@qry1, ' AND tabla=''', nombreTabla, '''');
END IF;
	
	
PREPARE QUERY FROM @query;
EXECUTE QUERY;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_campos_config_por_tabla` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_campos_config_por_tabla`(IN nombreTabla VARCHAR(50))
BEGIN
	
	
SELECT tabla, campo, SUM(constraint_fails)
FROM 
(
SELECT conf.tabla, conf.campo,
	CASE WHEN b.campo IS NULL THEN (CASE WHEN f.campo IS NULL THEN (CASE WHEN v.campo IS NULL THEN false ELSE true END) ELSE true END) ELSE true END as constraint_fails
	FROM viajes_claros_config conf
	LEFT JOIN buscador_despliegue_config b ON b.tabla = conf.tabla AND b.campo = conf.campo
	LEFT JOIN buscador_filtros_config f ON f.tabla = conf.tabla AND f.campo = conf.campo
	LEFT JOIN viajes_claros_detalle v ON v.tabla = conf.tabla AND v.campo = conf.campo
	WHERE conf.tabla=nombreTabla
) A
GROUP BY tabla, campo;
	
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_campos_despliegue_disponibles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_campos_despliegue_disponibles`(
		IN idDep INT(11), IN nombreTabla VARCHAR(100))
BEGIN
	

SELECT conf.tabla, conf.campo,
CASE WHEN base.despliegue IS NULL THEN din.despliegue ELSE base.despliegue END as despliegue
FROM viajes_claros_config conf 
INNER JOIN interfaz_config carga ON carga.tabla=conf.tabla AND carga.campo=conf.campo AND carga.id_dependencia=idDep
LEFT JOIN campos_base base ON base.tabla = conf.tabla AND base.campo = conf.campo
LEFT JOIN campos_dinamicos din ON din.nombre_campo = conf.campo
WHERE (conf.tabla, conf.campo) NOT IN(
	SELECT tabla, campo 
	FROM buscador_despliegue_config
	WHERE id_dependencia = idDep)
AND conf.tabla=nombreTabla;
	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_campos_despliegue_por_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_campos_despliegue_por_dependencia`(idDep INT)
BEGIN
	
	SELECT conf.id_dependencia, conf.tabla, conf.campo,
	CASE WHEN base.despliegue IS NULL THEN din.despliegue ELSE base.despliegue END as despliegue,
    conf.orden, conf.mostrar
FROM buscador_despliegue_config conf
LEFT JOIN campos_base base ON base.tabla = conf.tabla AND base.campo = conf.campo
LEFT JOIN campos_dinamicos din ON din.nombre_campo = conf.campo
WHERE conf.id_dependencia = idDep
ORDER BY conf.orden;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_campos_dinamicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_campos_dinamicos`()
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
	) A;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_campos_filtros_disponibles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_campos_filtros_disponibles`(
		IN idDep INT(11), IN nombreTabla VARCHAR(100))
BEGIN

SELECT tabla, campo, despliegue, 
CASE WHEN tipo_dato=1 THEN 'Cadena' ELSE (CASE WHEN tipo_dato=2 THEN 'Número' ELSE (CASE WHEN tipo_dato=3 THEN 'Fecha' ELSE 'UNDEFINED' END)  END) END as tipo_dato, 
CASE WHEN tipo_control=1 THEN 'Texto' ELSE (CASE WHEN tipo_control=2 THEN 'Lista' ELSE (CASE WHEN tipo_control=3 THEN 'Calendario' ELSE 'UNDEFINED' END) END) END as tipo_control
FROM 
(
	SELECT conf.tabla, conf.campo,
	CASE WHEN base.despliegue IS NULL THEN din.despliegue ELSE base.despliegue END as despliegue,
	CASE WHEN base.tipo_dato IS NULL THEN din.tipo_dato ELSE base.tipo_dato END as tipo_dato,
		CASE WHEN base.tipo_control IS NULL THEN din.tipo_control ELSE base.tipo_control END as tipo_control
	FROM viajes_claros_config conf 
	INNER JOIN interfaz_config carga ON carga.tabla=conf.tabla AND carga.campo=conf.campo AND carga.id_dependencia=idDep
	LEFT JOIN campos_base base ON base.tabla = conf.tabla AND base.campo = conf.campo
	LEFT JOIN campos_dinamicos din ON din.nombre_campo = conf.campo
	WHERE (conf.tabla, conf.campo) NOT IN(
		SELECT tabla, campo 
		FROM buscador_filtros_config
		WHERE id_dependencia = idDep)
	AND conf.tabla=nombreTabla
) A;

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_campos_flujo_disponibles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_campos_flujo_disponibles`(
		IN idFlujo INT(11), IN idTipoPersona INT(11), IN inTabla VARCHAR(100))
BEGIN
	
SELECT conf.tabla, conf.campo, f.campo as disponible,
	IFNULL(b.categoria, d.categoria) as categoria
FROM viajes_claros_config conf
LEFT JOIN flujos_campos_config f ON f.tabla=conf.tabla AND f.campo=conf.campo AND f.id_flujo=idFlujo AND f.id_tipo_persona=idTipoPersona
LEFT JOIN campos_base b ON b.tabla=conf.tabla AND b.campo=conf.campo
LEFT JOIN campos_dinamicos d ON d.nombre_campo=conf.campo AND conf.tabla=''
WHERE conf.tabla=inTabla
AND f.campo IS NULL;	


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_campos_por_tabla_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_campos_por_tabla_config`(IN nombreTabla VARCHAR(50))
BEGIN
	
	SELECT tabla, campo, despliegue, 
CASE WHEN tipo_dato=1 THEN 'Cadena' ELSE (CASE WHEN tipo_dato=2 THEN 'NÃºmero' ELSE (CASE WHEN tipo_dato=3 THEN 'Fecha' ELSE 'UNDEFINED' END)  END) END as tipo_dato, 
CASE WHEN tipo_control=1 THEN 'Texto' ELSE (CASE WHEN tipo_control=2 THEN 'Lista' ELSE (CASE WHEN tipo_control=3 THEN 'Calendario' ELSE 'UNDEFINED' END) END) END as tipo_control
FROM 
(
SELECT conf.tabla, conf.campo, 
CASE WHEN base.despliegue IS NULL THEN din.despliegue ELSE base.despliegue END as despliegue,
CASE WHEN base.tipo_dato IS NULL THEN din.tipo_dato ELSE base.tipo_dato END as tipo_dato,
CASE WHEN base.tipo_control IS NULL THEN din.tipo_control ELSE base.tipo_control END as tipo_control
FROM viajes_claros_config conf
LEFT JOIN campos_base base ON base.tabla = conf.tabla AND base.campo = conf.campo
LEFT JOIN campos_dinamicos din ON din.nombre_campo = conf.campo
WHERE conf.tabla = nombreTabla) A ;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_campo_dinamico_por_nombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_campo_dinamico_por_nombre`(nombreCampo VARCHAR(50))
BEGIN
	
SELECT nombre_campo, tipo_dato, id_lista, descripcion, despliegue, 
		busqueda_defecto, tipo_control
FROM campos_dinamicos
WHERE nombre_campo=nombreCampo;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_catalogo_tabla_campo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_catalogo_tabla_campo`(IN tabla VARCHAR(50), IN campo VARCHAR(50))
BEGIN
	
	
	
	SET @IdColumn = (SELECT k.COLUMN_NAME
	FROM information_schema.table_constraints t
	LEFT JOIN information_schema.key_column_usage k
	USING(constraint_name,table_schema,table_name)
	WHERE t.constraint_type='PRIMARY KEY'
    AND t.table_schema=DATABASE()
    AND t.table_name=tabla);
    
SET @query = CONCAT('SELECT ', @IdColumn, ' , ', campo, ' FROM ', tabla);
    
PREPARE QUERY FROM @query;
EXECUTE QUERY;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_categorias_campo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_categorias_campo`()
BEGIN

	select categoria, descripcion from categoria_campo;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_cat_comparadores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_cat_comparadores`()
BEGIN
	
	SELECT v.id_lista, v.valor 
	FROM valores_dinamicos v 
	INNER JOIN campos_dinamicos c ON c.id_lista = v.id_lista
	AND c.nombre_campo='comparador';
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_comisiones_detalle_por_id_comision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_comisiones_detalle_por_id_comision`(idPersona INT(11))
BEGIN

	
SELECT c.id_comision, c.estatus, c.id_dependencia, c.id_persona, c.id_usuario
FROM comisiones c

WHERE id_persona=idPersona
AND estatus != 'P'
ORDER BY c.id_comision;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_comisiones_en_curso_por_id_persona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_comisiones_en_curso_por_id_persona`(idPersona INT(11))
BEGIN

	
SELECT c.id_comision, c.estatus, c.id_dependencia, c.id_persona, c.id_usuario
FROM comisiones c
WHERE id_persona=idPersona
AND estatus != 'P'
ORDER BY c.id_comision;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_comision_desglose_gastos_id_comision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_comision_desglose_gastos_id_comision`(IN idComision INT(11))
BEGIN	
SELECT
	CASE WHEN cdg.valor_texto IS NOT NULL AND g.lista_habilitada=0 THEN cdg.valor_texto
		ELSE CASE WHEN cdg.valor_texto IS NOT NULL AND g.lista_habilitada=1 THEN (
				SELECT vd.valor FROM valores_dinamicos vd WHERE vd.id_lista = cd.id_lista AND vd.codigo = cdg.valor_texto)
			ELSE CASE WHEN cdg.valor_numerico IS NOT NULL AND cdg.valor_numerico <> 0 THEN cdg.valor_numerico
				ELSE CASE WHEN cdg.valor_fecha IS NOT NULL THEN DATE_FORMAT(cdg.valor_fecha,'%d-%m-%Y')
					ELSE 'NO DEFINIDO'
				END
			END
		END
	END AS valor,
    cdg.id_registro_gasto_comision
FROM comisiones_desglose_gastos cdg
INNER JOIN gastos_campos_config g ON g.campo = cdg.campo
INNER JOIN campos_dinamicos cd ON cd.nombre_campo = g.campo
WHERE cdg.id_comision=idComision
ORDER BY cdg.id_registro_gasto_comision, g.orden;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_comision_desglose_gastos_id_registro_gasto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_comision_desglose_gastos_id_registro_gasto`(IN idRegistro INT(11))
BEGIN	
SELECT
	cdg.id_registro_gasto_comision,
    cdg.campo,
    g.etiqueta,
	CASE WHEN cdg.valor_texto IS NOT NULL THEN cdg.valor_texto
		ELSE CASE WHEN cdg.valor_numerico IS NOT NULL AND cdg.valor_numerico <> 0 THEN cdg.valor_numerico
			ELSE CASE WHEN cdg.valor_fecha IS NOT NULL THEN DATE_FORMAT(cdg.valor_fecha,'%Y-%m-%d')
				ELSE 'NO DEFINIDO'
			END
		END
	END AS valor_campo,
    g.lista_habilitada, g.obligatorio, g.orden,d.id_lista,
	CASE WHEN d.tipo_control=1 THEN 'TEXTO' 
		ELSE CASE WHEN d.tipo_control=2 THEN 'LISTA'
			ELSE CASE WHEN d.tipo_control=3 THEN 'CALENDARIO'
				ELSE 'OTRO' END END END as tipo_control,
	CASE WHEN d.tipo_dato=1 THEN 'NUMERO' 
		ELSE (CASE WHEN d.tipo_dato=2 THEN 'TEXTO' 
			ELSE (CASE WHEN d.tipo_dato=3 THEN 'FECHA' 
				ELSE 'UNDEFINED' END)  END) END as tipo_dato,
	g.subtipo
FROM comisiones_desglose_gastos cdg
INNER JOIN gastos_campos_config g ON g.campo = cdg.campo
LEFT JOIN campos_dinamicos d ON d.nombre_campo=g.campo
WHERE cdg.id_registro_gasto_comision=idRegistro
ORDER BY g.orden;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_comision_detalle_id_comision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_comision_detalle_id_comision`(IN idComision INT(11),IN tabla varchar(50),IN campo varchar(50),IN tipoValor tinyint(4))
BEGIN	
SELECT 
	CASE WHEN tipoValor=1 THEN cd.valor_numerico 
		ELSE (CASE WHEN tipoValor=2 THEN cd.valor_texto
			ELSE (CASE WHEN tipoValor=3 THEN cd.valor_fecha
				ELSE 'UNDEFINED' END)  END) END as valor_campo
FROM comisiones_detalle cd
WHERE cd.id_comision=idComision AND cd.tabla = tabla AND cd.campo = campo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_dependencias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_dependencias`()
BEGIN
	
	SELECT id_dependencia, nombre_dependencia, siglas, predeterminada FROM dependencias ORDER BY predeterminada DESC, id_dependencia;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_desglose_gastos_id_comision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_desglose_gastos_id_comision`(IN idComision INT(11),IN idRegistroGastoComision INT(11),IN campo varchar(50),IN tipoValor tinyint(4))
BEGIN	
SELECT 
	CASE WHEN tipoValor=1 THEN cdg.valor_numerico 
		ELSE (CASE WHEN tipoValor=2 THEN cdg.valor_texto
			ELSE (CASE WHEN tipoValor=3 THEN cdg.valor_fecha
				ELSE 'UNDEFINED' END)  END) END as valor_campo
FROM comisiones_desglose_gastos cdg
WHERE cdg.id_comision=idComision AND cdg.id_registro_gasto_comision=idRegistroGastoComision AND cdg.campo = campo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_detalle_usuario_por_nombre_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_detalle_usuario_por_nombre_usuario`(IN inUsuario VARCHAR(254))
BEGIN

	SELECT personas.id_persona, 
		personas.nombres, 
		personas.apellido_paterno, 
		personas.apellido_materno, 
		personas.email,
        personas.id_tipo_persona,
		dependencias.nombre_dependencia,
		areas.nombre_area,
		personas.cargo,
		tipo_persona.descripcion,
		categoria.nombre_categoria,
		usuarios.usuario,
        dependencias.id_dependencia,
        usuarios.id_usuario,
        CASE WHEN posiciones.nombre_posicion LIKE 'HB%' OR posiciones.nombre_posicion LIKE 'KB%' OR posiciones.nombre_posicion LIKE 'KA%'
			THEN 'AN'
			ELSE CASE WHEN personas.id_tipo_persona != 3
				THEN 'TEC'
				ELSE 'INV' 
			END 
		END
        AS tipo_representacion
	FROM personas
	INNER JOIN usuarios ON personas.id_persona = usuarios.id_persona
	INNER JOIN areas ON usuarios.id_area = areas.id_area
	INNER JOIN dependencias ON areas.id_dependencia = dependencias.id_dependencia
	INNER JOIN tipo_persona ON personas.id_tipo_persona = tipo_persona.id_tipo
	INNER JOIN categoria ON personas.id_categoria = categoria.id_categoria
    INNER JOIN posiciones ON personas.id_posicion = posiciones.id_posicion
	WHERE usuarios.usuario=inUsuario;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_filtros_por_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_filtros_por_dependencia`(IN idDependencia INT(10))
BEGIN
	SELECT id_dependencia, tabla, campo, despliegue, 
	CASE WHEN tipo_dato=1 THEN 'INT' ELSE (CASE WHEN tipo_dato=2 THEN 'VARCHAR' ELSE (CASE WHEN tipo_dato=3 THEN 'DATE' ELSE 'UNDEFINED' END)  END) END as tipo_dato, 
	CASE WHEN tipo_control=1 THEN 'TEXT' ELSE (CASE WHEN tipo_control=2 THEN 'SELECT' ELSE (CASE WHEN tipo_control=3 THEN 'DATE' ELSE 'UNDEFINED' END) END) END as tipo_control, 
	operador, id_lista, orden FROM 
	(
	SELECT b.id_dependencia, b.tabla, b.campo, b.operador, b.orden, din.id_lista, 
	CASE WHEN base.despliegue IS NULL THEN din.despliegue ELSE base.despliegue END as despliegue, 
	CASE WHEN base.tipo_dato IS NULL THEN din.tipo_dato ELSE base.tipo_dato END as tipo_dato,
	CASE WHEN base.tipo_control IS NULL THEN din.tipo_control ELSE base.tipo_control END as tipo_control
	FROM buscador_filtros_config b
	LEFT JOIN campos_base base ON base.tabla = b.tabla AND base.campo = b.campo 
	LEFT JOIN campos_dinamicos din ON din.nombre_campo = b.campo
	WHERE b.id_dependencia=idDependencia
	) A
	ORDER BY orden;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_flujos_campos_config_por_flujo_tipo_persona_seccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_flujos_campos_config_por_flujo_tipo_persona_seccion`(
	IN idFlujo INT(11), idTipoPersona INT(11), idSeccionFormulario INT(11))
BEGIN

SELECT f.id_flujo, f.tabla, f.campo, f.etiqueta, 
	f.lista_habilitada, f.id_seccion_formulario,f.obligatorio, f.orden, d.id_lista,
	CASE WHEN IFNULL(b.tipo_control, d.tipo_control)=1 THEN 'TEXTO' 
		ELSE CASE WHEN IFNULL(b.tipo_control, d.tipo_control)=2 THEN 'LISTA'
			ELSE CASE WHEN IFNULL(b.tipo_control, d.tipo_control)=3 THEN 'CALENDARIO'
				ELSE 'OTRO' END END END as tipo_control,
	CASE WHEN IFNULL(b.tipo_dato, d.tipo_dato)=1 THEN 'NUMERO' 
		ELSE (CASE WHEN IFNULL(b.tipo_dato, d.tipo_dato)=2 THEN 'TEXTO' 
			ELSE (CASE WHEN IFNULL(b.tipo_dato, d.tipo_dato)=3 THEN 'FECHA' 
				ELSE 'UNDEFINED' END)  END) END as tipo_dato,
                f.subtipo,f.solo_lectura,f.clase
FROM flujos_campos_config f
LEFT JOIN campos_base b ON b.tabla=f.tabla AND b.campo=f.campo
LEFT JOIN campos_dinamicos d ON d.nombre_campo=f.campo AND f.tabla=''
WHERE id_flujo=idFlujo
AND id_tipo_persona = idTipoPersona
AND id_seccion_formulario = idSeccionFormulario
ORDER BY f.orden;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_flujos_campos_config_por_id_flujo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_flujos_campos_config_por_id_flujo`(idFlujo INT(11))
BEGIN

SELECT id_flujo, tabla, campo, etiqueta, lista_habilitada, obligatorio
FROM viajes_claros.flujos_campos_config
WHERE id_flujo=idFlujo;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_flujos_campos_config_por_id_flujo_categoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_flujos_campos_config_por_id_flujo_categoria`(
		IN idFlujo INT(11), IN tipoPersona INT(11), IN inCategoria VARCHAR(100))
BEGIN


SELECT f.id_flujo, f.tabla, f.campo, f.etiqueta, 
	f.lista_habilitada, f.obligatorio, 
	IFNULL(b.categoria, d.categoria) as categoria,
	CASE WHEN IFNULL(b.tipo_control, d.tipo_control)=1 THEN 'TEXTO' 
		ELSE CASE WHEN IFNULL(b.tipo_control, d.tipo_control)=2 THEN 'LISTA'
			ELSE CASE WHEN IFNULL(b.tipo_control, d.tipo_control)=3 THEN 'CALENDARIO'
				ELSE 'OTRO' END END END as tipo_control
FROM flujos_campos_config f
LEFT JOIN campos_base b ON b.tabla=f.tabla AND b.campo=f.campo
LEFT JOIN campos_dinamicos d ON d.nombre_campo=f.campo AND f.tabla=''
WHERE f.id_flujo=idFlujo
AND f.id_tipo_persona=tipoPersona
AND (b.categoria=inCategoria OR d.categoria=inCategoria);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_flujos_campos_config_por_id_flujo_tipo_persona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_flujos_campos_config_por_id_flujo_tipo_persona`(
	IN idFlujo INT(11), idTipoPersona INT(11))
BEGIN	
SELECT f.id_flujo, f.tabla, f.campo, f.etiqueta, 
	f.lista_habilitada, f.id_seccion_formulario,f.obligatorio, f.orden, d.id_lista,
	CASE WHEN IFNULL(b.tipo_control, d.tipo_control)=1 THEN 'TEXTO' 
		ELSE CASE WHEN IFNULL(b.tipo_control, d.tipo_control)=2 THEN 'LISTA'
			ELSE CASE WHEN IFNULL(b.tipo_control, d.tipo_control)=3 THEN 'CALENDARIO'
				ELSE 'OTRO' END END END as tipo_control,
	CASE WHEN IFNULL(b.tipo_dato, d.tipo_dato)=1 THEN 'NUMERO' 
		ELSE (CASE WHEN IFNULL(b.tipo_dato, d.tipo_dato)=2 THEN 'TEXTO' 
			ELSE (CASE WHEN IFNULL(b.tipo_dato, d.tipo_dato)=3 THEN 'FECHA' 
				ELSE 'UNDEFINED' END)  END) END as tipo_dato,f.clase
FROM flujos_campos_config f
LEFT JOIN campos_base b ON b.tabla=f.tabla AND b.campo=f.campo
LEFT JOIN campos_dinamicos d ON d.nombre_campo=f.campo AND f.tabla=''
WHERE id_flujo=idFlujo
AND id_tipo_persona = idTipoPersona;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_flujos_comision_reporte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_flujos_comision_reporte`(IN idPersona INT(11))
BEGIN	
SELECT distinct c.id_comision,
MAX(CASE when ab.id_flujo = 1 then f.nombre_flujo END) 'f1',
MAX(CASE when ab.id_flujo = 2 then f.nombre_flujo END) 'f2',
MAX(CASE when ab.id_flujo = 3 then f.nombre_flujo END) 'f3',
MAX(CASE when ab.id_flujo = 4 then f.nombre_flujo END) 'f4'
FROM  comisiones c
inner join aprobaciones_bitacora ab on c.id_comision = ab.id_comision
inner join flujos_trabajo f on ab.id_flujo = f.id_flujo
where c.id_persona = idPersona
group by ab.id_comision;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_flujos_trabajo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_flujos_trabajo`()
BEGIN
	
SELECT id_flujo, nombre_flujo, descripcion, version
FROM viajes_claros.flujos_trabajo
ORDER BY id_flujo;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_funcionarios_por_area` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_funcionarios_por_area`(idArea INT(11))
BEGIN


SELECT p.id_persona, p.nombres, p.apellido_paterno, 
		p.apellido_materno, p.titulo, p.email, 
		p.id_categoria, p.id_tipo_persona, 
		p.id_posicion, p.cargo, p.fecha_ingreso
FROM personas p
INNER JOIN usuarios u ON u.id_persona=p.id_persona
WHERE u.id_area=idArea;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_funcionarios_por_area_calendar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_funcionarios_por_area_calendar`(
		IN idArea INT(11), mes INT(11), anio INT(11))
BEGIN


SELECT p.id_persona, p.nombres, p.apellido_paterno, 
		p.apellido_materno, p.titulo, p.email, 
		p.id_categoria, p.id_tipo_persona, 
		p.id_posicion, p.cargo, p.fecha_ingreso
FROM personas p
INNER JOIN usuarios u ON u.id_persona=p.id_persona
INNER JOIN comisiones c ON c.id_usuario=u.id_usuario
INNER JOIN comisiones_detalle d ON d.id_comision=c.id_comision AND d.tabla='' AND d.campo='fecha_hora_salida'
WHERE u.id_area=idArea
AND YEAR(d.valor_fecha) = anio
AND MONTH(d.valor_fecha) = mes;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_funcionarios_por_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_funcionarios_por_dependencia`(IN idDependencia INT(11))
BEGIN


IF idDependencia=1 THEN
	SELECT p.id_persona, p.nombres, p.apellido_paterno, p.apellido_materno, p.titulo,
	p.email, p.id_categoria, cat.nombre_categoria, p.id_tipo_persona, t.descripcion,
	u.id_area, a.nombre_area, p.cargo, count(ins.id_viaje) num_viajes, COALESCE(SUM(v.valor_numerico), 0) as total_gasto
	FROM personas p
	INNER JOIN categoria cat ON cat.id_categoria=p.id_categoria
	INNER JOIN tipo_persona t ON t.id_tipo=p.id_tipo_persona
	INNER JOIN usuarios u ON u.id_persona=p.id_persona
	INNER JOIN areas a ON a.id_area=u.id_area
	INNER JOIN comisiones c ON c.id_persona=p.id_persona
	INNER JOIN viajes_claros_instancias ins ON ins.id_comision=c.id_comision
	LEFT JOIN viajes_claros_detalle v ON v.id_viaje=ins.id_viaje AND v.campo='costo_total'
	WHERE t.codigo_tipo='FUN'
	AND u.id_dependencia=idDependencia
	GROUP BY p.id_persona;

ELSE
	SELECT 0 as id_persona, nom.valor_texto as nombres, ap1.valor_texto as apellido1, 
		IFNULL(ap2.valor_texto, '') as apellido2, IFNULL(tit.valor_texto, 0) as titulo,
		IFNULL(em.valor_texto, '') as email, 0 as id_categoria, '' as nombre_categoria,
		2 as id_tipo_persona, 'Funcionario' as descripcion, 0 as id_area, '' as nombre_area,
		ca.valor_texto as cargo, COUNT(*) as num_viajes, SUM(c.valor_numerico) as gasto_total
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle nom ON nom.id_viaje=i.id_viaje AND nom.tabla='personas' AND nom.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle tit ON tit.id_viaje=i.id_viaje AND tit.tabla='personas' AND tit.campo='titulo'
	LEFT JOIN viajes_claros_detalle em ON em.id_viaje=i.id_viaje AND em.tabla='personas' AND em.campo='email'
	LEFT JOIN viajes_claros_detalle ca ON ca.id_viaje=i.id_viaje AND ca.tabla='personas' AND ca.campo='cargo'
	LEFT JOIN viajes_claros_detalle c ON c.id_viaje=i.id_viaje AND c.tabla='' AND c.campo='costo_total'
	WHERE i.id_dependencia=idDependencia
	GROUP BY nombres, apellido1, apellido2;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_funcionarios_por_dependencia_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_funcionarios_por_dependencia_anio`(IN idDependencia INT(11), IN anio INT(11))
BEGIN


IF idDependencia=1 THEN
	SELECT p.id_persona, p.nombres, p.apellido_paterno, p.apellido_materno, p.titulo,
	p.email, p.id_categoria, cat.nombre_categoria, p.id_tipo_persona, t.descripcion,
	u.id_area, a.nombre_area, p.cargo, count(ins.id_viaje) num_viajes, COALESCE(SUM(v.valor_numerico), 0) as total_gasto
	FROM personas p
	INNER JOIN categoria cat ON cat.id_categoria=p.id_categoria
	INNER JOIN tipo_persona t ON t.id_tipo=p.id_tipo_persona
	INNER JOIN usuarios u ON u.id_persona=p.id_persona
	INNER JOIN areas a ON a.id_area=u.id_area
	INNER JOIN comisiones c ON c.id_persona=p.id_persona
	INNER JOIN viajes_claros_instancias ins ON ins.id_comision=c.id_comision
	LEFT JOIN viajes_claros_detalle v ON v.id_viaje=ins.id_viaje AND v.campo='costo_total'
    INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=ins.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	WHERE t.codigo_tipo='FUN'
    AND YEAR(anio_viaje.valor_fecha) = anio
	AND u.id_dependencia=idDependencia
	GROUP BY p.id_persona;

ELSE
	SELECT 0 as id_persona, nom.valor_texto as nombres, ap1.valor_texto as apellido1, 
		IFNULL(ap2.valor_texto, '') as apellido2, IFNULL(tit.valor_texto, 0) as titulo,
		IFNULL(em.valor_texto, '') as email, 0 as id_categoria, '' as nombre_categoria,
		2 as id_tipo_persona, 'Funcionario' as descripcion, 0 as id_area, '' as nombre_area,
		ca.valor_texto as cargo, COUNT(*) as num_viajes, SUM(c.valor_numerico) as gasto_total
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle nom ON nom.id_viaje=i.id_viaje AND nom.tabla='personas' AND nom.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle tit ON tit.id_viaje=i.id_viaje AND tit.tabla='personas' AND tit.campo='titulo'
	LEFT JOIN viajes_claros_detalle em ON em.id_viaje=i.id_viaje AND em.tabla='personas' AND em.campo='email'
	LEFT JOIN viajes_claros_detalle ca ON ca.id_viaje=i.id_viaje AND ca.tabla='personas' AND ca.campo='cargo'
	LEFT JOIN viajes_claros_detalle c ON c.id_viaje=i.id_viaje AND c.tabla='' AND c.campo='costo_total'
    INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	WHERE i.id_dependencia=idDependencia
    AND YEAR(anio_viaje.valor_fecha) = anio
	GROUP BY nombres, apellido1, apellido2;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_funcionarios_resumen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_funcionarios_resumen`()
BEGIN

SELECT FR.id_persona, FR.nombres, FR.apellido_paterno, FR.apellido_materno, FR.cargo,
		SUM(FR.costo_viaje) as total_gasto, MAX(FR.costo_viaje) as viaje_mas_costoso, 
        FR.id_viaje AS id_viaje_mas_costoso, FR.fecha_ingreso,FR.siglas,
        COUNT(FR.id_viaje) AS total_viajes  FROM
(SELECT p.id_persona, p.nombres, p.apellido_paterno, p.apellido_materno, p.cargo,
	v.valor_numerico as costo_viaje,v.id_viaje, p.fecha_ingreso, d.siglas
FROM personas p
INNER JOIN comisiones c ON c.id_persona=p.id_persona
INNER JOIN viajes_claros_instancias i ON i.id_comision=c.id_comision
INNER JOIN usuarios u ON u.id_persona=p.id_persona
INNER JOIN dependencias d ON d.id_dependencia=u.id_dependencia
LEFT JOIN viajes_claros_detalle v ON v.id_viaje=i.id_viaje AND v.campo='costo_total'
WHERE p.id_tipo_persona<>3 
GROUP BY p.id_persona, v.id_viaje ORDER BY p.id_persona, costo_viaje DESC)FR
GROUP BY FR.nombres, FR.apellido_paterno, FR.apellido_materno

UNION ALL
SELECT FR.id_persona,FR.nombres,FR.apellido1,FR.apellido2, FR.cargo, SUM(FR.costo_viaje) as total_gasto, 
MAX(FR.costo_viaje) as viaje_mas_costoso, FR.id_viaje AS id_viaje_mas_costoso, FR.fecha_ingreso,
FR.siglas,COUNT(FR.id_viaje) AS total_viajes FROM(
SELECT 0 as id_persona, nom.valor_texto as nombres, 
	ap1.valor_texto as apellido1, 
	IFNULL(ap2.valor_texto, '') as apellido2,
	car.valor_texto as cargo,
    costo.valor_numerico as costo_viaje,
	costo.id_viaje as id_viaje,
	DATE(f.valor_fecha) as fecha_ingreso,
	d.siglas
	FROM viajes_claros_detalle nom
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=nom.id_viaje
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle car ON car.id_viaje=i.id_viaje AND car.tabla='personas' AND car.campo='cargo'
	LEFT JOIN viajes_claros_detalle costo ON costo.id_viaje=i.id_viaje AND costo.tabla='' AND costo.campo='costo_total'
	LEFT JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='personas' AND f.campo='fecha_ingreso'
	INNER JOIN dependencias d ON d.id_dependencia=i.id_dependencia
	WHERE 
		nom.tabla='personas' 
		AND nom.campo='nombres'
		AND i.id_dependencia<>1 
	GROUP BY nombres, apellido1, apellido2, id_viaje ORDER BY nombres, apellido1, apellido2, costo_viaje DESC) FR
    GROUP BY FR.nombres, FR.apellido1, FR.apellido2;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_funcionarios_resumen_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_funcionarios_resumen_anio`(anio INT(11))
BEGIN

SELECT FR.id_persona, FR.nombres, FR.apellido_paterno, FR.apellido_materno, FR.cargo,
		SUM(FR.costo_viaje) as total_gasto, MAX(FR.costo_viaje) as viaje_mas_costoso, 
        FR.id_viaje AS id_viaje_mas_costoso, FR.fecha_ingreso,FR.siglas,
        COUNT(FR.id_viaje) AS total_viajes  FROM
(SELECT p.id_persona, p.nombres, p.apellido_paterno, p.apellido_materno, p.cargo,
	v.valor_numerico as costo_viaje,v.id_viaje, p.fecha_ingreso, d.siglas
FROM personas p
INNER JOIN comisiones c ON c.id_persona=p.id_persona
INNER JOIN viajes_claros_instancias i ON i.id_comision=c.id_comision
INNER JOIN usuarios u ON u.id_persona=p.id_persona
INNER JOIN dependencias d ON d.id_dependencia=u.id_dependencia
LEFT JOIN viajes_claros_detalle v ON v.id_viaje=i.id_viaje AND v.campo='costo_total'
INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
WHERE p.id_tipo_persona<>3 
	AND YEAR(anio_viaje.valor_fecha) = anio
GROUP BY p.id_persona, v.id_viaje ORDER BY p.id_persona, costo_viaje DESC)FR
GROUP BY FR.nombres, FR.apellido_paterno, FR.apellido_materno

UNION ALL
SELECT FR.id_persona,FR.nombres,FR.apellido1,FR.apellido2, FR.cargo, SUM(FR.costo_viaje) as total_gasto, 
MAX(FR.costo_viaje) as viaje_mas_costoso, FR.id_viaje AS id_viaje_mas_costoso, FR.fecha_ingreso,
FR.siglas,COUNT(FR.id_viaje) AS total_viajes FROM(
SELECT 0 as id_persona, nom.valor_texto as nombres, 
	ap1.valor_texto as apellido1, 
	IFNULL(ap2.valor_texto, '') as apellido2,
	car.valor_texto as cargo,
    costo.valor_numerico as costo_viaje,
	costo.id_viaje as id_viaje,
	DATE(f.valor_fecha) as fecha_ingreso,
	d.siglas
	FROM viajes_claros_detalle nom
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=nom.id_viaje
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle car ON car.id_viaje=i.id_viaje AND car.tabla='personas' AND car.campo='cargo'
	LEFT JOIN viajes_claros_detalle costo ON costo.id_viaje=i.id_viaje AND costo.tabla='' AND costo.campo='costo_total'
	LEFT JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='personas' AND f.campo='fecha_ingreso'
    INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=nom.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	INNER JOIN dependencias d ON d.id_dependencia=i.id_dependencia
	WHERE 
		nom.tabla='personas' 
		AND nom.campo='nombres'
		AND i.id_dependencia<>1 
		AND YEAR(anio_viaje.valor_fecha) = anio
	GROUP BY nombres, apellido1, apellido2, id_viaje ORDER BY nombres, apellido1, apellido2, costo_viaje DESC) FR
    GROUP BY FR.nombres, FR.apellido1, FR.apellido2;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_funcionario_cargo_actual` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_funcionario_cargo_actual`(IN idFuncionario INT(11), IN idNombres VARCHAR(200), 
IN apellido1 VARCHAR(200), IN apellido2 VARCHAR(200))
BEGIN

IF idFuncionario > 0 THEN
	SELECT p.cargo
	FROM personas p
	WHERE p.id_persona=idFuncionario;
ELSE 
SELECT cargo.valor_texto AS cargo
FROM viajes_claros_instancias i
LEFT JOIN viajes_claros_detalle nom ON nom.id_viaje = i.id_viaje AND nom.tabla = 'personas' AND nom.campo='nombres'
LEFT JOIN viajes_claros_detalle ap ON ap.id_viaje = i.id_viaje  AND ap.tabla = 'personas' AND ap.campo='apellido_paterno'
LEFT JOIN viajes_claros_detalle am ON am.id_viaje = i.id_viaje  AND am.tabla = 'personas' AND am.campo='apellido_materno'
LEFT JOIN viajes_claros_detalle cargo ON cargo.id_viaje = i.id_viaje  AND cargo.tabla = 'personas' AND cargo.campo='cargo'
LEFT JOIN viajes_claros_detalle fv ON fv.id_viaje = i.id_viaje  AND fv.tabla = '' AND fv.campo='fecha_hora_salida'
WHERE nom.valor_texto=idNombres AND ap.valor_texto=apellido1 AND am.valor_texto=apellido2
ORDER BY fv.valor_fecha DESC LIMIT 1;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_funcionario_por_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_funcionario_por_id`(IN idPersona INT(11), 
IN inNombres VARCHAR(200), IN inApellido1 VARCHAR(200), IN inApellido2 VARCHAR(200))
BEGIN

	
IF idPersona > 0 THEN
	SELECT p.id_persona, p.nombres, p.apellido_paterno, p.apellido_materno, p.titulo,
	p.email, p.id_categoria, cat.nombre_categoria, p.id_tipo_persona, t.descripcion,
	u.id_area, a.nombre_area, u.id_dependencia
	FROM personas p
	INNER JOIN categoria cat ON cat.id_categoria=p.id_categoria
	INNER JOIN tipo_persona t ON t.id_tipo=p.id_tipo_persona
	INNER JOIN usuarios u ON u.id_persona=p.id_persona
	INNER JOIN areas a ON a.id_area=u.id_area
	WHERE p.id_persona=idPersona
	AND t.codigo_tipo<>'INV';
ELSE

	SELECT 0 as id_persona, n.valor_texto as nombres, ap1.valor_texto as apellido1, 
		IFNULL(ap2.valor_texto, '') as apellido2, IFNULL(tit.valor_texto, '') as titulo,
		IFNULL(em.valor_texto, '') as email, 0 as id_categoria, '' as nombre_categoria,
		2 as id_tipo_persona, 'Funcionario' as descripcion, 0 as id_area, 
		'' as nombre_area, i.id_dependencia
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle n ON n.id_viaje=i.id_viaje AND n.tabla='personas' AND n.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle car ON car.id_viaje=i.id_viaje AND car.tabla='personas' AND car.campo='cargo'
	LEFT JOIN viajes_claros_detalle tit ON tit.id_viaje=i.id_viaje AND tit.tabla='personas' AND car.campo='titulo'
	LEFT JOIN viajes_claros_detalle em ON em.id_viaje=i.id_viaje AND em.tabla='personas' AND em.campo='email'	
	WHERE n.valor_texto=inNombres
	AND ap1.valor_texto=inApellido1
	AND IF(ap2.valor_texto is null, '', ap2.valor_texto) = inApellido2
	LIMIT 1;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_funcionario_por_id_viaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_funcionario_por_id_viaje`(IN idViaje INT(11))
BEGIN


IF (SELECT id_comision FROM viajes_claros_instancias WHERE id_viaje=idViaje) is not null THEN
	SELECT p.id_persona, p.nombres, p.apellido_paterno, p.apellido_materno, p.titulo,
	p.email, p.id_categoria, cat.nombre_categoria, p.id_tipo_persona, t.descripcion,
	u.id_area, a.nombre_area, u.id_dependencia
	FROM personas p
	INNER JOIN comisiones c ON c.id_persona=p.id_persona
	INNER JOIN viajes_claros_instancias v ON v.id_comision=c.id_comision
	INNER JOIN categoria cat ON cat.id_categoria=p.id_categoria
	INNER JOIN tipo_persona t ON t.id_tipo=p.id_tipo_persona
	INNER JOIN usuarios u ON u.id_persona=p.id_persona
	INNER JOIN areas a ON a.id_area=u.id_area
	WHERE v.id_viaje=idViaje
	AND t.codigo_tipo<>'INV';

ELSE
	SELECT 0 as id_persona, nom.valor_texto as nombres, 
		ap1.valor_texto as apellido1, IFNULL(ap2.valor_texto, '') as apellido2,
		IFNULL(tit.valor_texto, '') as titulo, IFNULL(em.valor_texto, '') as email,
		0 as id_categoria, '' as nombre_categoria, 2 as id_tipo_persona, 'Funcionario' as descripcion,
		0 as id_area, '' as nombre_area, i.id_dependencia
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle nom ON nom.id_viaje=i.id_viaje AND nom.tabla='personas' AND nom.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle tit ON tit.id_viaje=i.id_viaje AND tit.tabla='personas' AND tit.campo='titulo'
	LEFT JOIN viajes_claros_detalle em ON em.id_viaje=i.id_viaje AND em.tabla='personas' AND em.campo='email'
	WHERE i.id_viaje=idViaje
	;

END IF;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_funcionario_resumen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_funcionario_resumen`(IN idFuncionario INT(11), IN idNombres VARCHAR(200), 
IN apellido1 VARCHAR(200), IN apellido2 VARCHAR(200))
BEGIN


IF idFuncionario > 0 THEN
	SELECT  p.id_persona, p.nombres, p.apellido_paterno, p.apellido_materno, p.cargo,
		u.id_dependencia, d.siglas, count(i.id_viaje) as total_viajes, 
		COALESCE(SUM(v.valor_numerico), 0) as total_costo,
		p.fecha_ingreso
	FROM personas p
	INNER JOIN usuarios u ON u.id_persona=p.id_persona
	INNER JOIN dependencias d ON d.id_dependencia=u.id_dependencia
	LEFT JOIN comisiones c ON c.id_persona=p.id_persona
	LEFT JOIN viajes_claros_instancias i ON i.id_comision=c.id_comision
	LEFT JOIN viajes_claros_detalle v ON v.id_viaje=i.id_viaje AND v.campo='costo_total'
	WHERE p.id_persona=idFuncionario;
ELSE 
SELECT 0 as id_persona, nom.valor_texto as nombres, ap1.valor_texto as apellido1, 
		IFNULL(ap2.valor_texto, '') as apellido2, IFNULL(ca.valor_texto, '') as cargo,
		i.id_dependencia, d.siglas, count(*) as total_viajes, 
		IFNULL(SUM(c.valor_numerico), 0) as total_costo,
		DATE(f.valor_fecha) as fecha_ingreso 
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle nom ON nom.id_viaje=i.id_viaje AND nom.tabla='personas' AND nom.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle ca ON ca.id_viaje=i.id_viaje AND ca.tabla='personas' AND ca.campo='cargo'
	LEFT JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='personas' AND f.campo='fecha_ingreso'	
	LEFT JOIN viajes_claros_detalle c ON c.id_viaje=i.id_viaje AND c.tabla='' AND c.campo='costo_total'
	INNER JOIN dependencias d ON d.id_dependencia=i.id_dependencia
    WHERE nom.valor_texto=idNombres AND ap1.valor_texto=apellido1 AND ap2.valor_texto=apellido2
	GROUP BY nombres, apellido1, apellido2;


END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_funcionario_resumen_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_funcionario_resumen_anio`(IN idFuncionario INT(11), IN idNombres VARCHAR(200), 
IN apellido1 VARCHAR(200), IN apellido2 VARCHAR(200),IN anio INT(11))
BEGIN


IF idFuncionario > 0 THEN
	SELECT  p.id_persona, p.nombres, p.apellido_paterno, p.apellido_materno, p.cargo,
		u.id_dependencia, d.siglas, count(i.id_viaje) as total_viajes, 
		COALESCE(SUM(v.valor_numerico), 0) as total_costo,
		p.fecha_ingreso
	FROM personas p
	INNER JOIN usuarios u ON u.id_persona=p.id_persona
	INNER JOIN dependencias d ON d.id_dependencia=u.id_dependencia
	LEFT JOIN comisiones c ON c.id_persona=p.id_persona
	LEFT JOIN viajes_claros_instancias i ON i.id_comision=c.id_comision
	LEFT JOIN viajes_claros_detalle v ON v.id_viaje=i.id_viaje AND v.campo='costo_total'
	INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	WHERE p.id_persona=idFuncionario AND YEAR(anio_viaje.valor_fecha)=anio;
ELSE 
SELECT 0 as id_persona, nom.valor_texto as nombres, ap1.valor_texto as apellido1, 
		IFNULL(ap2.valor_texto, '') as apellido2, IFNULL(ca.valor_texto, '') as cargo,
		i.id_dependencia, d.siglas, count(*) as total_viajes, 
		IFNULL(SUM(c.valor_numerico), 0) as total_costo,
		DATE(f.valor_fecha) as fecha_ingreso 
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle nom ON nom.id_viaje=i.id_viaje AND nom.tabla='personas' AND nom.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle ca ON ca.id_viaje=i.id_viaje AND ca.tabla='personas' AND ca.campo='cargo'
	LEFT JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='personas' AND f.campo='fecha_ingreso'	
	LEFT JOIN viajes_claros_detalle c ON c.id_viaje=i.id_viaje AND c.tabla='' AND c.campo='costo_total'
    INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	INNER JOIN dependencias d ON d.id_dependencia=i.id_dependencia
    WHERE nom.valor_texto=idNombres AND ap1.valor_texto=apellido1 AND ap2.valor_texto=apellido2
    AND YEAR(anio_viaje.valor_fecha)=anio
	GROUP BY nombres, apellido1, apellido2;


END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_gastos_campos_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_gastos_campos_config`()
BEGIN

SELECT g.campo, g.etiqueta, 
	g.lista_habilitada, g.obligatorio,g.orden, d.id_lista,
	CASE WHEN d.tipo_control=1 THEN 'TEXTO' 
		ELSE CASE WHEN d.tipo_control=2 THEN 'LISTA'
			ELSE CASE WHEN d.tipo_control=3 THEN 'CALENDARIO'
				ELSE 'OTRO' END END END as tipo_control,
	CASE WHEN d.tipo_dato=2 THEN 'TEXTO' 
		ELSE (CASE WHEN d.tipo_dato=1 THEN 'NUMERO' 
			ELSE (CASE WHEN d.tipo_dato=3 THEN 'FECHA' 
				ELSE 'UNDEFINED' END)  END) END as tipo_dato,
                g.subtipo
FROM gastos_campos_config g
LEFT JOIN campos_dinamicos d ON d.nombre_campo=g.campo
ORDER BY g.orden;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_gastos_campos_config_edit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_gastos_campos_config_edit`()
BEGIN

SELECT g.id_gasto_campo_config,g.tabla,g.campo, g.etiqueta, 
	g.lista_habilitada, g.obligatorio,g.orden, d.id_lista,
	CASE WHEN d.tipo_control=1 THEN 'TEXTO' 
		ELSE CASE WHEN d.tipo_control=2 THEN 'LISTA'
			ELSE CASE WHEN d.tipo_control=3 THEN 'CALENDARIO'
				ELSE 'OTRO' END END END as tipo_control,
	CASE WHEN d.tipo_dato=2 THEN 'TEXTO' 
		ELSE (CASE WHEN d.tipo_dato=1 THEN 'NUMERO' 
			ELSE (CASE WHEN d.tipo_dato=3 THEN 'FECHA' 
				ELSE 'UNDEFINED' END)  END) END as tipo_dato,
                g.subtipo
FROM gastos_campos_config g
LEFT JOIN campos_dinamicos d ON d.nombre_campo=g.campo
ORDER BY g.orden;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_gastos_campos_config_headers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_gastos_campos_config_headers`()
BEGIN

SELECT g.etiqueta
FROM gastos_campos_config g
ORDER BY g.orden;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_graficas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_graficas`()
BEGIN

	SELECT grafica, descripcion FROM graficas;
	
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_graficas_por_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_graficas_por_dependencia`(IN idDependencia INT(11))
BEGIN
	

	SELECT g.id_grafica, g.descripcion, conf.id_dependencia,
	CASE WHEN conf.id_dependencia IS NULL THEN false ELSE true END as enabled,
	g.grafica
FROM graficas g
LEFT JOIN graficas_config conf ON conf.id_grafica=g.id_grafica AND conf.id_dependencia=idDependencia;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_headers_carga` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_headers_carga`(IN idDependencia INT(11))
BEGIN

select i.id_dependencia, i.tabla, i.campo, 
	i.etiqueta, i.editable, i.secuencia, i.lista_habilitada
from interfaz_config i
WHERE i.id_dependencia = idDependencia
ORDER BY i.secuencia;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_headers_viajes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_headers_viajes`(idDependencia INT, complete TINYINT)
BEGIN
IF complete = 1 THEN
	SELECT des.tabla, des.campo, 
	CASE WHEN b.despliegue IS NULL THEN d.despliegue ELSE b.despliegue END as despliegue
	FROM buscador_despliegue_config des
	LEFT JOIN campos_base b ON b.tabla=des.tabla AND b.campo=des.campo
	LEFT JOIN campos_dinamicos d ON d.nombre_campo=des.campo AND des.tabla=''
	WHERE id_dependencia = idDependencia
	ORDER BY des.orden;
ELSE 
	SELECT des.tabla, des.campo, 
	CASE WHEN b.despliegue IS NULL THEN d.despliegue ELSE b.despliegue END as despliegue
	FROM buscador_despliegue_config des
	LEFT JOIN campos_base b ON b.tabla=des.tabla AND b.campo=des.campo
	LEFT JOIN campos_dinamicos d ON d.nombre_campo=des.campo AND des.tabla=''
	WHERE id_dependencia = idDependencia AND des.mostrar = 1
	ORDER BY des.orden;
END IF;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_listas_valores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_listas_valores`()
BEGIN
	
	SELECT DISTINCT L.id_lista, L.nombre_lista, L.habilitada, 
	CASE WHEN V.id_lista IS NULL THEN (CASE WHEN D.id_lista IS NULL THEN false ELSE true END) ELSE true END as constraint_fails
FROM listas_valores L
LEFT JOIN valores_dinamicos V ON V.id_lista = L.id_lista
LEFT JOIN campos_dinamicos D ON D.id_lista = L.id_lista;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_mapa_viajes_por_ciudad_pais` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_mapa_viajes_por_ciudad_pais`(idDependencia INT(11),
	inCiudad VARCHAR(200), inPais VARCHAR(200))
BEGIN

IF idDependencia = 1 THEN 

	SELECT i.id_viaje, cd.valor_texto as ciudad, pa.valor_texto as pais, 
		DATE_FORMAT(f.valor_fecha, '%d/%m/%Y') as fecha, c.id_persona,
		p.nombres, p.apellido_paterno, p.apellido_materno
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
	INNER JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='' AND f.campo='fecha_hora_salida'
	INNER JOIN comisiones c ON c.id_comision=i.id_comision
	INNER JOIN personas p ON p.id_persona=c.id_persona
	WHERE i.id_dependencia=idDependencia
	AND cd.valor_texto=inCiudad
	AND pa.valor_texto=inPais
    ORDER BY f.valor_fecha DESC;

ELSE 

	SELECT i.id_viaje, cd.valor_texto as ciudad, pa.valor_texto as pais, 
		DATE_FORMAT(f.valor_fecha, '%d/%m/%Y') as fecha, 0 as id_persona,
		n.valor_texto as nombres, a1.valor_texto as apellido1, IFNULL(a2.valor_texto, '') as apellido2
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
	LEFT JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='' AND f.campo='fecha_hora_salida'
	INNER JOIN viajes_claros_detalle n ON n.id_viaje=i.id_viaje AND n.tabla='personas' AND n.campo='nombres'
	INNER JOIN viajes_claros_detalle a1 ON a1.id_viaje=i.id_viaje AND a1.tabla='personas' AND a1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle a2 ON a2.id_viaje=i.id_viaje AND a2.tabla='personas' AND a2.campo='apellido_materno'
	WHERE i.id_dependencia=idDependencia
	AND cd.valor_texto=inCiudad
	AND pa.valor_texto=inPais
    ORDER BY f.valor_fecha DESC;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_mapa_viajes_por_ciudad_pais_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_mapa_viajes_por_ciudad_pais_anio`(idDependencia INT(11),
	inCiudad VARCHAR(200), inPais VARCHAR(200), anio INTEGER(11))
BEGIN
	
IF idDependencia = 1 THEN 

	SELECT i.id_viaje, cd.valor_texto as ciudad, pa.valor_texto as pais, 
		DATE_FORMAT(f.valor_fecha, '%d/%m/%Y') as fecha, c.id_persona,
		p.nombres, p.apellido_paterno, p.apellido_materno
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
	INNER JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='' AND f.campo='fecha_hora_salida'
	INNER JOIN comisiones c ON c.id_comision=i.id_comision
	INNER JOIN personas p ON p.id_persona=c.id_persona
	WHERE i.id_dependencia=idDependencia
	AND cd.valor_texto=inCiudad
	AND pa.valor_texto=inPais
	AND YEAR(f.valor_fecha) = anio
    ORDER BY f.valor_fecha DESC;

ELSE 

	SELECT i.id_viaje, cd.valor_texto as ciudad, pa.valor_texto as pais, 
		DATE_FORMAT(f.valor_fecha, '%d/%m/%Y') as fecha, 0 as id_persona,
		n.valor_texto as nombres, a1.valor_texto as apellido1, IFNULL(a2.valor_texto, '') as apellido2
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
	LEFT JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='' AND f.campo='fecha_hora_salida'
	INNER JOIN viajes_claros_detalle n ON n.id_viaje=i.id_viaje AND n.tabla='personas' AND n.campo='nombres'
	INNER JOIN viajes_claros_detalle a1 ON a1.id_viaje=i.id_viaje AND a1.tabla='personas' AND a1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle a2 ON a2.id_viaje=i.id_viaje AND a2.tabla='personas' AND a2.campo='apellido_materno'
	WHERE i.id_dependencia=idDependencia
	AND cd.valor_texto=inCiudad
	AND pa.valor_texto=inPais
	AND YEAR(f.valor_fecha) = anio
    ORDER BY f.valor_fecha DESC;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_mapa_viajes_por_ciudad_pais_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_mapa_viajes_por_ciudad_pais_funcionario`(IN idFuncionario INT(11), IN idNombres VARCHAR(200), 
IN apellido1 VARCHAR(200), IN apellido2 VARCHAR(200), inCiudad VARCHAR(200), inPais VARCHAR(200))
BEGIN
	
IF idFuncionario > 0 THEN 

	SELECT i.id_viaje, cd.valor_texto as ciudad, pa.valor_texto as pais, 
		DATE_FORMAT(f.valor_fecha, '%d/%m/%Y') as fecha, c.id_persona,
		p.nombres, p.apellido_paterno, p.apellido_materno
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
	INNER JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='' AND f.campo='fecha_hora_salida'
	INNER JOIN comisiones c ON c.id_comision=i.id_comision
	INNER JOIN personas p ON p.id_persona=c.id_persona
	WHERE p.id_persona=idFuncionario
	AND cd.valor_texto=inCiudad
	AND pa.valor_texto=inPais
    ORDER BY f.valor_fecha DESC;

ELSE 

	SELECT i.id_viaje, cd.valor_texto as ciudad, pa.valor_texto as pais, 
		DATE_FORMAT(f.valor_fecha, '%d/%m/%Y') as fecha, 0 as id_persona,
		n.valor_texto as nombres, a1.valor_texto as apellido1, IFNULL(a2.valor_texto, '') as apellido2
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
	LEFT JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='' AND f.campo='fecha_hora_salida'
	INNER JOIN viajes_claros_detalle n ON n.id_viaje=i.id_viaje AND n.tabla='personas' AND n.campo='nombres'
	INNER JOIN viajes_claros_detalle a1 ON a1.id_viaje=i.id_viaje AND a1.tabla='personas' AND a1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle a2 ON a2.id_viaje=i.id_viaje AND a2.tabla='personas' AND a2.campo='apellido_materno'
	WHERE n.valor_texto=idNombres AND a1.valor_texto=apellido1 AND a2.valor_texto=apellido2
	AND cd.valor_texto=inCiudad
	AND pa.valor_texto=inPais
    ORDER BY f.valor_fecha DESC;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_mapa_viajes_por_ciudad_pais_funcionario_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_mapa_viajes_por_ciudad_pais_funcionario_anio`(IN idFuncionario INT(11), IN idNombres VARCHAR(200), 
IN apellido1 VARCHAR(200), IN apellido2 VARCHAR(200), inCiudad VARCHAR(200), inPais VARCHAR(200),IN anio INT(11))
BEGIN

IF idFuncionario > 0 THEN 

	SELECT i.id_viaje, cd.valor_texto as ciudad, pa.valor_texto as pais, 
		DATE_FORMAT(f.valor_fecha, '%d/%m/%Y') as fecha, c.id_persona,
		p.nombres, p.apellido_paterno, p.apellido_materno
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
	INNER JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='' AND f.campo='fecha_hora_salida'
	INNER JOIN comisiones c ON c.id_comision=i.id_comision
	INNER JOIN personas p ON p.id_persona=c.id_persona
	WHERE p.id_persona=idFuncionario
    AND YEAR(f.valor_fecha)=anio
	AND cd.valor_texto=inCiudad
	AND pa.valor_texto=inPais
    ORDER BY f.valor_fecha DESC;

ELSE 

	SELECT i.id_viaje, cd.valor_texto as ciudad, pa.valor_texto as pais, 
		DATE_FORMAT(f.valor_fecha, '%d/%m/%Y') as fecha, 0 as id_persona,
		n.valor_texto as nombres, a1.valor_texto as apellido1, IFNULL(a2.valor_texto, '') as apellido2
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
	LEFT JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='' AND f.campo='fecha_hora_salida'
	INNER JOIN viajes_claros_detalle n ON n.id_viaje=i.id_viaje AND n.tabla='personas' AND n.campo='nombres'
	INNER JOIN viajes_claros_detalle a1 ON a1.id_viaje=i.id_viaje AND a1.tabla='personas' AND a1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle a2 ON a2.id_viaje=i.id_viaje AND a2.tabla='personas' AND a2.campo='apellido_materno'
	WHERE n.valor_texto=idNombres AND a1.valor_texto=apellido1 AND a2.valor_texto=apellido2
    AND YEAR(f.valor_fecha)=anio
	AND cd.valor_texto=inCiudad
	AND pa.valor_texto=inPais
    ORDER BY f.valor_fecha DESC;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_registros_gastos_por_id_comision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_registros_gastos_por_id_comision`(IN idComision INT(11))
BEGIN	
 SELECT t1.id_registro_gasto_comision AS id_registro,t1.valor_numerico AS importe,t2.valor_texto AS concepto,t3.valor_texto AS tipo_pago,t4.valor_texto AS comprobante
FROM registros_gastos_comision rg
LEFT JOIN comisiones_desglose_gastos t1
 ON rg.id_registro_gasto_comision = t1.id_registro_gasto_comision
LEFT JOIN comisiones_desglose_gastos t2
  ON t2.id_registro_gasto_comision = t1.id_registro_gasto_comision
LEFT JOIN comisiones_desglose_gastos t3
  ON t1.id_registro_gasto_comision = t3.id_registro_gasto_comision
LEFT JOIN comisiones_desglose_gastos t4
  ON t1.id_registro_gasto_comision = t4.id_registro_gasto_comision where t1.campo = 'importe_gasto_pesos' and t2.campo = 'concepto_gasto' and t3.campo = 'pago_gasto' and t4.campo = 'comprobante_gasto'
  and rg.id_comision = idComision
GROUP BY t1.id_registro_gasto_comision;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_reporte_comision_por_flujo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_reporte_comision_por_flujo`(IN idComision INT(11),IN idFlujo INT(11))
BEGIN	
SELECT c.id_comision,p.nombres,p.apellido_paterno,p.apellido_materno,ab.respuesta, f.nombre_flujo
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_secciones_formulario_por_id_flujo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_secciones_formulario_por_id_flujo`(
	IN idFlujo INT(11))
BEGIN

		
	SELECT secciones_formulario.id_seccion,
			secciones_formulario.etiqueta,
			secciones_formulario.nombre_seccion,
			secciones_formulario.id_flujo,
			secciones_formulario.orden_seccion
	FROM secciones_formulario
	WHERE id_flujo=idFlujo
	ORDER BY secciones_formulario.orden_seccion;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_smtp_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_smtp_config`()
BEGIN

SELECT id, host, puerto, usuario, password
FROM smtp_config;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_suscripcion_campos_por_cat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_suscripcion_campos_por_cat`(IN idDependencia INT(11), IN cat VARCHAR(100))
BEGIN


SELECT DISTINCT v.campo, d.despliegue,
CASE WHEN s.campo IS NULL THEN FALSE ELSE TRUE END as config, d.categoria
FROM viajes_claros_detalle v
INNER JOIN viajes_claros_instancias i ON i.id_viaje=v.id_viaje
INNER JOIN campos_dinamicos d ON d.nombre_campo=v.campo
LEFT JOIN suscripcion_config s ON s.campo=v.campo
WHERE i.id_dependencia=idDependencia
AND d.categoria=cat;

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_suscripcion_ultimos_viajes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_suscripcion_ultimos_viajes`()
BEGIN

	

SELECT v.id_viaje, s.email, p.id_persona, v.fecha_publicacion
FROM viajes_claros_instancias v
INNER JOIN comisiones c ON c.id_comision=v.id_comision
INNER JOIN personas p ON p.id_persona=c.id_persona
INNER JOIN suscripcion_email_config s ON s.id_persona=p.id_persona
WHERE fecha_publicacion >= DATE_ADD(CURDATE(), INTERVAL -1 DAY)
UNION ALL

SELECT A.id_viaje, conf.email, 0 as id_persona, A.fecha_publicacion FROM
(
	SELECT i.id_viaje, n.valor_texto as nombres, a1.valor_texto as apellido1, 
	IFNULL(a2.valor_texto, '') as apellido2, i.fecha_publicacion
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle n ON n.id_viaje=i.id_viaje AND n.tabla='personas' AND n.campo='nombres'
	INNER JOIN viajes_claros_detalle a1 ON a1.id_viaje=i.id_viaje AND a1.tabla='personas' AND a1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle a2 ON a2.id_viaje=i.id_viaje AND a2.tabla='personas' AND a2.campo='apellido_materno'
	WHERE i.fecha_publicacion >= DATE_ADD(CURDATE(), INTERVAL -1 DAY)
) A
INNER JOIN suscripcion_email_config conf
	ON conf.nombres=A.nombres AND conf.apellido1=A.apellido1 AND conf.apellido2 = A.apellido2
AND conf.id_persona=0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_tablas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_tablas`()
BEGIN
	
	SELECT DISTINCT c.tabla
	FROM viajes_claros_config c ORDER BY tabla;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_tablas_base` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_tablas_base`()
BEGIN
	
	SELECT 'categoria' as tabla
	UNION ALL
	SELECT 'ciudades' as tabla
	UNION ALL
	SELECT 'dependencias' as tabla
	UNION ALL
	SELECT 'estados' as tabla
	UNION ALL
	SELECT 'paises' as tabla
	UNION ALL
	SELECT 'personas' as tabla
	UNION ALL
	SELECT 'tipo_persona' as tabla
	;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_tablas_carga_disponibles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_tablas_carga_disponibles`(idDep INT(11))
BEGIN
	

SELECT DISTINCT conf.tabla
FROM viajes_claros_config conf 
LEFT JOIN campos_base base ON base.tabla = conf.tabla AND base.campo = conf.campo
LEFT JOIN campos_dinamicos din ON din.nombre_campo = conf.campo
WHERE (conf.tabla, conf.campo) NOT IN(
	SELECT tabla, campo 
	FROM interfaz_config
	WHERE id_dependencia = idDep);

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_tablas_despliegue_disponibles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_tablas_despliegue_disponibles`(IN idDep INT(11))
BEGIN
	
SELECT DISTINCT conf.tabla
FROM viajes_claros_config conf 
INNER JOIN interfaz_config carga ON carga.tabla=conf.tabla AND carga.campo=conf.campo AND carga.id_dependencia=idDep
LEFT JOIN campos_base base ON base.tabla = conf.tabla AND base.campo = conf.campo
LEFT JOIN campos_dinamicos din ON din.nombre_campo = conf.campo
WHERE (conf.tabla, conf.campo) NOT IN(
SELECT tabla, campo 
FROM buscador_despliegue_config
WHERE id_dependencia = idDep);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_tablas_filtros_disponibles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_tablas_filtros_disponibles`(IN idDep INT(11))
BEGIN

SELECT DISTINCT conf.tabla
FROM viajes_claros_config conf 
INNER JOIN interfaz_config carga ON carga.tabla=conf.tabla AND carga.campo=conf.campo AND carga.id_dependencia=idDep
LEFT JOIN campos_base base ON base.tabla = conf.tabla AND base.campo = conf.campo
LEFT JOIN campos_dinamicos din ON din.nombre_campo = conf.campo
WHERE (conf.tabla, conf.campo) NOT IN(
SELECT tabla, campo 
FROM buscador_filtros_config
WHERE id_dependencia = idDep);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_tablas_flujo_disponibles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_tablas_flujo_disponibles`(IN idFlujo INT(11), IN idTipoPersona INT(11))
BEGIN


SELECT DISTINCT conf.tabla
FROM viajes_claros_config conf 
LEFT JOIN campos_base base ON base.tabla = conf.tabla AND base.campo = conf.campo
LEFT JOIN campos_dinamicos din ON din.nombre_campo = conf.campo
WHERE (conf.tabla, conf.campo) NOT IN(
	SELECT tabla, campo 
	FROM flujos_campos_config
	WHERE id_flujo = idFlujo AND id_tipo_persona=idTipoPersona);
	

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_tipos_control` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_tipos_control`()
BEGIN
	
	SELECT 1 as id, 'TEXTO' as tipo_control
	UNION ALL
	SELECT 2 as id, 'LISTA' as tipo_control
	UNION ALL
	SELECT 3 as id, 'CALENDARIO' as tipo_control;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_tipos_dato` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_tipos_dato`()
BEGIN
	
	SELECT 1 as id, 'NUMERO' as tipo_dato
	UNION ALL
	SELECT 2 as id, 'TEXTO' as tipo_dato
	UNION ALL
	SELECT 3 as id, 'FECHA' as tipo_dato;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_total_gasto_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_gasto_anio`()
BEGIN
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_total_gasto_por_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_gasto_por_dependencia`(idDependencia INT)
BEGIN
	
SELECT SUM(d.valor_numerico) 
FROM viajes_claros_detalle d
INNER JOIN viajes_claros_instancias i ON i.id_viaje=d.id_viaje
WHERE d.tabla='' AND d.campo='costo_total'
AND i.id_dependencia=idDependencia;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_total_gasto_por_dependencia_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_gasto_por_dependencia_anio`(idDependencia INT(11))
BEGIN

SELECT SUM(d.valor_numerico) 
FROM viajes_claros_detalle d
INNER JOIN viajes_claros_instancias i ON i.id_viaje=d.id_viaje
WHERE d.tabla='' AND d.campo='costo_total'
AND i.id_dependencia=idDependencia;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_total_gasto_por_dependencia_anio_esp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_gasto_por_dependencia_anio_esp`(idDependencia INT(11), anio INT(11))
BEGIN

SELECT SUM(d.valor_numerico) 
FROM viajes_claros_detalle d
INNER JOIN viajes_claros_instancias i ON i.id_viaje=d.id_viaje
INNER JOIN viajes_claros_detalle v ON v.id_viaje=i.id_viaje AND v.tabla='' AND v.campo='fecha_hora_salida'
WHERE d.tabla='' AND d.campo='costo_total'
AND i.id_dependencia=idDependencia
AND YEAR(v.valor_fecha) = anio;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_total_pasajes_por_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_pasajes_por_dependencia`(idDependencia INT(10))
BEGIN

SELECT CASE 
	WHEN t.pasajes IS NOT NULL THEN
		t.pasajes
	ELSE 0 END AS total_pasajes
FROM
(SELECT SUM(v.valor_numerico) AS pasajes
FROM viajes_claros_detalle v
INNER JOIN viajes_claros_instancias i ON i.id_viaje=v.id_viaje
WHERE campo='INAI_gasto_total_pasaje'
AND i.id_dependencia=idDependencia) t;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_total_pasajes_por_dependencia_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_pasajes_por_dependencia_anio`(idDependencia INT(10),anio INT(11))
BEGIN
	
SELECT CASE 
	WHEN t.pasajes IS NOT NULL THEN
		t.pasajes
	ELSE 0 END AS total_pasajes
FROM
(SELECT SUM(v.valor_numerico) AS pasajes
FROM viajes_claros_detalle v
INNER JOIN viajes_claros_instancias i ON i.id_viaje=v.id_viaje
INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=v.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
WHERE v.campo='INAI_gasto_total_pasaje'
AND i.id_dependencia=idDependencia
AND YEAR(anio_viaje.valor_fecha) = anio) t;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_total_viajes_por_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_viajes_por_dependencia`(idDependencia INT)
BEGIN
	
SELECT count(*) 
FROM viajes_claros_instancias
WHERE id_dependencia=idDependencia;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_total_viajes_por_dependencia_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_viajes_por_dependencia_anio`(idDependencia INT(11))
BEGIN	
	
SELECT count(*) 
FROM viajes_claros_instancias i
WHERE i.id_dependencia=idDependencia;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_total_viajes_por_dependencia_anio_esp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_viajes_por_dependencia_anio_esp`(idDependencia INT(11), anio INT(11))
BEGIN
	
	
SELECT count(*) 
FROM viajes_claros_instancias i
INNER JOIN viajes_claros_detalle v ON v.id_viaje=i.id_viaje AND v.tabla='' AND v.campo='fecha_hora_salida'
WHERE id_dependencia=idDependencia
AND YEAR(v.valor_fecha) = anio;		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_total_viaticos_por_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_viaticos_por_dependencia`(idDependencia INT(10))
BEGIN

SELECT ROUND(CASE 
	WHEN t.viaticos IS NOT NULL THEN
		t.viaticos
	ELSE 0 END,2) AS total_viaticos
FROM
(SELECT SUM(viaticos_comp.valor_numerico+viaticos_sin_comp.valor_numerico) AS viaticos
FROM viajes_claros_instancias i 
INNER JOIN viajes_claros_detalle viaticos_comp ON i.id_viaje=viaticos_comp.id_viaje AND viaticos_comp.tabla='' AND viaticos_comp.campo='viaticos_comprobados' 
INNER JOIN viajes_claros_detalle viaticos_sin_comp ON i.id_viaje=viaticos_sin_comp.id_viaje AND viaticos_sin_comp.tabla='' AND viaticos_sin_comp.campo='viaticos_sin_comprobar' 
WHERE i.id_dependencia=idDependencia) t;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_total_viaticos_por_dependencia_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_viaticos_por_dependencia_anio`(idDependencia INT(10),anio INT(11))
BEGIN
	
SELECT ROUND(CASE 
	WHEN t.viaticos IS NOT NULL THEN
		t.viaticos
	ELSE 0 END,2) AS total_viaticos
FROM
(SELECT SUM(viaticos_comp.valor_numerico+viaticos_sin_comp.valor_numerico) AS viaticos
FROM viajes_claros_instancias i 
INNER JOIN viajes_claros_detalle viaticos_comp ON i.id_viaje=viaticos_comp.id_viaje AND viaticos_comp.tabla='' AND viaticos_comp.campo='viaticos_comprobados' 
INNER JOIN viajes_claros_detalle viaticos_sin_comp ON i.id_viaje=viaticos_sin_comp.id_viaje AND viaticos_sin_comp.tabla='' AND viaticos_sin_comp.campo='viaticos_sin_comprobar' 
INNER JOIN viajes_claros_detalle anio_viaje ON i.id_viaje=anio_viaje.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
WHERE i.id_dependencia=idDependencia
AND YEAR(anio_viaje.valor_fecha) = anio) t;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_ubicaciones_mapa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_ubicaciones_mapa`(idDependencia INT(11))
BEGIN
	
SELECT cd.valor_texto as ciudad, pa.valor_texto as pais, 
	SUM(g.valor_numerico) as gasto_total, A.latitud, A.longitud
FROM viajes_claros_instancias i
INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
LEFT JOIN viajes_claros_detalle g ON g.id_viaje=i.id_viaje AND g.tabla='' AND g.campo='costo_total'
INNER JOIN (
	SELECT c.nombre_ciudad, p.nombre_pais, c.latitud, c.longitud
	FROM ciudades c
	INNER JOIN paises p ON p.id_pais=c.id_pais) A ON A.nombre_ciudad=cd.valor_texto AND A.nombre_pais=pa.valor_texto
WHERE i.id_dependencia=idDependencia
GROUP BY ciudad, pais;	


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_ubicaciones_mapa_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_ubicaciones_mapa_anio`(idDependencia INT(11),anio INT(11))
BEGIN
	
SELECT cd.valor_texto as ciudad, pa.valor_texto as pais, 
	SUM(g.valor_numerico) as gasto_total, A.latitud, A.longitud
FROM viajes_claros_instancias i
INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
LEFT JOIN viajes_claros_detalle g ON g.id_viaje=i.id_viaje AND g.tabla='' AND g.campo='costo_total'
INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
INNER JOIN (
	SELECT c.nombre_ciudad, p.nombre_pais, c.latitud, c.longitud
	FROM ciudades c
	INNER JOIN paises p ON p.id_pais=c.id_pais) A ON A.nombre_ciudad=cd.valor_texto AND A.nombre_pais=pa.valor_texto
WHERE i.id_dependencia=idDependencia
	AND YEAR(anio_viaje.valor_fecha) = anio	
GROUP BY ciudad, pais;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_ubicaciones_mapa_por_persona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_ubicaciones_mapa_por_persona`(idPersona INT(11), inNombres VARCHAR(200),
	inApellido1 varchar(200), inApellido2 varchar(200))
BEGIN


IF idPersona > 0 THEN

	SELECT cd.valor_texto as ciudad, pa.valor_texto as pais, 
	g.valor_numerico as gasto_total, A.latitud, A.longitud, 
	p.nombres, p.apellido_paterno, p.apellido_materno
	FROM viajes_claros_instancias i
	INNER JOIN comisiones com ON com.id_comision=i.id_comision
	INNER JOIN personas p ON p.id_persona=com.id_persona
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
	LEFT JOIN viajes_claros_detalle g ON g.id_viaje=i.id_viaje AND g.tabla='' AND g.campo='costo_total'
	INNER JOIN (
		SELECT c.nombre_ciudad, p.nombre_pais, c.latitud, c.longitud
		FROM ciudades c
		INNER JOIN paises p ON p.id_pais=c.id_pais) A ON A.nombre_ciudad=cd.valor_texto AND A.nombre_pais=pa.valor_texto
	WHERE p.id_persona=idPersona
	;


ELSE
	SELECT cd.valor_texto as ciudad, pa.valor_texto as pais, 
	g.valor_numerico as gasto_total, A.latitud, A.longitud, 
	n.valor_texto as nombres, a1.valor_texto as apellido1, a2.valor_texto as apellido2
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle n ON n.id_viaje=i.id_viaje AND n.tabla='personas' AND n.campo='nombres'
	INNER JOIN viajes_claros_detalle a1 ON a1.id_viaje=i.id_viaje AND a1.tabla='personas' AND a1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle a2 ON a2.id_viaje=i.id_viaje AND a2.tabla='personas' AND a2.campo='apellido_materno'
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
	LEFT JOIN viajes_claros_detalle g ON g.id_viaje=i.id_viaje AND g.tabla='' AND g.campo='costo_total'
	INNER JOIN (
		SELECT c.nombre_ciudad, p.nombre_pais, c.latitud, c.longitud
		FROM ciudades c
		INNER JOIN paises p ON p.id_pais=c.id_pais) A ON A.nombre_ciudad=cd.valor_texto AND A.nombre_pais=pa.valor_texto
	WHERE n.valor_texto=inNombres
	AND a1.valor_texto=inApellido1
	AND a2.valor_texto=inApellido2
	;


END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_ubicaciones_mapa_por_persona_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_ubicaciones_mapa_por_persona_anio`(idPersona INT(11), inNombres VARCHAR(200),
	inApellido1 varchar(200), inApellido2 varchar(200),IN anio INT(11))
BEGIN


IF idPersona > 0 THEN

	SELECT cd.valor_texto as ciudad, pa.valor_texto as pais, 
	g.valor_numerico as gasto_total, A.latitud, A.longitud, 
	p.nombres, p.apellido_paterno, p.apellido_materno
	FROM viajes_claros_instancias i
	INNER JOIN comisiones com ON com.id_comision=i.id_comision
	INNER JOIN personas p ON p.id_persona=com.id_persona
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
	LEFT JOIN viajes_claros_detalle g ON g.id_viaje=i.id_viaje AND g.tabla='' AND g.campo='costo_total'
    INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	INNER JOIN (
		SELECT c.nombre_ciudad, p.nombre_pais, c.latitud, c.longitud
		FROM ciudades c
		INNER JOIN paises p ON p.id_pais=c.id_pais) A ON A.nombre_ciudad=cd.valor_texto AND A.nombre_pais=pa.valor_texto
	WHERE p.id_persona=idPersona
    AND YEAR(anio_viaje.valor_fecha)=anio
	;


ELSE
	SELECT cd.valor_texto as ciudad, pa.valor_texto as pais, 
	g.valor_numerico as gasto_total, A.latitud, A.longitud, 
	n.valor_texto as nombres, a1.valor_texto as apellido1, a2.valor_texto as apellido2
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle n ON n.id_viaje=i.id_viaje AND n.tabla='personas' AND n.campo='nombres'
	INNER JOIN viajes_claros_detalle a1 ON a1.id_viaje=i.id_viaje AND a1.tabla='personas' AND a1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle a2 ON a2.id_viaje=i.id_viaje AND a2.tabla='personas' AND a2.campo='apellido_materno'
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
	LEFT JOIN viajes_claros_detalle g ON g.id_viaje=i.id_viaje AND g.tabla='' AND g.campo='costo_total'
    INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	INNER JOIN (
		SELECT c.nombre_ciudad, p.nombre_pais, c.latitud, c.longitud
		FROM ciudades c
		INNER JOIN paises p ON p.id_pais=c.id_pais) A ON A.nombre_ciudad=cd.valor_texto AND A.nombre_pais=pa.valor_texto
	WHERE n.valor_texto=inNombres
    AND YEAR(anio_viaje.valor_fecha)=anio
	AND a1.valor_texto=inApellido1
	AND a2.valor_texto=inApellido2
	;


END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_usuario_por_nombre_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_usuario_por_nombre_usuario`(IN nombreUsuario VARCHAR(50))
BEGIN
	
SELECT u.id_usuario, u.usuario, u.contrasena, u.descripcion, u.habilitado, 
	u.intentos, u.id_perfil, p.nombre_perfil, u.id_dependencia, u.id_persona, 
	u.id_area, u.salt
FROM usuarios u
INNER JOIN perfiles p ON p.id_perfil = u.id_perfil
WHERE usuario=nombreUsuario;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_valores_dinamicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_valores_dinamicos`(idLista INT)
BEGIN
	
SET @qry1 = 'SELECT v.id_lista, v.codigo, v.valor, l.nombre_lista, l.habilitada
FROM valores_dinamicos v
INNER JOIN listas_valores l ON l.id_lista = v.id_lista';
	
IF idLista IS NULL THEN
	SET @query = @qry1;
ELSE
	SET @query = CONCAT(@qry1, ' WHERE v.id_lista=', idLista);
END IF;

PREPARE QUERY FROM @query;
EXECUTE QUERY;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_valores_dinamicos_por_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_valores_dinamicos_por_id`(idLista INT)
BEGIN
	
	SELECT id_lista, codigo, valor 
	FROM valores_dinamicos WHERE id_lista=idLista;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_valores_dinamicos_por_id_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_valores_dinamicos_por_id_lista`(idLista INT)
BEGIN
	
SELECT v.id_lista, v.codigo, v.valor
FROM valores_dinamicos v
WHERE v.id_lista=idLista;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_viajes_claros_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viajes_claros_config`()
BEGIN
	

SELECT tabla, campo, SUM(constraint_fails)
FROM 
(
SELECT conf.tabla, conf.campo, 
	CASE WHEN b.campo IS NULL THEN (CASE WHEN f.campo IS NULL THEN (CASE WHEN v.campo IS NULL THEN false ELSE true END) ELSE true END) ELSE true END as constraint_fails
FROM viajes_claros_config conf
LEFT JOIN buscador_despliegue_config b ON b.tabla = conf.tabla AND b.campo = conf.campo
LEFT JOIN buscador_filtros_config f ON f.tabla = conf.tabla AND f.campo = conf.campo
LEFT JOIN viajes_claros_detalle v ON v.tabla = conf.tabla AND v.campo = conf.campo
) A
GROUP BY tabla, campo;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_viajes_por_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viajes_por_dependencia`(IN idDependencia INT(11), IN despliegueCompleto TINYINT (1))
BEGIN
	
SET SESSION group_concat_max_len = 1000000;

IF (despliegueCompleto=1) THEN
	SET @qry_select = (SELECT 
		GROUP_CONCAT(DISTINCT CONCAT("MAX(CASE WHEN (tabla = '", tabla, "' AND campo = '", campo, "') THEN valor ELSE '' END) AS '", campo, "'")  ORDER BY orden SEPARATOR ',')
	FROM buscador_despliegue_config des
	WHERE id_dependencia = idDependencia);

ELSE  
	SET @qry_select = (SELECT 
		GROUP_CONCAT(DISTINCT CONCAT("MAX(CASE WHEN (tabla = '", tabla, "' AND campo = '", campo, "') THEN valor ELSE '' END) AS '", campo, "'")  ORDER BY orden SEPARATOR ',')
	FROM buscador_despliegue_config des
	WHERE id_dependencia = idDependencia AND mostrar = 1);
END IF;


set @query = CONCAT('SELECT id_viaje, ', (CASE WHEN (@qry_select is null) THEN '\'\'' ELSE @qry_select END), ' FROM
(
	SELECT v.id_viaje, v.tabla, v.campo, 
	CASE WHEN v.valor_texto IS NULL THEN 
		(CASE WHEN v.valor_numerico IS NULL THEN 
			DATE_FORMAT(v.valor_fecha, ''%d/%m/%Y %H:%i'') 
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
		ELSE v.valor_texto END) END AS valor
	FROM viajes_claros_detalle v 
	INNER JOIN viajes_claros_instancias ins ON ins.id_viaje = v.id_viaje
	WHERE ins.id_dependencia=', idDependencia, 
	' ORDER BY v.id_viaje
) A
GROUP BY id_viaje');


PREPARE QUERY FROM @query;
EXECUTE QUERY;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_viajes_por_dependencia_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viajes_por_dependencia_anio`(IN idDependencia INT(11),IN anio INT(11), IN despliegueCompleto TINYINT(1))
BEGIN
	

SET SESSION group_concat_max_len = 1000000;

IF (despliegueCompleto=1) THEN
	SET @qry_select = (SELECT 
		GROUP_CONCAT(DISTINCT CONCAT("MAX(CASE WHEN (tabla = '", tabla, "' AND campo = '", campo, "') THEN valor ELSE '' END) AS '", campo, "'")  ORDER BY orden SEPARATOR ',')
	FROM buscador_despliegue_config des
	WHERE id_dependencia = idDependencia);

ELSE  
	SET @qry_select = (SELECT 
		GROUP_CONCAT(DISTINCT CONCAT("MAX(CASE WHEN (tabla = '", tabla, "' AND campo = '", campo, "') THEN valor ELSE '' END) AS '", campo, "'")  ORDER BY orden SEPARATOR ',')
	FROM buscador_despliegue_config des
	WHERE id_dependencia = idDependencia AND mostrar = 1);
END IF;


set @query = CONCAT('SELECT id_viaje, ', (CASE WHEN (@qry_select is null) THEN '\'\'' ELSE @qry_select END), ' FROM
(
	SELECT v.id_viaje, v.tabla, v.campo, 
	CASE WHEN v.valor_texto IS NULL THEN 
		(CASE WHEN v.valor_numerico IS NULL THEN 
			DATE_FORMAT(v.valor_fecha, ''%d/%m/%Y %H:%i'') 
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
		ELSE v.valor_texto END) END AS valor
	FROM viajes_claros_detalle v 
	INNER JOIN viajes_claros_instancias ins ON ins.id_viaje = v.id_viaje
    INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=v.id_viaje AND anio_viaje.tabla=\'\' AND anio_viaje.campo=\'fecha_hora_salida\'
	WHERE ins.id_dependencia=', idDependencia, ' AND YEAR(anio_viaje.valor_fecha)=', anio,
	' ORDER BY v.id_viaje
) A
GROUP BY id_viaje');


PREPARE QUERY FROM @query;
EXECUTE QUERY;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_viajes_por_dependencia_carga` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viajes_por_dependencia_carga`(idDependencia INT(11))
BEGIN

	

SET SESSION group_concat_max_len = 1000000;


SET @qry_select = (SELECT 
	GROUP_CONCAT(DISTINCT CONCAT("MAX(CASE WHEN (tabla = '", tabla, "' AND campo = '", campo, "') THEN valor ELSE '' END) AS '", campo, "'") order by secuencia SEPARATOR ',')
FROM interfaz_config i
WHERE id_dependencia = idDependencia
ORDER BY i.secuencia);



set @query = CONCAT('SELECT id_viaje, ', (CASE WHEN (@qry_select is null) THEN ''''' as n' ELSE @qry_select END), ' FROM
(
	SELECT v.id_viaje, v.tabla, v.campo, 
	CASE WHEN v.valor_texto IS NULL THEN 
		CASE WHEN v.valor_numerico IS NULL THEN 
			CASE WHEN v.valor_fecha IS NULL THEN '''' 
			ELSE DATE_FORMAT(v.valor_fecha, ''%d/%m/%Y %H:%i'') END 
		ELSE v.valor_numerico END 
	ELSE v.valor_texto END AS valor
	FROM viajes_claros_detalle v 
	INNER JOIN viajes_claros_instancias ins ON ins.id_viaje = v.id_viaje
	WHERE ins.id_dependencia=', idDependencia, 
	' ORDER BY v.id_viaje
) A
GROUP BY id_viaje');



PREPARE QUERY FROM @query;
EXECUTE QUERY;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_viajes_por_filtros` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viajes_por_filtros`(IN idDependencia INT(11), IN filtros VARCHAR(2000), IN despliegueCompleto TINYINT(1))
BEGIN
	
SET SESSION group_concat_max_len = 1000000;

IF (despliegueCompleto=1) THEN
	SET @qry_select_final = (SELECT GROUP_CONCAT(DISTINCT campo  ORDER BY orden SEPARATOR ',')
	FROM buscador_despliegue_config des
	WHERE id_dependencia = idDependencia);
ELSE
	SET @qry_select_final = (SELECT GROUP_CONCAT(DISTINCT campo  ORDER BY orden SEPARATOR ',')
	FROM buscador_despliegue_config des
	WHERE id_dependencia = idDependencia  AND mostrar = 1);
END IF;

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
	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_viajes_por_filtros_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viajes_por_filtros_anio`(IN idDependencia INT(11), IN filtros VARCHAR(2000),IN anio INT(11), IN despliegueCompleto TINYINT(1))
BEGIN
	
SET SESSION group_concat_max_len = 1000000;


IF (despliegueCompleto=1) THEN
	SET @qry_select_final = (SELECT GROUP_CONCAT(DISTINCT campo  ORDER BY orden SEPARATOR ',')
	FROM buscador_despliegue_config des
	WHERE id_dependencia = idDependencia);
ELSE
	SET @qry_select_final = (SELECT GROUP_CONCAT(DISTINCT campo  ORDER BY orden SEPARATOR ',')
	FROM buscador_despliegue_config des
	WHERE id_dependencia = idDependencia  AND mostrar = 1);
END IF;


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
    INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=v.id_viaje AND anio_viaje.tabla=\'\' AND anio_viaje.campo=\'fecha_hora_salida\'
	WHERE ins.id_dependencia=', idDependencia, ' AND YEAR(anio_viaje.valor_fecha)=', anio,
	' ORDER BY v.id_viaje
) A
GROUP BY id_viaje');



set @query_where = CONCAT('SELECT id_viaje, ', (CASE WHEN (@qry_select_final is null) THEN '''' ELSE @qry_select_final END), ' FROM (', @query, ') B WHERE 1=1 ', filtros);

PREPARE QUERY FROM @query_where;
EXECUTE QUERY;
	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_viajes_por_persona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viajes_por_persona`(idPersona INT)
BEGIN
	
SET SESSION group_concat_max_len = 1000000;


SET @qry_select = (SELECT 
	GROUP_CONCAT(DISTINCT CONCAT("MAX(CASE WHEN (tabla = '", tabla, "' AND campo = '", campo, "') THEN valor ELSE NULL END) AS '", campo, "'") SEPARATOR ',')
FROM buscador_despliegue_config des
INNER JOIN usuarios u ON u.id_dependencia=des.id_dependencia
INNER JOIN personas p ON p.id_persona=u.id_persona);


set @query = CONCAT('SELECT ', (CASE WHEN (@qry_select is null) THEN '''' ELSE @qry_select END), ' FROM
(
	SELECT v.id_viaje, v.tabla, v.campo, 
	CASE WHEN v.valor_texto IS NULL THEN CASE WHEN v.valor_numerico IS NULL THEN DATE_FORMAT(v.valor_fecha, ''%d/%m/%Y %H:%i'') ELSE v.valor_numerico END ELSE v.valor_texto END AS valor
	FROM viajes_claros_detalle v 
	INNER JOIN viajes_claros_instancias ins ON ins.id_viaje = v.id_viaje
	INNER JOIN personas p ON p.id_persona = ins.id_persona
	WHERE  p.id_persona=', idPersona, 
') A
GROUP BY id_viaje');

PREPARE QUERY FROM @query;
EXECUTE QUERY;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_viajes_resumen_por_persona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viajes_resumen_por_persona`(IN idPersona INT(11),
	nom VARCHAR(200), ap1 VARCHAR(200), ap2 VARCHAR(200))
BEGIN

SET SESSION group_concat_max_len = 1000000;

IF idPersona > 0 THEN

	SET @qry_select = (SELECT 
		GROUP_CONCAT(DISTINCT CONCAT("MAX(CASE WHEN (tabla = '", tabla, "' AND campo = '", campo, "') THEN valor ELSE NULL END) AS '", campo, "'") SEPARATOR ',')
	FROM viajes_claros_config des);
	
	
	set @query = CONCAT('SELECT id_viaje, ', (CASE WHEN (@qry_select is null) THEN '''' ELSE @qry_select END), ' FROM
	(
		SELECT v.id_viaje, v.tabla, v.campo, 
		CASE WHEN v.valor_texto IS NULL THEN 
			CASE WHEN v.valor_numerico IS NULL THEN 
				DATE_FORMAT(v.valor_fecha, ''%d/%m/%Y %H:%i'') 
			ELSE v.valor_numerico END 
		ELSE v.valor_texto END AS valor
		FROM viajes_claros_detalle v 
		INNER JOIN viajes_claros_instancias ins ON ins.id_viaje = v.id_viaje
		INNER JOIN comisiones c ON c.id_comision=ins.id_comision
		INNER JOIN personas p ON p.id_persona = c.id_persona
		WHERE  p.id_persona=', idPersona, 
	') A
	GROUP BY id_viaje');
	
	set @query_select = CONCAT('SELECT id_viaje, costo_total, fecha_hora_salida, fecha_hora_regreso, 
	pais_destino, ciudad_destino, nombre_evento FROM (',
	@query, ') B');
	
	
	PREPARE QUERY FROM @query_select;
	EXECUTE QUERY;


ELSE

	SELECT i.id_viaje, c.valor_numerico as costo_total, 
		DATE_FORMAT(ini.valor_fecha, '%d/%m/%Y') as fecha_inicio, 
		DATE_FORMAT(fin.valor_fecha, '%d/%m/%Y') as fecha_fin,
		pa.valor_texto as pais_destino,	cd.valor_texto as ciudad_destino, ev.valor_texto as nombre_evento
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle nom ON nom.id_viaje=i.id_viaje AND nom.tabla='personas' AND nom.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle c ON c.id_viaje=i.id_viaje AND c.tabla='' AND c.campo='costo_total'
	LEFT JOIN viajes_claros_detalle ini ON ini.id_viaje=i.id_viaje AND ini.tabla='' AND ini.campo='fecha_hora_salida'
	LEFT JOIN viajes_claros_detalle fin ON fin.id_viaje=i.id_viaje AND fin.tabla='' AND fin.campo='fecha_hora_regreso'
	LEFT JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
	LEFT JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
	LEFT JOIN viajes_claros_detalle ev ON ev.id_viaje=i.id_viaje AND ev.tabla='' AND ev.campo='nombre_evento'
	WHERE nom.valor_texto=nom
	AND ap1.valor_texto=ap1
	AND IF(ap2.valor_texto IS NULL, '', ap2.valor_texto)=ap2
;

END IF;

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_viajes_resumen_por_persona_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viajes_resumen_por_persona_anio`(IN idPersona INT(11),
	nom VARCHAR(200), ap1 VARCHAR(200), ap2 VARCHAR(200),IN anio INT(11))
BEGIN

SET SESSION group_concat_max_len = 1000000;

IF idPersona > 0 THEN

	SET @qry_select = (SELECT 
		GROUP_CONCAT(DISTINCT CONCAT("MAX(CASE WHEN (tabla = '", tabla, "' AND campo = '", campo, "') THEN valor ELSE NULL END) AS '", campo, "'") SEPARATOR ',')
	FROM viajes_claros_config des);
	
	
	set @query = CONCAT('SELECT id_viaje, ', (CASE WHEN (@qry_select is null) THEN '''' ELSE @qry_select END), ' FROM
	(
		SELECT v.id_viaje, v.tabla, v.campo, 
		CASE WHEN v.valor_texto IS NULL THEN 
			CASE WHEN v.valor_numerico IS NULL THEN 
				DATE_FORMAT(v.valor_fecha, ''%d/%m/%Y %H:%i'') 
			ELSE v.valor_numerico END 
		ELSE v.valor_texto END AS valor
		FROM viajes_claros_detalle v 
		INNER JOIN viajes_claros_instancias ins ON ins.id_viaje = v.id_viaje
		INNER JOIN comisiones c ON c.id_comision=ins.id_comision
        INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=ins.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo=''fecha_hora_salida''
		INNER JOIN personas p ON p.id_persona = c.id_persona
		WHERE  p.id_persona=', idPersona, ' AND YEAR(anio_viaje.valor_fecha)=', anio,
	') A
	GROUP BY id_viaje');
	
	set @query_select = CONCAT('SELECT id_viaje, costo_total, fecha_hora_salida, fecha_hora_regreso, 
	pais_destino, ciudad_destino, nombre_evento FROM (',
	@query, ') B');
	
	
	PREPARE QUERY FROM @query_select;
	EXECUTE QUERY;


ELSE

	SELECT i.id_viaje, c.valor_numerico as costo_total, 
		DATE_FORMAT(ini.valor_fecha, '%d/%m/%Y') as fecha_inicio, 
		DATE_FORMAT(fin.valor_fecha, '%d/%m/%Y') as fecha_fin,
		pa.valor_texto as pais_destino,	cd.valor_texto as ciudad_destino, ev.valor_texto as nombre_evento
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle nom ON nom.id_viaje=i.id_viaje AND nom.tabla='personas' AND nom.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle c ON c.id_viaje=i.id_viaje AND c.tabla='' AND c.campo='costo_total'
	LEFT JOIN viajes_claros_detalle ini ON ini.id_viaje=i.id_viaje AND ini.tabla='' AND ini.campo='fecha_hora_salida'
	LEFT JOIN viajes_claros_detalle fin ON fin.id_viaje=i.id_viaje AND fin.tabla='' AND fin.campo='fecha_hora_regreso'
	LEFT JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
	LEFT JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
	LEFT JOIN viajes_claros_detalle ev ON ev.id_viaje=i.id_viaje AND ev.tabla='' AND ev.campo='nombre_evento'
	WHERE nom.valor_texto=nom
    AND YEAR(ini.valor_fecha)=anio
	AND ap1.valor_texto=ap1
	AND IF(ap2.valor_texto IS NULL, '', ap2.valor_texto)=ap2
;

END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_viaje_datos_por_categoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viaje_datos_por_categoria`(IN idViaje INT(11), 
	IN codigoCat VARCHAR(60))
BEGIN
	
	SELECT IFNULL(b.despliegue, d.despliegue) AS despliegue,
	CASE WHEN v.valor_texto IS NULL THEN (
		CASE WHEN v.valor_numerico IS NULL THEN 
			v.valor_fecha 
		ELSE (CASE WHEN LOWER(v.campo) LIKE '%gasto%' OR LOWER(v.campo) LIKE '%costo%' OR 
			LOWER(v.campo) LIKE '%importe%' OR LOWER(v.campo) LIKE 'viaticos_%' OR LOWER(v.campo) LIKE '%tarifa%' OR 
            LOWER(v.campo) LIKE '%monto%' THEN 
					CONCAT('$', FORMAT(v.valor_numerico, 2))
			  ELSE (CASE WHEN v.tabla='areas' and v.campo='id_area' THEN 
					(SELECT areas.nombre_area AS valor
                        FROM areas
						WHERE areas.id_area = v.valor_numerico)
			  ELSE v.valor_numerico END) END) END) 
	ELSE (CASE WHEN EXISTS (
						SELECT vd.valor AS valor
                        FROM valores_dinamicos vd 
						INNER JOIN campos_dinamicos cd ON vd.id_lista = cd.id_lista
						INNER JOIN viajes_claros_detalle vcd ON cd.nombre_campo = vcd.campo
						WHERE vcd.id_viaje = v.id_viaje and vcd.campo = v.campo and vd.codigo = v.valor_texto
                    ) THEN 
					(
						SELECT 
							CASE WHEN LOWER(v.campo) LIKE '%gasto%' OR LOWER(v.campo) LIKE '%costo%' OR 
							LOWER(v.campo) LIKE '%importe%' OR  LOWER(v.campo) LIKE 'viaticos_%' OR LOWER(v.campo) LIKE '%tarifa%' OR 
							LOWER(v.campo) LIKE '%monto%' THEN 
							CONCAT('$', FORMAT(CONVERT(vd.valor,SIGNED INTEGER), 2))
						ELSE vd.valor END AS valor
                        FROM valores_dinamicos vd 
						INNER JOIN campos_dinamicos cd ON vd.id_lista = cd.id_lista
						INNER JOIN viajes_claros_detalle vcd ON cd.nombre_campo = vcd.campo
						WHERE vcd.id_viaje = v.id_viaje and vcd.campo = v.campo and vd.codigo = v.valor_texto
                    )
		ELSE v.valor_texto END) END as valor
	FROM viajes_claros_detalle v 
    INNER JOIN viajes_claros_instancias vi ON v.id_viaje = vi.id_viaje
	INNER JOIN interfaz_config ic ON v.campo=ic.campo AND v.tabla=ic.tabla AND vi.id_dependencia = ic.id_dependencia
	LEFT JOIN campos_base b ON b.tabla=v.tabla AND b.campo=v.campo
	LEFT JOIN campos_dinamicos d ON d.nombre_campo=v.campo AND v.tabla=''
	where v.id_viaje=idViaje
	AND (b.categoria=codigoCat OR d.categoria=codigoCat) ORDER BY ic.secuencia;
	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_viaje_datos_suscripcion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viaje_datos_suscripcion`(idViaje INT(11))
BEGIN
	

	
SET SESSION group_concat_max_len = 1000000;

SET @idDep = (SELECT id_dependencia FROM viajes_claros_instancias WHERE id_viaje=idViaje);

SET @qry_select = (SELECT 
	GROUP_CONCAT(DISTINCT CONCAT("MAX(CASE WHEN (campo = '", campo, "') THEN valor ELSE NULL END) AS '", campo, "'") SEPARATOR ',')
FROM suscripcion_config conf
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_viaje_resumen_por_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viaje_resumen_por_id`(IN idViaje INT(10))
BEGIN


SET SESSION group_concat_max_len = 1000000;


SET @qry_select = (SELECT 
	GROUP_CONCAT(DISTINCT CONCAT("MAX(CASE WHEN (tabla = '", tabla, "' AND campo = '", campo, "') THEN valor ELSE NULL END) AS '", campo, "'") SEPARATOR ',')
FROM viajes_claros_config des);


set @query = CONCAT('SELECT id_viaje, ', (CASE WHEN (@qry_select is null) THEN '''' ELSE @qry_select END), ' FROM
(
	SELECT v.id_viaje, v.tabla, v.campo, 
	CASE WHEN v.valor_texto IS NULL THEN CASE WHEN v.valor_numerico IS NULL THEN DATE_FORMAT(v.valor_fecha, ''%d/%m/%Y %H:%i'') ELSE v.valor_numerico END ELSE v.valor_texto END AS valor
	FROM viajes_claros_detalle v 
	INNER JOIN viajes_claros_instancias ins ON ins.id_viaje = v.id_viaje
	WHERE  v.id_viaje=', idViaje, 
') A
GROUP BY id_viaje');

set @query_select = CONCAT('SELECT id_viaje, costo_total, fecha_hora_salida, fecha_hora_regreso, 
pais_destino, ciudad_destino, nombre_evento FROM (', @query, ') B');

PREPARE QUERY FROM @query_select;
EXECUTE QUERY;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_aerolineas_por_dep` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_aerolineas_por_dep`(idDependencia INT(10))
BEGIN
	
SELECT SUBSTRING((CASE WHEN EXISTS (
			SELECT vd.valor AS valor
            FROM valores_dinamicos vd 
			INNER JOIN campos_dinamicos cd ON vd.id_lista = cd.id_lista
			INNER JOIN viajes_claros_detalle vcd ON cd.nombre_campo = vcd.campo
			WHERE vcd.id_viaje = det.id_viaje and vcd.campo = det.campo and vd.codigo = det.valor_texto
		) THEN 
		(
			SELECT vd.valor AS valor
			FROM valores_dinamicos vd 
			INNER JOIN campos_dinamicos cd ON vd.id_lista = cd.id_lista
			INNER JOIN viajes_claros_detalle vcd ON cd.nombre_campo = vcd.campo
			WHERE vcd.id_viaje = det.id_viaje and vcd.campo = det.campo and vd.codigo = det.valor_texto
		)
		ELSE det.valor_texto END),1,10) as valor_texto, count(det.valor_texto) num
FROM viajes_claros_detalle det
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=det.id_viaje
WHERE ins.id_dependencia=idDependencia AND (det.valor_texto <> 'N/A' AND det.valor_texto <> 'SinDato')
AND (det.campo='aerolinea_ida' or det.campo='aerolinea_regreso')
GROUP BY valor_texto
ORDER BY num DESC limit 10;

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_aerolineas_por_dep_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_aerolineas_por_dep_anio`(idDependencia INT(10), anio INT(11))
BEGIN
	
SELECT SUBSTRING((CASE WHEN EXISTS (
			SELECT vd.valor AS valor
            FROM valores_dinamicos vd 
			INNER JOIN campos_dinamicos cd ON vd.id_lista = cd.id_lista
			INNER JOIN viajes_claros_detalle vcd ON cd.nombre_campo = vcd.campo
			WHERE vcd.id_viaje = det.id_viaje and vcd.campo = det.campo and vd.codigo = det.valor_texto
		) THEN 
		(
			SELECT vd.valor AS valor
			FROM valores_dinamicos vd 
			INNER JOIN campos_dinamicos cd ON vd.id_lista = cd.id_lista
			INNER JOIN viajes_claros_detalle vcd ON cd.nombre_campo = vcd.campo
			WHERE vcd.id_viaje = det.id_viaje and vcd.campo = det.campo and vd.codigo = det.valor_texto
		)
		ELSE det.valor_texto END),1,10) as valor_texto, count(det.valor_texto) num
FROM viajes_claros_detalle det
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=det.id_viaje
INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=det.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
WHERE ins.id_dependencia=idDependencia AND (det.valor_texto <> 'N/A' AND det.valor_texto <> 'SinDato')
AND (det.campo='aerolinea_ida' or det.campo='aerolinea_regreso')
AND YEAR(anio_viaje.valor_fecha) = anio
GROUP BY valor_texto
ORDER BY num DESC limit 10;

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_ciudades_internacionales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_ciudades_internacionales`(idDependencia INT(10))
BEGIN

SELECT SUBSTRING(CONCAT(det.valor_texto, ', ', pa.valor_texto),1,35), count(det.valor_texto) num
FROM viajes_claros_detalle det
INNER JOIN viajes_claros_detalle inter ON inter.id_viaje=det.id_viaje AND inter.campo='tipo_viaje'
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=det.id_viaje
INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=det.id_viaje AND pa.campo='pais_destino'
WHERE det.campo='ciudad_destino' AND inter.valor_texto = '2'
AND ins.id_dependencia=idDependencia
GROUP BY pa.valor_texto, det.valor_texto
ORDER BY num DESC
LIMIT 3;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_ciudades_internacionales_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_ciudades_internacionales_anio`(idDependencia INT(10), anio INT(11))
BEGIN

SELECT SUBSTRING(CONCAT(det.valor_texto, ', ', pa.valor_texto),1,35), count(det.valor_texto) num
FROM viajes_claros_detalle det
INNER JOIN viajes_claros_detalle inter ON inter.id_viaje=det.id_viaje AND inter.campo='tipo_viaje'
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=det.id_viaje
INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=det.id_viaje AND pa.campo='pais_destino'
INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=det.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
WHERE det.campo='ciudad_destino' AND inter.valor_texto = '2'
AND ins.id_dependencia=idDependencia
AND YEAR(anio_viaje.valor_fecha) = anio
GROUP BY pa.valor_texto, det.valor_texto
ORDER BY num DESC
LIMIT 3;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_ciudades_nacionales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_ciudades_nacionales`(idDependencia INT(10))
BEGIN
	
SELECT CONCAT(det.valor_texto, ', ', pa.valor_texto), count(det.valor_texto) num
FROM viajes_claros_detalle det
INNER JOIN viajes_claros_detalle inter ON inter.id_viaje=det.id_viaje AND inter.campo='tipo_viaje'
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=det.id_viaje
INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=det.id_viaje AND pa.campo='pais_destino'
WHERE det.campo='ciudad_destino' AND inter.valor_texto = '1'
AND ins.id_dependencia=idDependencia
GROUP BY pa.valor_texto, det.valor_texto
ORDER BY num DESC
LIMIT 3;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_ciudades_nacionales_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_ciudades_nacionales_anio`(idDependencia INT(10), anio INT(11))
BEGIN

SELECT SUBSTRING(CONCAT(det.valor_texto, ', ', pa.valor_texto),1,35), count(det.valor_texto) num
FROM viajes_claros_detalle det
INNER JOIN viajes_claros_detalle inter ON inter.id_viaje=det.id_viaje AND inter.campo='tipo_viaje'
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=det.id_viaje
INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=det.id_viaje AND pa.campo='pais_destino'
INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=det.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
WHERE det.campo='ciudad_destino' AND inter.valor_texto = '1'
AND ins.id_dependencia=idDependencia
AND YEAR(anio_viaje.valor_fecha) = anio
GROUP BY pa.valor_texto, det.valor_texto
ORDER BY num DESC
LIMIT 3;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_funcionarios_mas_viajes_por_dep` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_funcionarios_mas_viajes_por_dep`(IN idDependencia INT(11))
BEGIN
IF idDependencia=1 THEN
	select p.id_persona, p.nombres, p.apellido_paterno, p.apellido_materno, 
	COUNT(v.id_viaje) as total_viajes, p.cargo
	from personas p
	INNER JOIN comisiones c ON c.id_persona=p.id_persona
	INNER JOIN viajes_claros_instancias i ON i.id_comision=c.id_comision
	INNER JOIN viajes_claros_detalle v ON v.id_viaje=i.id_viaje AND v.campo='costo_total'
	INNER JOIN usuarios u ON u.id_persona=p.id_persona
	WHERE u.id_dependencia=idDependencia
	GROUP BY p.id_persona
	ORDER BY total_viajes DESC LIMIT 3;
ELSE 
	SELECT 0 as id_persona, nom.valor_texto as nombres, 
	ap1.valor_texto as apellido1, 
	ap2.valor_texto as apellido2,
	COUNT(*) as num_viajes,
	car.valor_texto as cargo
	FROM viajes_claros_detalle nom
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=nom.id_viaje
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle car ON car.id_viaje=i.id_viaje AND car.tabla='personas' AND car.campo='cargo'
	WHERE 
		nom.tabla='personas' 
		AND nom.campo='nombres'
		AND i.id_dependencia=idDependencia
	GROUP BY nombres, apellido1, apellido2
	ORDER BY num_viajes DESC
	LIMIT 3;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_funcionarios_mas_viajes_por_dep_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_funcionarios_mas_viajes_por_dep_anio`(IN idDependencia INT(11), anio INT(11))
BEGIN
IF idDependencia=1 THEN
	select p.id_persona, p.nombres, p.apellido_paterno, p.apellido_materno, 
	COUNT(v.id_viaje) as total_viajes, p.cargo
	from personas p
	INNER JOIN comisiones c ON c.id_persona=p.id_persona
	INNER JOIN viajes_claros_instancias i ON i.id_comision=c.id_comision
	INNER JOIN viajes_claros_detalle v ON v.id_viaje=i.id_viaje AND v.campo='costo_total'
    INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	INNER JOIN usuarios u ON u.id_persona=p.id_persona
	WHERE u.id_dependencia=idDependencia
    AND YEAR(anio_viaje.valor_fecha) = anio
	GROUP BY p.id_persona
	ORDER BY total_viajes DESC LIMIT 3;
ELSE 
	SELECT 0 as id_persona, nom.valor_texto as nombres, 
	ap1.valor_texto as apellido1, 
	ap2.valor_texto as apellido2,
	COUNT(*) as num_viajes,
	car.valor_texto as cargo
	FROM viajes_claros_detalle nom
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=nom.id_viaje
    INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle car ON car.id_viaje=i.id_viaje AND car.tabla='personas' AND car.campo='cargo'
	WHERE 
		nom.tabla='personas' 
		AND nom.campo='nombres'
		AND i.id_dependencia=idDependencia
		AND YEAR(anio_viaje.valor_fecha) = anio
	GROUP BY nombres, apellido1, apellido2
	ORDER BY num_viajes DESC
	LIMIT 3;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_funcionarios_mayor_gasto_por_dep` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_funcionarios_mayor_gasto_por_dep`(IN idDependencia INT(11))
BEGIN



IF idDependencia=1 THEN
	select p.id_persona, p.nombres, p.apellido_paterno, p.apellido_materno, 
		SUM(v.valor_numerico) as total_gasto, p.cargo
	from personas p
	INNER JOIN comisiones c ON c.id_persona=p.id_persona
	INNER JOIN viajes_claros_instancias i ON i.id_comision=c.id_comision
	INNER JOIN viajes_claros_detalle v ON v.id_viaje=i.id_viaje AND v.campo='costo_total'
	INNER JOIN usuarios u ON u.id_persona=p.id_persona
	WHERE u.id_dependencia=idDependencia
	GROUP BY p.id_persona
	ORDER BY total_gasto DESC LIMIT 3;
ELSE
	SELECT 0 as id_persona, nom.valor_texto as nombres, 
	ap1.valor_texto as apellido1, 
	ap2.valor_texto as apellido2,
	SUM(costo.valor_numerico) as total_gasto,
	car.valor_texto as cargo
	FROM viajes_claros_detalle nom
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=nom.id_viaje
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle car ON car.id_viaje=i.id_viaje AND car.tabla='personas' AND car.campo='cargo'
	INNER JOIN viajes_claros_detalle costo ON costo.id_viaje=i.id_viaje AND costo.tabla='' AND costo.campo='costo_total'
	WHERE 
		nom.tabla='personas' 
		AND nom.campo='nombres'
		AND i.id_dependencia=idDependencia
	GROUP BY nombres, apellido1, apellido2
	ORDER BY total_gasto DESC
	LIMIT 3;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_funcionarios_mayor_gasto_por_dep_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_funcionarios_mayor_gasto_por_dep_anio`(IN idDependencia INT(11), anio INT(11))
BEGIN

IF idDependencia=1 THEN
	select p.id_persona, p.nombres, p.apellido_paterno, p.apellido_materno, 
		SUM(v.valor_numerico) as total_gasto, p.cargo
	from personas p
	INNER JOIN comisiones c ON c.id_persona=p.id_persona
	INNER JOIN viajes_claros_instancias i ON i.id_comision=c.id_comision
	INNER JOIN viajes_claros_detalle v ON v.id_viaje=i.id_viaje AND v.campo='costo_total'
    INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	INNER JOIN usuarios u ON u.id_persona=p.id_persona
	WHERE u.id_dependencia=idDependencia
    AND YEAR(anio_viaje.valor_fecha) = anio
	GROUP BY p.id_persona
	ORDER BY total_gasto DESC LIMIT 3;
ELSE
	SELECT 0 as id_persona, nom.valor_texto as nombres, 
	ap1.valor_texto as apellido1, 
	ap2.valor_texto as apellido2,
	SUM(costo.valor_numerico) as total_gasto,
	car.valor_texto as cargo
	FROM viajes_claros_detalle nom
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=nom.id_viaje
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle car ON car.id_viaje=i.id_viaje AND car.tabla='personas' AND car.campo='cargo'
	INNER JOIN viajes_claros_detalle costo ON costo.id_viaje=i.id_viaje AND costo.tabla='' AND costo.campo='costo_total'
	INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	WHERE 
		nom.tabla='personas' 
		AND nom.campo='nombres'
		AND i.id_dependencia=idDependencia
		AND YEAR(anio_viaje.valor_fecha) = anio
	GROUP BY nombres, apellido1, apellido2
	ORDER BY total_gasto DESC
	LIMIT 3;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_hoteles_por_dep` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_hoteles_por_dep`(idDependencia INT(10))
BEGIN

	
select v.valor_texto as hotel, cd.valor_texto as ciudad, pa.valor_texto as pais, count(v.valor_texto) as num
FROM viajes_claros_detalle v
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=v.id_viaje
INNER JOIN viajes_claros_detalle cd ON cd.campo='ciudad_destino' AND cd.id_viaje=ins.id_viaje
INNER JOIN viajes_claros_detalle pa ON pa.campo='pais_destino' AND pa.id_viaje=ins.id_viaje
WHERE v.campo='nombre_hotel'
AND ins.id_dependencia=idDependencia
GROUP BY hotel, ciudad, pais
ORDER BY num desc
LIMIT 3;

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_hoteles_por_dep_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_hoteles_por_dep_anio`(idDependencia INT(10), anio INT(11))
BEGIN

select v.valor_texto as hotel, cd.valor_texto as ciudad, pa.valor_texto as pais, count(v.valor_texto) as num
FROM viajes_claros_detalle v
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=v.id_viaje
INNER JOIN viajes_claros_detalle cd ON cd.campo='ciudad_destino' AND cd.id_viaje=ins.id_viaje
INNER JOIN viajes_claros_detalle pa ON pa.campo='pais_destino' AND pa.id_viaje=ins.id_viaje
INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=v.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
WHERE v.campo='nombre_hotel'
AND ins.id_dependencia=idDependencia
AND YEAR(anio_viaje.valor_fecha) = anio
GROUP BY hotel, ciudad, pais
ORDER BY num desc
LIMIT 3;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_porcentajes_viajes_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_porcentajes_viajes_funcionario`(IN idPersona INT(11), IN inNombres VARCHAR(200), IN apellido1 VARCHAR(200), IN apellido2 VARCHAR(200))
BEGIN

IF idPersona > 0 THEN
	SELECT B.total_dias_viaje, B.dias_institucion, 
		B.total_dias_viaje*100/(B.total_dias_viaje + B.dias_institucion) as porcentaje_viaje,
		B.dias_institucion*100/(B.total_dias_viaje + B.dias_institucion) as porcentaje_institucion
	FROM (
		SELECT IFNULL(SUM(A.dias_viaje), 0) as total_dias_viaje, 
			A.dias_desde_ingreso-(FLOOR(A.dias_desde_ingreso/ 7)*2) - IFNULL(A.dias_viaje, 0) as dias_institucion
		FROM (
			SELECT p.id_persona, ini.id_viaje, ini.valor_fecha as ini, fin.valor_fecha as fin, 
				p.nombres, p.apellido_paterno, p.apellido_materno,
				DATEDIFF(fin.valor_fecha, ini.valor_fecha)+1 as dias_viaje, 
				DATEDIFF(NOW(), p.fecha_ingreso)+1 as dias_desde_ingreso
			FROM personas p
			LEFT JOIN comisiones c ON c.id_persona=p.id_persona
			LEFT JOIN viajes_claros_instancias i ON i.id_comision=c.id_comision
			LEFT JOIN viajes_claros_detalle ini ON ini.id_viaje=i.id_viaje AND ini.campo='fecha_hora_salida'
			LEFT JOIN viajes_claros_detalle fin ON fin.id_viaje=i.id_viaje AND fin.campo='fecha_hora_regreso'
			WHERE p.id_persona=idPersona
		) A
		GROUP BY A.id_persona
	) B;

	

ELSE
	SELECT IFNULL(B.total_dias_viaje, 0), IFNULL(B.dias_institucion, 0), 
		IFNULL(B.total_dias_viaje*100/(B.total_dias_viaje + B.dias_institucion), 0) as porcentaje_viaje,
		IFNULL(B.dias_institucion*100/(B.total_dias_viaje + B.dias_institucion), 0) as porcentaje_institucion
	FROM (
		SELECT 
			IFNULL(SUM(A.dias_viaje), 0) as total_dias_viaje, 
			A.dias_desde_ingreso-(FLOOR(A.dias_desde_ingreso/ 7)*2) - IFNULL(A.dias_viaje, 0) as dias_institucion
		FROM (
			SELECT n.id_viaje, n.valor_texto as nombres, ap1.valor_texto as apellido1, 
				ap2.valor_texto as apellido2, f.valor_fecha as fecha_ingreso, 
				ini.valor_fecha as fecha_ini, fin.valor_fecha as fecha_fin,
				DATEDIFF(fin.valor_fecha, ini.valor_fecha)+1 as dias_viaje, 
				DATEDIFF(NOW(), f.valor_fecha)+1 as dias_desde_ingreso
			FROM viajes_claros_instancias i
			INNER JOIN viajes_claros_detalle n ON n.id_viaje=i.id_viaje AND n.tabla='personas' AND n.campo='nombres'
			INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
			LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
			LEFT JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='personas' AND f.campo='fecha_ingreso'
			LEFT JOIN viajes_claros_detalle ini ON ini.id_viaje=i.id_viaje AND ini.campo='fecha_hora_salida'
			LEFT JOIN viajes_claros_detalle fin ON fin.id_viaje=i.id_viaje AND fin.campo='fecha_hora_regreso'
			WHERE n.valor_texto=inNombres
			AND ap1.valor_texto=apellido1
			AND ap2.valor_texto=apellido2
		) A
	) B;

END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_porcentajes_viajes_funcionario_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_porcentajes_viajes_funcionario_anio`(IN idPersona INT(11), IN inNombres VARCHAR(200), IN apellido1 VARCHAR(200), IN apellido2 VARCHAR(200),IN anio INT(11))
BEGIN

IF idPersona > 0 THEN
	SELECT B.total_dias_viaje, B.dias_institucion, 
		B.total_dias_viaje*100/(B.total_dias_viaje + B.dias_institucion) as porcentaje_viaje,
		B.dias_institucion*100/(B.total_dias_viaje + B.dias_institucion) as porcentaje_institucion
	FROM (
		SELECT IFNULL(SUM(A.dias_viaje), 0) as total_dias_viaje, 
			A.dias_desde_ingreso-(FLOOR(A.dias_desde_ingreso/ 7)*2) - IFNULL(A.dias_viaje, 0) as dias_institucion
		FROM (
			SELECT p.id_persona, ini.id_viaje, ini.valor_fecha as ini, fin.valor_fecha as fin, 
				p.nombres, p.apellido_paterno, p.apellido_materno,
				DATEDIFF(fin.valor_fecha, ini.valor_fecha)+1 as dias_viaje, 
				DATEDIFF(NOW(), p.fecha_ingreso)+1 as dias_desde_ingreso
			FROM personas p
			LEFT JOIN comisiones c ON c.id_persona=p.id_persona
			LEFT JOIN viajes_claros_instancias i ON i.id_comision=c.id_comision
			LEFT JOIN viajes_claros_detalle ini ON ini.id_viaje=i.id_viaje AND ini.campo='fecha_hora_salida'
			LEFT JOIN viajes_claros_detalle fin ON fin.id_viaje=i.id_viaje AND fin.campo='fecha_hora_regreso'
			WHERE p.id_persona=idPersona
            AND YEAR(ini.valor_fecha) = anio
		) A
		GROUP BY A.id_persona
	) B;
ELSE
	SELECT IFNULL(B.total_dias_viaje, 0), IFNULL(B.dias_institucion, 0), 
		IFNULL(B.total_dias_viaje*100/(B.total_dias_viaje + B.dias_institucion), 0) as porcentaje_viaje,
		IFNULL(B.dias_institucion*100/(B.total_dias_viaje + B.dias_institucion), 0) as porcentaje_institucion
	FROM (
		SELECT 
			IFNULL(SUM(A.dias_viaje), 0) as total_dias_viaje, 
			A.dias_desde_ingreso-(FLOOR(A.dias_desde_ingreso/ 7)*2) - IFNULL(A.dias_viaje, 0) as dias_institucion
		FROM (
			SELECT n.id_viaje, n.valor_texto as nombres, ap1.valor_texto as apellido1, 
				ap2.valor_texto as apellido2, f.valor_fecha as fecha_ingreso, 
				ini.valor_fecha as fecha_ini, fin.valor_fecha as fecha_fin,
				DATEDIFF(fin.valor_fecha, ini.valor_fecha)+1 as dias_viaje, 
				DATEDIFF(NOW(), f.valor_fecha)+1 as dias_desde_ingreso
			FROM viajes_claros_instancias i
			INNER JOIN viajes_claros_detalle n ON n.id_viaje=i.id_viaje AND n.tabla='personas' AND n.campo='nombres'
			INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
			LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
			LEFT JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='personas' AND f.campo='fecha_ingreso'
			LEFT JOIN viajes_claros_detalle ini ON ini.id_viaje=i.id_viaje AND ini.campo='fecha_hora_salida'
			LEFT JOIN viajes_claros_detalle fin ON fin.id_viaje=i.id_viaje AND fin.campo='fecha_hora_regreso'
			WHERE n.valor_texto=inNombres
            AND YEAR(ini.valor_fecha) = anio
			AND ap1.valor_texto=apellido1
			AND ap2.valor_texto=apellido2
		) A
	) B;

END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_tipo_pasaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_tipo_pasaje`(idDependencia INT(10))
BEGIN
	
SELECT CASE WHEN EXISTS (
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
	ELSE v.valor_texto END AS valor_texto, count(v.valor_texto)
FROM viajes_claros_detalle v
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=v.id_viaje
WHERE v.campo='tipo_pasaje'
AND ins.id_dependencia=idDependencia
GROUP BY valor_texto;
	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_tipo_pasaje_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_tipo_pasaje_anio`(idDependencia INT(10),anio INT(11))
BEGIN
	
SELECT CASE WHEN EXISTS (
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
	ELSE v.valor_texto END AS valor_texto, count(v.valor_texto)
FROM viajes_claros_detalle v
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=v.id_viaje
INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=v.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
WHERE v.campo='tipo_pasaje'
AND ins.id_dependencia=idDependencia
AND YEAR(anio_viaje.valor_fecha) = anio
GROUP BY valor_texto;
	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_tipo_viaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_tipo_viaje`(idDependencia INT)
BEGIN

SELECT CASE WHEN EXISTS (
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
	ELSE v.valor_texto END AS valor_texto, count(v.valor_texto)
FROM viajes_claros_detalle v
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=v.id_viaje
WHERE v.campo='tipo_viaje'
AND ins.id_dependencia=idDependencia
GROUP BY valor_texto;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_tipo_viaje_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_tipo_viaje_anio`(idDependencia INT,anio INT(11))
BEGIN

SELECT CASE WHEN EXISTS (
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
	ELSE v.valor_texto END AS valor_texto, count(v.valor_texto)
FROM viajes_claros_detalle v
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=v.id_viaje
INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=v.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
WHERE v.campo='tipo_viaje'
AND ins.id_dependencia=idDependencia
AND YEAR(anio_viaje.valor_fecha) = anio
GROUP BY valor_texto;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_ultimos_viajes_por_area` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_ultimos_viajes_por_area`(idArea INT(11))
BEGIN
	
SELECT i.id_viaje, DATE_FORMAT(i.fecha_publicacion, '%d/%m/%Y') fecha_publicacion,
	IFNULL(ev.valor_texto, '') as nombre_evento,
	IFNULL(pa.valor_texto, '') as pais_destino,
	IFNULL(cd.valor_texto, '') as ciudad_destino,
	IFNULL(costo.valor_numerico, 0) as costo_total
FROM viajes_claros_instancias i
LEFT JOIN viajes_claros_detalle costo ON costo.id_viaje=i.id_viaje AND costo.tabla='' AND costo.campo='costo_total'
LEFT JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
LEFT JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
LEFT JOIN viajes_claros_detalle ev ON ev.id_viaje=i.id_viaje AND ev.tabla='' AND ev.campo='nombre_evento'
INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
INNER JOIN viajes_claros_detalle area ON area.id_viaje=i.id_viaje AND area.tabla='areas' AND area.campo='id_area'
WHERE area.valor_numerico=idArea
ORDER BY anio_viaje.valor_fecha DESC LIMIT 3
;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_ultimos_viajes_por_area_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_ultimos_viajes_por_area_anio`(idArea INT(11),anio INT(11))
BEGIN
	

SELECT i.id_viaje, DATE_FORMAT(i.fecha_publicacion, '%d/%m/%Y') fecha_publicacion,
	IFNULL(ev.valor_texto, '') as nombre_evento,
	IFNULL(pa.valor_texto, '') as pais_destino,
	IFNULL(cd.valor_texto, '') as ciudad_destino,
	IFNULL(costo.valor_numerico, 0) as costo_total
FROM viajes_claros_instancias i
LEFT JOIN viajes_claros_detalle costo ON costo.id_viaje=i.id_viaje AND costo.tabla='' AND costo.campo='costo_total'
LEFT JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='ciudades' AND cd.campo='ciudad_destino'
LEFT JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='paises' AND pa.campo='pais_destino'
LEFT JOIN viajes_claros_detalle ev ON ev.id_viaje=i.id_viaje AND ev.tabla='' AND ev.campo='nombre_evento'
INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
INNER JOIN viajes_claros_detalle area ON area.id_viaje=i.id_viaje AND area.tabla='areas' AND area.campo='id_area'
WHERE area.valor_numerico=idArea
AND YEAR(anio_viaje.valor_fecha) = anio 
ORDER BY anio_viaje.valor_fecha DESC LIMIT 3
;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_ultimos_viajes_por_dep` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_ultimos_viajes_por_dep`(IN idDependencia INT(11))
BEGIN

	

	select v.id_viaje, v.id_dependencia, DATE_FORMAT(v.fecha_publicacion, '%d/%m/%y') as fecha_publicacion, 
	0 as id_persona, ev.valor_texto as nombre_evento, pais.valor_texto as pais_destino, 
	cd.valor_texto as ciudad_destino
from viajes_claros_instancias v
INNER JOIN viajes_claros_detalle ev ON ev.id_viaje=v.id_viaje AND ev.campo='nombre_evento'
INNER JOIN viajes_claros_detalle pais ON pais.id_viaje=v.id_viaje AND pais.campo='pais_destino'
INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=v.id_viaje AND cd.campo='ciudad_destino'
INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=v.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
WHERE v.id_dependencia=idDependencia
ORDER BY anio_viaje.valor_fecha DESC LIMIT 3;

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_ultimos_viajes_por_dep_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_ultimos_viajes_por_dep_anio`(IN idDependencia INT(11), anio INT(11))
BEGIN
	select v.id_viaje, v.id_dependencia, DATE_FORMAT(v.fecha_publicacion, '%d/%m/%y') as fecha_publicacion, 
	0 as id_persona, ev.valor_texto as nombre_evento, pais.valor_texto as pais_destino, 
	cd.valor_texto as ciudad_destino
from viajes_claros_instancias v
INNER JOIN viajes_claros_detalle ev ON ev.id_viaje=v.id_viaje AND ev.campo='nombre_evento'
INNER JOIN viajes_claros_detalle pais ON pais.id_viaje=v.id_viaje AND pais.campo='pais_destino'
INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=v.id_viaje AND cd.campo='ciudad_destino'
INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=v.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
WHERE v.id_dependencia=idDependencia
AND YEAR(anio_viaje.valor_fecha) = anio
ORDER BY anio_viaje.valor_fecha DESC LIMIT 3;

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_viajes_por_mes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_viajes_por_mes`(idDependencia INT(10))
BEGIN

	
SELECT CASE WHEN MONTH(det.valor_fecha)=1 THEN 'Enero' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=2 THEN 'Febrero' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=3 THEN 'Marzo' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=4 THEN 'Abril' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=5 THEN 'Mayo' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=6 THEN 'Junio' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=7 THEN 'Julio' ELSE
		CASE WHEN MONTH(det.valor_fecha)=8 THEN 'Agosto' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=9 THEN 'Septiembre' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=10 THEN 'Octubre' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=11 THEN 'Noviembre' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=12 THEN 'Diciembre' ELSE '' 
		END END END END END END END END END END END END as mes,
	count(det.id_viaje)
FROM viajes_claros_detalle det
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=det.id_viaje
WHERE det.campo='fecha_hora_salida'
AND ins.id_dependencia=idDependencia
AND YEAR(det.valor_fecha) = YEAR(CURDATE())
GROUP BY MONTH(det.valor_fecha);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_viajes_por_mes_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_viajes_por_mes_anio`(idDependencia INT(10), anio INT(11))
BEGIN

SELECT CASE WHEN MONTH(det.valor_fecha)=1 THEN 'Enero' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=2 THEN 'Febrero' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=3 THEN 'Marzo' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=4 THEN 'Abril' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=5 THEN 'Mayo' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=6 THEN 'Junio' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=7 THEN 'Julio' ELSE
		CASE WHEN MONTH(det.valor_fecha)=8 THEN 'Agosto' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=9 THEN 'Septiembre' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=10 THEN 'Octubre' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=11 THEN 'Noviembre' ELSE 
		CASE WHEN MONTH(det.valor_fecha)=12 THEN 'Diciembre' ELSE '' 
		END END END END END END END END END END END END as mes,
	count(det.id_viaje)
FROM viajes_claros_detalle det
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=det.id_viaje
WHERE det.campo='fecha_hora_salida'
AND ins.id_dependencia=idDependencia
AND YEAR(det.valor_fecha) = anio
GROUP BY MONTH(det.valor_fecha);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_viaticos_por_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_viaticos_por_funcionario`(IN idPersona INT(11),
	inNombres VARCHAR(200), inApellido1 VARCHAR(200), inApellido2 VARCHAR(200))
BEGIN


IF idPersona > 0 THEN
	SELECT v.campo, ROUND(SUM(v.valor_numerico),2)
	FROM viajes_claros_detalle v
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=v.id_viaje
	INNER JOIN comisiones c ON c.id_comision=i.id_comision
	WHERE v.campo='viaticos_comprobados'
	AND c.id_persona=idPersona
	GROUP BY c.id_persona
UNION ALL
	SELECT v.campo, ROUND(SUM(v.valor_numerico),2)
	FROM viajes_claros_detalle v
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=v.id_viaje
	INNER JOIN comisiones c ON c.id_comision=i.id_comision
	WHERE v.campo='viaticos_sin_comprobar'
	AND c.id_persona=idPersona
	GROUP BY c.id_persona
UNION ALL
	SELECT v.campo, ROUND(SUM(v.valor_numerico),2)
	FROM viajes_claros_detalle v
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=v.id_viaje
	INNER JOIN comisiones c ON c.id_comision=i.id_comision
	WHERE v.campo='viaticos_devueltos'
	AND c.id_persona=idPersona
	GROUP BY c.id_persona;
	

ELSE

	SELECT 'Viáticos comprobados',
		ROUND(IFNULL(SUM(v1.valor_numerico), 0),2) as valor
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle nom ON nom.id_viaje=i.id_viaje AND nom.tabla='personas' AND nom.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle v1 ON v1.id_viaje=i.id_viaje AND v1.tabla='' AND v1.campo='viaticos_comprobados'
	WHERE nom.valor_texto=inNombres
	AND ap1.valor_texto=inApellido1
	AND IF(ap2.valor_texto is null, '', ap2.valor_texto)=inApellido2
UNION ALL
	SELECT 'Gastos sin comprobantes',
		ROUND(IFNULL(SUM(v2.valor_numerico), 0),2) as valor
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle nom ON nom.id_viaje=i.id_viaje AND nom.tabla='personas' AND nom.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle v2 ON v2.id_viaje=i.id_viaje AND v2.tabla='' AND v2.campo='viaticos_sin_comprobar'
	WHERE nom.valor_texto=inNombres
	AND ap1.valor_texto=inApellido1
	AND IF(ap2.valor_texto is null, '', ap2.valor_texto)=inApellido2
UNION ALL
	SELECT 'Viáticos devueltos',
		ROUND(IFNULL(SUM(v3.valor_numerico), 0),2) as valor
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle nom ON nom.id_viaje=i.id_viaje AND nom.tabla='personas' AND nom.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle v3 ON v3.id_viaje=i.id_viaje AND v3.tabla='' AND v3.campo='viaticos_devueltos'	
	WHERE nom.valor_texto=inNombres
	AND ap1.valor_texto=inApellido1
	AND IF(ap2.valor_texto is null, '', ap2.valor_texto)=inApellido2;

END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grafica_viaticos_por_funcionario_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_viaticos_por_funcionario_anio`(IN idPersona INT(11),
	inNombres VARCHAR(200), inApellido1 VARCHAR(200), inApellido2 VARCHAR(200),IN anio INT(11))
BEGIN

IF idPersona > 0 THEN
	SELECT v.campo, ROUND(SUM(v.valor_numerico),2)
	FROM viajes_claros_detalle v
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=v.id_viaje
	INNER JOIN comisiones c ON c.id_comision=i.id_comision
    INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	WHERE v.campo='viaticos_comprobados'
	AND c.id_persona=idPersona
	AND YEAR(anio_viaje.valor_fecha) = anio
	GROUP BY c.id_persona
UNION ALL
	SELECT v.campo, ROUND(SUM(v.valor_numerico),2)
	FROM viajes_claros_detalle v
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=v.id_viaje
	INNER JOIN comisiones c ON c.id_comision=i.id_comision
	INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	WHERE v.campo='viaticos_sin_comprobar'
	AND c.id_persona=idPersona
	AND YEAR(anio_viaje.valor_fecha) = anio
	GROUP BY c.id_persona
UNION ALL
	SELECT v.campo, ROUND(SUM(v.valor_numerico),2)
	FROM viajes_claros_detalle v
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=v.id_viaje
	INNER JOIN comisiones c ON c.id_comision=i.id_comision
	INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	WHERE v.campo='viaticos_devueltos'
	AND c.id_persona=idPersona
	AND YEAR(anio_viaje.valor_fecha) = anio
	GROUP BY c.id_persona;
	

ELSE

	SELECT 'Viáticos comprobados',
		ROUND(IFNULL(SUM(v1.valor_numerico), 0),2) as valor
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle nom ON nom.id_viaje=i.id_viaje AND nom.tabla='personas' AND nom.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle v1 ON v1.id_viaje=i.id_viaje AND v1.tabla='' AND v1.campo='viaticos_comprobados'
	INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	WHERE nom.valor_texto=inNombres
	AND YEAR(anio_viaje.valor_fecha) = anio
	AND ap1.valor_texto=inApellido1
	AND IF(ap2.valor_texto is null, '', ap2.valor_texto)=inApellido2
UNION ALL
	SELECT 'Gastos sin comprobantes',
		ROUND(IFNULL(SUM(v2.valor_numerico), 0),2) as valor
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle nom ON nom.id_viaje=i.id_viaje AND nom.tabla='personas' AND nom.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle v2 ON v2.id_viaje=i.id_viaje AND v2.tabla='' AND v2.campo='viaticos_sin_comprobar'
	INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	WHERE nom.valor_texto=inNombres
	AND YEAR(anio_viaje.valor_fecha) = anio
	AND ap1.valor_texto=inApellido1
	AND IF(ap2.valor_texto is null, '', ap2.valor_texto)=inApellido2
UNION ALL
	SELECT 'Viáticos devueltos',
		ROUND(IFNULL(SUM(v3.valor_numerico), 0),2) as valor
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle nom ON nom.id_viaje=i.id_viaje AND nom.tabla='personas' AND nom.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle v3 ON v3.id_viaje=i.id_viaje AND v3.tabla='' AND v3.campo='viaticos_devueltos'	
	INNER JOIN viajes_claros_detalle anio_viaje ON anio_viaje.id_viaje=i.id_viaje AND anio_viaje.tabla='' AND anio_viaje.campo='fecha_hora_salida'
	WHERE nom.valor_texto=inNombres
	AND YEAR(anio_viaje.valor_fecha) = anio
	AND ap1.valor_texto=inApellido1
	AND IF(ap2.valor_texto is null, '', ap2.valor_texto)=inApellido2;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inserta_archivos_procesados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `inserta_archivos_procesados`(id_arch bigint, nom_archivo text)
BEGIN
	insert into `viajes_claros`.`archivos_procesados`
	values (id_arch, nom_archivo, now(), 0, 0, 0);
    commit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inserta_archivos_procesados_det` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `inserta_archivos_procesados_det`(id_arch bigint, num_reg int(11), error text)
BEGIN
	insert into `viajes_claros`.`archivo_lineas`
	values (default, id_arch, num_reg, null, error);
    commit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_buscador_despliegue_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_buscador_despliegue_config`(idDep INT, nombreTabla VARCHAR(50), nombreCampo VARCHAR(50), ordenCampo TINYINT(4), mostrarCampo TINYINT(1))
BEGIN
	
	INSERT INTO buscador_despliegue_config(id_dependencia, tabla, campo, orden, mostrar)
	VALUES(idDep, nombreTabla, nombreCampo, ordenCampo, mostrarCampo);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_buscador_filtros_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_buscador_filtros_config`(IN idDep INT(10), IN nombreTabla VARCHAR(50), IN nombreCampo VARCHAR(50), IN operador VARCHAR(50), IN ordenFiltro TINYINT(4))
BEGIN
	
	
	SET @tipoControl = (SELECT CASE WHEN base.tipo_control IS NULL THEN din.tipo_control ELSE base.tipo_control END as tipo_control
		FROM viajes_claros_config c
		LEFT JOIN campos_base base ON base.tabla = c.tabla AND base.campo = c.campo
		LEFT JOIN campos_dinamicos din ON din.nombre_campo = c.campo
		WHERE c.campo=nombreCampo AND c.tabla=nombreTabla);
		
	SET @operador = (SELECT CASE WHEN @tipoControl=1 THEN 'LIKE' ELSE 
					(CASE WHEN @tipoControl=2 THEN '=' ELSE operador END) END);	
	
		
	INSERT INTO buscador_filtros_config
	(id_dependencia, tabla, campo, operador, orden)
	VALUES(idDep, nombreTabla, nombreCampo, @operador, ordenFiltro);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_campo_dinamico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_campo_dinamico`(IN nombreCampo VARCHAR(60), IN tipoDato INT(10), 
IN idLista INT(10), IN inDescripcion VARCHAR(250), IN inDespliegue VARCHAR(200), 
IN busquedaDefecto INT(10), IN tipoControl INT(10), IN codigoCategoria VARCHAR(50))
BEGIN
	
	
INSERT INTO campos_dinamicos
(nombre_campo, tipo_dato, id_lista, descripcion, despliegue, busqueda_defecto, tipo_control, categoria)
VALUES(nombreCampo, tipoDato, idLista, inDescripcion, inDespliegue, busquedaDefecto, tipoControl, codigoCategoria);

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_comisiones_desglose_gastos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_comisiones_desglose_gastos`(IN idCom INT(11), IN idRegistroGasto INT(11), 
IN campo VARCHAR(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN
IF ((valorTexto IS NOT NULL OR valorFecha IS NOT NULL) AND valorNumerico = 0) THEN
	INSERT INTO comisiones_desglose_gastos VALUES(DEFAULT, idCom, NULL, campo, valorTexto, NULL, valorFecha,idRegistroGasto);
ELSE 
	INSERT INTO comisiones_desglose_gastos VALUES(DEFAULT, idCom, NULL, campo, valorTexto, valorNumerico, valorFecha,idRegistroGasto);
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_comisiones_detalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_comisiones_detalle`(IN idCom INT(11), IN tabla VARCHAR(50), 
IN campo VARCHAR(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN
IF ((valorTexto IS NOT NULL OR valorFecha IS NOT NULL) AND valorNumerico = 0) THEN
	INSERT INTO comisiones_detalle VALUES(DEFAULT, idCom, tabla, campo, valorTexto, NULL, valorFecha);
ELSE 
	INSERT INTO comisiones_detalle VALUES(DEFAULT, idCom, tabla, campo, valorTexto, valorNumerico, valorFecha);
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_flujos_campos_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_flujos_campos_config`(
		IN idFlujo INT(11), IN idTipoPersona INT(11), 
		IN inTabla VARCHAR(200), IN inCampo VARCHAR(200), 
		IN inEtiqueta VARCHAR(200), IN listaHabilitada TINYINT(3), 
		IN inObligatorio TINYINT(3), IN idSeccion INT(11), IN inOrden INT(11), IN inSubtipo VARCHAR(150),
        IN inSoloLectura TINYINT(3), IN inClase VARCHAR(150))
BEGIN

	
INSERT INTO flujos_campos_config
(id_flujo, tabla, campo, etiqueta, lista_habilitada, obligatorio, id_tipo_persona, id_seccion_formulario, orden, subtipo, solo_lectura, clase)
VALUES(idFlujo, inTabla, inCampo, inEtiqueta, listaHabilitada, inObligatorio, idTipoPersona, idSeccion, inOrden,inSubtipo,inSoloLectura,inClase);

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_gastos_campos_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_gastos_campos_config`( 
		IN inTabla VARCHAR(200), IN inCampo VARCHAR(200), 
		IN inEtiqueta VARCHAR(200), IN listaHabilitada TINYINT(3), 
		IN inObligatorio TINYINT(3), IN inOrden INT(11), IN inSubtipo VARCHAR(150))
BEGIN

	
INSERT INTO gastos_campos_config
(tabla, campo, etiqueta, lista_habilitada, obligatorio, orden, subtipo)
VALUES(inTabla, inCampo, inEtiqueta, listaHabilitada, inObligatorio, inOrden,inSubtipo);

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_grafica_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_grafica_config`(idDependencia INT(11), idGrafica INT(11))
BEGIN
	
INSERT INTO graficas_config
(id_dependencia, id_grafica)
VALUES(idDependencia, idGrafica);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_interfaz_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_interfaz_config`(inTabla VARCHAR(100), inCampo VARCHAR(100),
	listaHabilitada INT(3), inEtiqueta VARCHAR(200), inSecuencia INT(11), 
	idDependencia INT(11), inEditable INT(3))
BEGIN
	
INSERT INTO interfaz_config
(tabla, campo, lista_habilitada, etiqueta, secuencia, id_dependencia, editable)
VALUES(inTabla, inCampo, listaHabilitada, inEtiqueta, inSecuencia, idDependencia, inEditable);

	
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_listas_valores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_listas_valores`(IN nombreLista VARCHAR(50))
BEGIN
	
INSERT INTO listas_valores
(nombre_lista, habilitada)
VALUES(nombreLista, 1);

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_secciones_formulario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_secciones_formulario`(
	IN inEtiqueta VARCHAR(200), IN inNombre VARCHAR(200), IN idFlujo INT, IN orden INT)
BEGIN
	

INSERT INTO secciones_formulario
(etiqueta, nombre_seccion, id_flujo, orden_seccion)
VALUES(inEtiqueta, inNombre, idFlujo, orden);
	
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_suscripcion_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_suscripcion_config`(IN idDependencia INT(11), IN nombreCampo VARCHAR(60))
BEGIN


	
IF EXISTS (SELECT campo 
	FROM suscripcion_config WHERE id_dependencia=idDependencia AND campo=nombreCampo) THEN
	set @res=0;
ELSE
	
	INSERT INTO suscripcion_config(id_dependencia, campo)
	VALUES(idDependencia, nombreCampo);

END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_suscripcion_email_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_suscripcion_email_config`(IN idPersona INT(11), 
	IN correo VARCHAR(200), IN inNombres VARCHAR(200), 
	IN inApellido1 VARCHAR(200), IN inApellido2 VARCHAR(200))
BEGIN

IF EXISTS (
	SELECT id_persona FROM suscripcion_email_config 
	WHERE id_persona=1 
	AND email=correo
	AND nombres=inNombres
	AND apellido1=inApellido1
	AND apellido2=inApellido2
) THEN
	SET @existe = true;
ELSE
	INSERT INTO suscripcion_email_config
	(id_persona, email, nombres, apellido1, apellido2)
	VALUES(idPersona, correo, inNombres, inApellido1, inApellido2);
END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_valores_dinamicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_valores_dinamicos`(idLista INT, codigo VARCHAR(30), valor VARCHAR(150))
BEGIN
	
INSERT INTO viajes_claros.valores_dinamicos
(id_lista, codigo, valor)
VALUES(idLista, codigo, valor);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_viajes_claros_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_viajes_claros_config`(IN nombreTabla VARCHAR(50), IN nombreCampo VARCHAR(50))
BEGIN
	
INSERT INTO viajes_claros_config
(tabla, campo)
VALUES(nombreTabla, nombreCampo);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_categoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obtener_categoria`(id int)
BEGIN
	select id_categoria, nombre_categoria, tope_hospedaje, tope_viaticos
	from `viajes_claros`.`categoria`
	where id_categoria = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_area` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_area`(id integer)
BEGIN
	select id_area, nombre_area, id_dependencia
	from `viajes_claros`.`areas`
	where 1=1
	and id_area = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_areas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_areas`()
BEGIN
	select id_area, nombre_area, id_dependencia
	from `viajes_claros`.`areas`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_bitacora` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_bitacora`(id_arch bigint)
BEGIN
	select id_archivo, nombre_archivo, fecha_carga, total_registros, total_aceptados, total_rechazados
	from `viajes_claros`.`archivos_procesados`
	where 1=1
	and id_archivo = id_arch;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_categorias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_categorias`()
BEGIN
	select id_categoria, nombre_categoria, tope_hospedaje, tope_viaticos
	from `viajes_claros`.`categoria`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_ciudad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_ciudad`(id integer)
BEGIN
	select id_ciudad, nombre_ciudad, id_pais, id_estado, latitud, longitud
	from `viajes_claros`.`ciudades`
	where 1=1
	and id_ciudad = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_ciudades` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_ciudades`()
BEGIN
	select id_ciudad, nombre_ciudad, id_pais, id_estado, latitud, longitud
	from `viajes_claros`.`ciudades`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_dependencia`(siglas_dep text)
BEGIN
	select id_dependencia
	from `viajes_claros`.`dependencias`
	where 1=1
	and siglas = siglas_dep;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_dependencias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_dependencias`()
BEGIN
	select id_dependencia, siglas, nombre_dependencia, predeterminada
	from `viajes_claros`.`dependencias`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_dependencia_by_Id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_dependencia_by_Id`(id integer)
BEGIN
	select id_dependencia, siglas, nombre_dependencia, predeterminada
	from `viajes_claros`.`dependencias`
	where 1=1
	and id_dependencia = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_errores_carga` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_errores_carga`(id_arch bigint)
BEGIN
	select id_error, id_archivo, id_linea, estatus, comentarios
	from `viajes_claros`.`archivo_lineas` 
	where 1=1
    and id_archivo = id_arch;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_estado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_estado`(id integer)
BEGIN
	select id_estado, nombre_estado, id_pais
	from `viajes_claros`.`estados`
	where 1=1
	and id_estado = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_estados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_estados`()
BEGIN
	select id_estado, nombre_estado, id_pais
	from `viajes_claros`.`estados`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_grupos_aprobacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_grupos_aprobacion`()
BEGIN
	select id_conf_aprobacion, nombre, id_flujo, id_dependencia, id_area, id_jerarquia, editable
	from `viajes_claros`.`configuracion_aprobacion`
	where 1=1
	order by id_conf_aprobacion;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_grupo_aprobacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_grupo_aprobacion`(id integer)
BEGIN
	select id_conf_aprobacion, nombre, id_flujo, id_dependencia, id_area, id_jerarquia, editable
	from `viajes_claros`.`configuracion_aprobacion`
	where 1=1
	and id_conf_aprobacion = id
	order by id_conf_aprobacion;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_grupo_aprobacion_by_area` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_grupo_aprobacion_by_area`(flujo integer, depen integer, area integer)
BEGIN
	select id_conf_aprobacion, nombre, id_flujo, id_dependencia, id_area, id_jerarquia, editable
	from `viajes_claros`.`configuracion_aprobacion`
	where 1=1
	and id_flujo = flujo
	and id_dependencia = depen
	and id_area = area;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_grupo_aprobacion_by_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_grupo_aprobacion_by_name`(nom text, flujo integer)
BEGIN
	select id_conf_aprobacion, nombre, id_flujo, id_dependencia, id_area, id_jerarquia, editable
	from `viajes_claros`.`configuracion_aprobacion`
	where 1=1
	and id_flujo = flujo
	and nombre like concat('%',nom,'%');

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_id_dependencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_id_dependencia`(siglas_dep text)
BEGIN
	select id_dependencia
	from `viajes_claros`.`dependencias`
	where 1=1
	and siglas = siglas_dep;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_id_viaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_id_viaje`(id_arch bigint)
BEGIN
	select id_viaje
	from `viajes_claros`.`viajes_claros_instancias`
	where 1=1
	and id_archivo = id_arch;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_info_seccs_notif` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_info_seccs_notif`(instancia long, seccion integer, tipo_per integer)
BEGIN
	select cd.id_detalle, cd.id_comision, cd.tabla, cd.campo
		  ,cd.valor_texto, cd.valor_numerico, cd.valor_fecha
	from viajes_claros.flujos_instancias fi
		,viajes_claros.comisiones c
		,viajes_claros.comisiones_detalle cd
		,viajes_claros.secciones_formulario sf
		,viajes_claros.flujos_campos_config cf
	where 1=1
	and fi.id_instancia = instancia
	and cf.id_tipo_persona = tipo_per
	and cf.id_seccion_formulario = seccion
	and c.id_comision = fi.id_comision
	and c.id_comision = cd.id_comision
	and fi.id_flujo = sf.id_flujo
	and sf.id_seccion = cf.id_seccion_formulario
	and cf.tabla = cd.tabla
	and cf.campo = cd.campo;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_instancia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_instancia`(id long)
BEGIN
	select id_flujo, id_instancia, id_comision, fecha_inicio, fecha_fin, asignado
	from `viajes_claros`.`flujos_instancias`
	where 1=1
	and id_instancia = id
	order by fecha_inicio desc;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_instancias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_instancias`()
BEGIN
	select id_flujo, id_instancia, id_comision, fecha_inicio, fecha_fin, asignado
	from `viajes_claros`.`flujos_instancias`
	where 1=1
	order by fecha_inicio desc;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_instancia_by_usr` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_instancia_by_usr`(id long, user integer)
BEGIN
	select id_instancia, id_flujo, id_comision, fecha_inicio, fecha_fin, asignado
	from `viajes_claros`.`flujos_instancias` fi
	where 1=1
	and id_instancia = id
	and exists (select 1
				from viajes_claros.comisiones c 
				where 1=1
				and c.id_comision = fi.id_comision
				and id_usuario = user)
	order by fecha_inicio desc;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_interfaz_carga` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_interfaz_carga`(id_dep int(11))
BEGIN
	select ic.tabla, ic.campo, lista_habilitada, etiqueta, secuencia, cb.tipo_dato
	from `viajes_claros`.`interfaz_config` ic, `viajes_claros`.`campos_base` cb
	where 1=1
    and ic.id_dependencia = id_dep
    and ic.tabla = cb.tabla
    and ic.campo = cb.campo
	union all
	select ic.tabla, ic.campo, lista_habilitada, etiqueta, secuencia, cd.tipo_dato
		from `viajes_claros`.`interfaz_config` ic, `viajes_claros`.`campos_dinamicos` cd
		where 1=1
        and ic.id_dependencia = id_dep
		and ic.campo = cd.nombre_campo
		and (ic.tabla is null or ic.tabla = '')
	order by secuencia;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_jerarquia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_jerarquia`(id integer)
BEGIN
	select id_jerarquia, nombre_jerarquia, editable
	from `viajes_claros`.`jerarquias`
	where 1=1
	and id_jerarquia = id
	order by id_jerarquia;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_jerarquias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_jerarquias`()
BEGIN
	select id_jerarquia, nombre_jerarquia, editable
	from `viajes_claros`.`jerarquias`
	order by id_jerarquia;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_layout` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_layout`(id_dep int(11))
BEGIN
	select tabla, campo, lista_habilitada, etiqueta, secuencia, null tipo_dato
	from `viajes_claros`.`interfaz_config` 
	where 1=1
    and id_dependencia = id_dep
	order by secuencia;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_mail_server` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_mail_server`()
BEGIN
	select id, host, puerto, usuario, password
	from `viajes_claros`.`smtp_config`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_miembro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_miembro`(id integer)
BEGIN
	select id_miembro, id_jerarquia, id_usuario
	from `viajes_claros`.`jerarquia_miembros`
	where 1=1
	and id_miembro = id
	order by id_miembro;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_miembros` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_miembros`(id_jerar integer)
BEGIN
	select id_miembro, id_jerarquia, id_usuario
	from `viajes_claros`.`jerarquia_miembros`
	where 1=1
	and id_jerarquia = id_jerar
	order by id_miembro;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_pais` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_pais`(id integer)
BEGIN
	select id_pais, clave_pais, nombre_pais, predeterminado
	from `viajes_claros`.`paises`
	where 1=1
	and id_pais = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_paises` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_paises`()
BEGIN
	select id_pais, clave_pais, nombre_pais, predeterminado
	from `viajes_claros`.`paises`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_perfil` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_perfil`(id integer)
BEGIN
	select id_perfil, nombre_perfil
	from `viajes_claros`.`perfiles`
	where 1=1
	and id_perfil = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_perfiles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_perfiles`()
BEGIN
	select id_perfil, nombre_perfil
	from `viajes_claros`.`perfiles`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_persona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_persona`(id int(11))
BEGIN
	select id_persona, nombres, apellido_paterno, apellido_materno, titulo
		  ,email, id_categoria, id_tipo_persona, id_posicion, cargo, fecha_ingreso
	from `viajes_claros`.`personas`
	where 1=1
	and id_persona = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_personas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_personas`()
BEGIN
	select id_persona, nombres, apellido_paterno, apellido_materno, titulo
		  ,email, id_categoria, id_tipo_persona, id_posicion, cargo, fecha_ingreso
	from `viajes_claros`.`personas`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_posicion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_posicion`(id integer)
BEGIN
	select id_posicion, nombre_posicion
	from `viajes_claros`.`posiciones`
	where 1=1
	and id_posicion = id
	order by nombre_posicion;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_posiciones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_posiciones`()
BEGIN
	select id_posicion, nombre_posicion
	from `viajes_claros`.`posiciones`
	order by nombre_posicion;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_proceso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_proceso`(id integer)
BEGIN
	select id_flujo, nombre_flujo, descripcion, version
	from `viajes_claros`.`flujos_trabajo`
	where 1=1
	and id_flujo = id
	order by id_flujo;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_procesos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_procesos`()
BEGIN
	select id_flujo, nombre_flujo, descripcion, version
	from `viajes_claros`.`flujos_trabajo`
	order by id_flujo;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_seccs_notif_flujo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_seccs_notif_flujo`(flujo integer)
BEGIN
	select id_seccion, etiqueta, nombre_seccion, id_flujo, orden_seccion
	from `viajes_claros`.`secciones_formulario`
	where 1=1
	and id_flujo = flujo
	order by orden_seccion;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_tipo_persona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_tipo_persona`(id integer)
BEGIN
	select id_tipo, codigo_tipo, descripcion
	from `viajes_claros`.`tipo_persona`
	where 1=1
	and id_tipo = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_tipo_personas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_tipo_personas`()
BEGIN
	select id_tipo, codigo_tipo, descripcion
	from `viajes_claros`.`tipo_persona`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_usuario`(id integer)
BEGIN
	select id_usuario, usuario, contrasena, salt, descripcion, habilitado, intentos
		  ,id_perfil, id_dependencia, id_persona, id_area, jefe_area, id_bonita
	from `viajes_claros`.`usuarios`
	where 1=1
	and id_usuario = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_usuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_usuarios`()
BEGIN
	select id_usuario, usuario, contrasena, salt, descripcion, habilitado, intentos
		  ,id_perfil, id_dependencia, id_persona, id_area, jefe_area, id_bonita
	from `viajes_claros`.`usuarios`
	order by usuario;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_usuario_bonita` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_usuario_bonita`(id bigint)
BEGIN
	select id_usuario, usuario, contrasena, salt, descripcion, habilitado, intentos
		  ,id_perfil, id_dependencia, id_persona, id_area, jefe_area, id_bonita
	from `viajes_claros`.`usuarios`
	where 1=1
	and id_bonita = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_usuario_by_str` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_usuario_by_str`(us text)
BEGIN
	select id_usuario, usuario, contrasena, salt, descripcion, habilitado, intentos
		  ,id_perfil, id_dependencia, id_persona, id_area, jefe_area, id_bonita
	from `viajes_claros`.`usuarios`
	where 1=1
	and usuario = us;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_usuario_jefe_area` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_usuario_jefe_area`(depen integer, area integer)
BEGIN
	select id_usuario, usuario, contrasena, salt, descripcion, habilitado, intentos
		  ,id_perfil, id_dependencia, id_persona, id_area, jefe_area, id_bonita
	from `viajes_claros`.`usuarios`
	where 1=1
	and id_dependencia = depen
	and id_area = area
	and jefe_area = 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_viajes_fecha` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_viajes_fecha`(fecha_salida datetime)
BEGIN
	select distinct id_viaje from `viajes_claros`.`viajes_claros_detalle`
	where valor_fecha = fecha_salida
    and campo = 'fecha_hora_salida';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obten_viaje_x_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_viaje_x_id`(id int(11))
BEGIN
	select * from `viajes_claros`.`viajes_claros_detalle`
	where id_viaje = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tiene_layout` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `tiene_layout`(id_dep int(11))
BEGIN
   
	  select count(*)
	  from viajes_claros.interfaz_config ic       
      where 1=1
	  and ic.id_dependencia = id_dep;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_campo_dinamico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_campo_dinamico`(IN nombreCampo VARCHAR(50), IN idTipoDato INT(10), 
IN idLista INT(10), IN inDescripcion VARCHAR(200), 
IN inDespliegue VARCHAR(50), IN busquedaDefecto TINYINT(4), 
IN idTipoControl INT(10), IN codigoCategoria VARCHAR(50))
BEGIN
	
UPDATE campos_dinamicos
SET tipo_dato=idTipoDato, id_lista=idLista, descripcion=inDescripcion, 
	despliegue=inDespliegue, busqueda_defecto=busquedaDefecto, 
	tipo_control=idTipoControl, categoria=codigoCategoria
WHERE nombre_campo=nombreCampo;

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_comision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_comision`(IN idComision INT(11),nuevoEstatus varchar(2))
BEGIN	
	UPDATE comisiones SET estatus = nuevoEstatus WHERE id_comision = idComision;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_comision_desglose_gastos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_comision_desglose_gastos`(IN idComision INT(11),IN idRegistro INT(11),IN camp varchar(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN	
IF ((valorTexto IS NOT NULL OR valorFecha IS NOT NULL) AND valorNumerico = 0) THEN
	UPDATE comisiones_desglose_gastos SET valor_texto = valorTexto, valor_numerico = NULL, valor_fecha = valorFecha WHERE id_comision = idComision AND id_registro_gasto_comision = idRegistro AND campo=camp;
ELSE 
	UPDATE comisiones_desglose_gastos SET valor_texto = valorTexto, valor_numerico = valorNumerico, valor_fecha = valorFecha WHERE id_comision = idComision AND id_registro_gasto_comision = idRegistro AND campo=camp;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_comision_detalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_comision_detalle`(IN idComision INT(11),IN tab varchar(50),IN camp varchar(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN	
IF ((valorTexto IS NOT NULL OR valorFecha IS NOT NULL) AND valorNumerico = 0) THEN
	UPDATE comisiones_detalle SET valor_texto = valorTexto, valor_numerico = NULL, valor_fecha = valorFecha WHERE id_comision = idComision AND tabla = tab AND campo=camp;
ELSE 
	UPDATE comisiones_detalle SET valor_texto = valorTexto, valor_numerico = valorNumerico, valor_fecha = valorFecha WHERE id_comision = idComision AND tabla = tab AND campo=camp;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_flujos_campos_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_flujos_campos_config`(
	IN idFlujo INT(11), IN idTipoPersona INT(11), 
	IN inTabla VARCHAR(200), IN inCampo VARCHAR(200), 
	IN inEtiqueta VARCHAR(200), IN listaHabilitada TINYINT(3), 
	IN inObligatorio TINYINT(3), IN idSeccion INT(11), inOrden INT(11), IN inSubtipo VARCHAR(150),
    IN inSoloLectura TINYINT(3), IN inClase VARCHAR(150))
BEGIN
	
UPDATE flujos_campos_config
SET etiqueta=inEtiqueta, lista_habilitada=listaHabilitada, obligatorio=inObligatorio,
	id_seccion_formulario=idSeccion, orden=inOrden, subtipo=inSubtipo,solo_lectura=inSoloLectura, clase = inClase
WHERE id_flujo=idFlujo AND id_tipo_persona=idTipoPersona AND tabla=inTabla AND campo=inCampo;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_gastos_campos_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_gastos_campos_config`(
	IN idGastoCampoConfig INT(11), IN inTabla VARCHAR(200), IN inCampo VARCHAR(200), 
	IN inEtiqueta VARCHAR(200), IN listaHabilitada TINYINT(3), 
	IN inObligatorio TINYINT(3), inOrden INT(11), IN inSubtipo VARCHAR(150))
BEGIN
	
UPDATE gastos_campos_config
SET tabla=inTabla, campo=inCampo,etiqueta=inEtiqueta,
	lista_habilitada=listaHabilitada,obligatorio=inObligatorio, orden=inOrden, subtipo=inSubtipo
WHERE id_gasto_campo_config=idGastoCampoConfig AND tabla=inTabla AND campo=inCampo;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_interfaz_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_interfaz_config`(inTabla VARCHAR(100), 
		inCampo VARCHAR(100), idDep INT(11), listaHabilitada INT(3), 
		inEtiqueta VARCHAR(100), inSecuencia INT(3), inEditable INT(3))
BEGIN
		
UPDATE viajes_claros.interfaz_config
SET lista_habilitada=listaHabilitada, etiqueta=inEtiqueta, 
	secuencia=inSecuencia, editable=inEditable
WHERE tabla=inTabla AND campo=inCampo AND id_dependencia=idDep;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_listas_valores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_listas_valores`(idLista INT, nombreLista VARCHAR(50), isHabilitada BOOLEAN)
BEGIN
	
UPDATE listas_valores
SET nombre_lista=nombreLista, habilitada=isHabilitada
WHERE id_lista=idLista;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_seccion_formulario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_seccion_formulario`(
	idSeccion INT(11), inEtiqueta VARCHAR(200), 
	nombre VARCHAR(200), idFlujo INT(11), orden INT(11))
BEGIN

	
UPDATE secciones_formulario
SET etiqueta=inEtiqueta, nombre_seccion=nombre, id_flujo=idFlujo, orden_seccion=orden
WHERE id_seccion=idSeccion;

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_valor_dinamico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_valor_dinamico`(idLista INT, inCodigo VARCHAR(30), inValor VARCHAR(150))
BEGIN
	
	UPDATE valores_dinamicos SET valor=inValor
	WHERE id_lista=idLista AND codigo=inCodigo;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `valida_dato` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `valida_dato`(tabla text, campo text, filtro text)
BEGIN
   if tabla = 'paises' and (campo = 'pais_origen' or campo = 'pais_destino') then
		SET campo = 'nombre_pais';
   elseif tabla = 'estados' and (campo = 'estado_origen' or campo = 'estado_destino') then
		SET campo = 'nombre_estado';
   elseif tabla = 'ciudades' and (campo = 'ciudad_origen' or campo = 'ciudad_destino') then
		SET campo = 'nombre_ciudad';
   end if;


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
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-17 19:51:27
