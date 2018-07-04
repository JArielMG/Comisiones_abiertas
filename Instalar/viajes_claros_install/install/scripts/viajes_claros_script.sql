-- MySQL dump 10.13  Distrib 5.5.46, for Linux (x86_64)
--
-- Host: localhost    Database: viajes_claros
-- ------------------------------------------------------
-- Server version	5.5.46-log

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
-- Table structure for table `dependencias`
--
USE viajes_claros;

DROP TABLE IF EXISTS `dependencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dependencias` (
  `id_dependencia` int(11) NOT NULL AUTO_INCREMENT,
  `siglas` varchar(20) DEFAULT NULL,
  `nombre_dependencia` varchar(400) DEFAULT NULL,
  `predeterminada` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_dependencia`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependencias`
--

LOCK TABLES `dependencias` WRITE;
/*!40000 ALTER TABLE `dependencias` DISABLE KEYS */;
INSERT INTO `dependencias` VALUES (1,'INAI','Instituto Nacional de Transparencia, Acceso a la Información y Protección de Datos Personales',1);
/*!40000 ALTER TABLE `dependencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `archivos_procesados`
--

DROP TABLE IF EXISTS `archivos_procesados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archivos_procesados` (
  `id_archivo` BIGINT NOT NULL AUTO_INCREMENT ,
  `nombre_archivo` VARCHAR(200) NOT NULL ,
  `fecha_carga` DATETIME NOT NULL ,
  `total_registros` INT NULL ,
  `total_aceptados` INT NULL ,
  `total_rechazados` INT NULL ,
  PRIMARY KEY (`id_archivo`)
) ENGINE=InnoDB AUTO_INCREMENT=2147483647 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archivos_procesados`
--

LOCK TABLES `archivos_procesados` WRITE;
/*!40000 ALTER TABLE `archivos_procesados` DISABLE KEYS */;
-- INSERT INTO `archivos_procesados` VALUES (1,'viajes_ine','1969-12-31 18:00:00',7,7,0),(2147483647,'Prueba2.csv','2015-11-28 01:29:57',0,0,0);
/*!40000 ALTER TABLE `archivos_procesados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `archivo_lineas`
--

DROP TABLE IF EXISTS `archivo_lineas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archivo_lineas` (
  `id_error` INT NOT NULL AUTO_INCREMENT ,
  `id_archivo` BIGINT NOT NULL ,
  `id_linea` INT NOT NULL ,
  `estatus` VARCHAR(30) NULL ,
  `comentarios` VARCHAR(300) NULL ,
  PRIMARY KEY (`id_error`) ,
  INDEX `fk_archivo_lineas_archivos_procesados1_idx` (`id_archivo` ASC) ,
  CONSTRAINT `fk_archivo_lineas_archivos_procesados1`
    FOREIGN KEY (`id_archivo` )
    REFERENCES `viajes_claros`.`archivos_procesados` (`id_archivo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archivo_lineas`
--

LOCK TABLES `archivo_lineas` WRITE;
/*!40000 ALTER TABLE `archivo_lineas` DISABLE KEYS */;
-- INSERT INTO `archivo_lineas` VALUES (1,2015112812957,1,NULL,'El dato de la columna Ciudad no corresponde a alguno registrado en el catálogo.'),(2,2015112812957,2,NULL,'El dato de la columna Ciudad no corresponde a alguno registrado en el catálogo.'),(3,2015112812957,3,NULL,'El dato de la columna Ciudad no corresponde a alguno registrado en el catálogo.');
/*!40000 ALTER TABLE `archivo_lineas` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
-- INSERT INTO `areas` VALUES (1,'Finanzas',1),(2,'Comisiones',1),(3,'Abogacia',1);
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `viajes_claros_config`
--

LOCK TABLES `viajes_claros_config` WRITE;
/*!40000 ALTER TABLE `viajes_claros_config` DISABLE KEYS */;
-- INSERT INTO `viajes_claros_config` VALUES ('','aerolinea_ida'),('','aerolinea_regreso'),('','antecedentes_comision'),('','cargo_funcionario'),('','ciudad_destino'),('','ciudad_origen'),('','costo_total'),('','costo_total_hospedaje'),('','costo_viaticos'),('','desc_comision'),('','fecha_hora_regreso'),('','fecha_hora_salida'),('','informe_contribucion'),('','informe_resultados'),('','motivo_comision'),('','nombre_evento'),('','nombre_hotel'),('','pais_destino'),('','pais_origen'),('','tipo_pago'),('','tipo_pasaje'),('','tipo_viaje'),('','unidad_administrativa'),('','url_evento'),('','viaticos_comprobados'),('','viaticos_devueltos'),('','viaticos_sin_comprobar'),('categoria','nombre_categoria'),('personas','apellido_materno'),('personas','apellido_paterno'),('personas','cargo'),('personas','fecha_ingreso'),('personas','nombres');
/*!40000 ALTER TABLE `viajes_claros_config` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`id_dependencia`,`tabla`,`campo`),
  KEY `fk_buscador_despliegue_config_viajes_claros_config1_idx` (`tabla`,`campo`),
  CONSTRAINT `fk_buscador_despliegue_config_dependencias1` FOREIGN KEY (`id_dependencia`) REFERENCES `dependencias` (`id_dependencia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_buscador_despliegue_config_viajes_claros_config1` FOREIGN KEY (`tabla`, `campo`) REFERENCES `viajes_claros_config` (`tabla`, `campo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buscador_despliegue_config`
--

LOCK TABLES `buscador_despliegue_config` WRITE;
/*!40000 ALTER TABLE `buscador_despliegue_config` DISABLE KEYS */;
-- INSERT INTO `buscador_despliegue_config` VALUES (3,'','aerolinea_ida'),(1,'','ciudad_destino'),(1,'','ciudad_origen'),(1,'','costo_total'),(2,'','fecha_hora_regreso'),(1,'','fecha_hora_salida'),(2,'','fecha_hora_salida'),(3,'','fecha_hora_salida'),(1,'','tipo_pasaje'),(2,'','tipo_pasaje'),(1,'','tipo_viaje'),(2,'','tipo_viaje'),(1,'personas','apellido_paterno'),(2,'personas','apellido_paterno'),(1,'personas','nombres');
/*!40000 ALTER TABLE `buscador_despliegue_config` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`id_dependencia`,`tabla`,`campo`),
  KEY `fk_table1_viajes_claros_config1_idx` (`tabla`,`campo`),
  CONSTRAINT `fk_table1_dependencias1` FOREIGN KEY (`id_dependencia`) REFERENCES `dependencias` (`id_dependencia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_viajes_claros_config1` FOREIGN KEY (`tabla`, `campo`) REFERENCES `viajes_claros_config` (`tabla`, `campo`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
-- INSERT INTO `categoria` VALUES (1,'Categoria A',10000,10000),(2,'Categoria B',20000,20000),(3,'Categoria C',30000,30000);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `categoria_campo`
--

LOCK TABLES `categoria_campo` WRITE;
/*!40000 ALTER TABLE `categoria_campo` DISABLE KEYS */;
-- INSERT INTO `categoria_campo` VALUES ('comision','Comisión'),('evento','Evento'),('funcionario','Funcionario'),('informacion_vuelo','Información de vuelo'),('informe_comision','Informe de comisión'),('observaciones','Observaciones'),('tipo_viaje','Tipo de viaje'),('viaticos','Viáticos');
/*!40000 ALTER TABLE `categoria_campo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `buscador_filtros_config`
--

LOCK TABLES `buscador_filtros_config` WRITE;
/*!40000 ALTER TABLE `buscador_filtros_config` DISABLE KEYS */;
-- INSERT INTO `buscador_filtros_config` VALUES (1,'','tipo_pasaje','='),(1,'','tipo_viaje','='),(2,'','tipo_pasaje','='),(2,'','tipo_viaje','='),(2,'personas','nombres','LIKE');
/*!40000 ALTER TABLE `buscador_filtros_config` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `campos_base`
--

LOCK TABLES `campos_base` WRITE;
/*!40000 ALTER TABLE `campos_base` DISABLE KEYS */;
-- INSERT INTO `campos_base` VALUES ('categoria','nombre_categoria',1,'Categoría','Categoría',0,2,NULL),('ciudades','nombre_ciudad',1,'Ciudad','Ciudad',0,2,NULL),('dependencias','nombre_dependencia',1,'Dependencia','Dependencia',0,2,NULL),('dependencias','siglas',1,'Siglas','Siglas',1,2,NULL),('estados','nombre_estado',1,'Estado','Estado',0,1,NULL),('paises','clave_pais',1,'País','País',0,1,NULL),('personas','apellido_materno',1,'Apellido Materno','Apellido Materno',1,1,'funcionario'),('personas','apellido_paterno',1,'Apellido Paterno','Apellido Paterno',1,1,'funcionario'),('personas','cargo',1,'Cargo','Cargo',0,1,'funcionario'),('personas','fecha_ingreso',1,'Fecha de ingreso a ls institución','Fecha de ingreso',NULL,3,'funcionario'),('personas','nombres',1,'Nombre(s)','Nombre(s)',1,1,'funcionario'),('tipo_persona','descripcion',1,'Tipo Persona','Tipo Persona',0,1,NULL);
/*!40000 ALTER TABLE `campos_base` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listas_valores`
--

LOCK TABLES `listas_valores` WRITE;
/*!40000 ALTER TABLE `listas_valores` DISABLE KEYS */;
INSERT INTO `listas_valores` VALUES (2,'tipo_pago',1),(3,'comparador',1),(4,'tipo_vuelos',1),(11,'tipo_hotel',1),(13,'tipo_autobus',1),(14,'tipo_viaje',1),(15,'tipo_pasaje',1),(16,'tipo_gasolina',1),(17,'unidad_administrativa',1),(18,'tipo_representacion',1),(19,'tipo_invitado',1),(20,'tipo_zona',1),(21,'tipo_pago',1),(22,'homologacion',1),(23,'moneda',1),(24,'tarifa_pernocta',1),(25,'tarifa_sin_pernocta',1);
/*!40000 ALTER TABLE `listas_valores` ENABLE KEYS */;
UNLOCK TABLES;

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
  `despliegue` varchar(50) DEFAULT NULL,
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
-- Dumping data for table `campos_dinamicos`
--

LOCK TABLES `campos_dinamicos` WRITE;
/*!40000 ALTER TABLE `campos_dinamicos` DISABLE KEYS */;
-- INSERT INTO `campos_dinamicos` VALUES ('aerolinea_ida',2,NULL,'Aerolínea del vuelo de  ida','Aerolínea de ida',0,1,'informacion_vuelo'),('aerolinea_regreso',2,NULL,'Aerolínea del vuelo de regreso','Aerolínea de regreso',0,1,'informacion_vuelo'),('antecedentes_comision',2,NULL,'Antecedentes de la comisión','Antecedentes',0,1,'comision'),('area_funcionario',2,NULL,'Área de Adscripción','Área de Adscripción',0,1,'funcionario'),('cargo_funcionario',2,NULL,'Cargo del funcionario (datos histórico)','Cargo',0,1,'funcionario'),('ciudad_destino',2,NULL,'Ciudad destino','Ciudad destino',0,1,'tipo_viaje'),('ciudad_origen',2,NULL,'Ciudad origen','Ciudad origen',0,1,'tipo_viaje'),('comparador',1,3,'Comparador','Comparador',0,2,'comision'),('costo_total',1,NULL,'Costo total del viaje','Costo total',0,1,'viaticos'),('costo_total_hospedaje',1,NULL,'Costo total del hospedaje','Costo total hospedaje',0,1,'viaticos'),('costo_viaticos',1,NULL,'Costo total de viáticos','Costo total de viáticos',0,1,'viaticos'),('descripcion',2,NULL,'Descripción del Evento','Descripción',0,1,'comision'),('desc_comision',1,NULL,'Descripción Comisión','Descripción',0,1,'comision'),('estado_destino',2,NULL,'Estado de Destino','Estado',0,1,'comision'),('fecha_hora_regreso',3,NULL,'Fecha y Hora Regreso','Fecha y Hora Regreso',0,3,'tipo_viaje'),('fecha_hora_salida',3,NULL,'Fecha y Hora Salida','Fecha y Hora Salida',0,3,'tipo_viaje'),('fecha_regreso_comision',3,NULL,'Fecha de la Salida de la Comisión','Regreso',0,3,'comision'),('fecha_salida_comision',3,NULL,'Fecha de Salida de la Comisión','Salida',0,3,'comision'),('fecha_solicitud_comision',3,NULL,'Fecha de Solicitud de Comisión','Fecha de Solicitud',0,3,'comision'),('homologacion',2,22,'Homologacion','Homologación',0,2,'comision'),('hora_regreso_comision',3,NULL,'Hora de Regreso de la Comisión','Hora',0,3,'comision'),('hora_salida_comision',3,NULL,'Hora de Salida de la Comisión','Hora',0,3,'comision'),('informe_contribucion',2,NULL,'¿Cuáles fueron los logros?','Contribución',0,1,'informe_comision'),('informe_resultados',2,NULL,'Resultados obtenidos de la comisión','Resultados obtenidos',0,1,'informe_comision'),('moneda',2,23,'Moneda','Moneda',0,2,'comision'),('monto_con_pernocta',1,NULL,'Monto Con Pernocta','Monto',0,1,'comision'),('monto_letra',2,NULL,'Monto a Viaticar en Letra','Monto a Viaticar en Letra',0,1,'comision'),('monto_sin_pernocta',1,NULL,'Monto Sin Pernocta','Monto',0,1,'comision'),('motivo_comision',2,NULL,'Motivo de la comisión','Motivo de la comisión',0,1,'comision'),('nacionalidad',2,NULL,'Nacionalidad','Nacionalidad',0,1,'comision'),('nivel_homologacion',2,NULL,'Nivel Homologación','Nivel Homologación',0,1,'comision'),('nombre_evento',2,NULL,'Nombre del evento o actividad','Nombre del evento',0,1,'evento'),('nombre_hotel',2,NULL,'Nombre del hotel','Nombre del hotel',0,1,'viaticos'),('num_acuerdo',2,NULL,'Número de Acuerdo','Número de Acuerdo',0,1,'comision'),('num_dias_con_pernocta',1,NULL,'Número de Días con Pernocta','Num. Días Con Pernocta',0,1,'comision'),('num_dias_sin_pernocta',1,NULL,'Número de Días Sin Pernocta','Num. Días Sin Pernocta',0,1,'comision'),('organizador',2,NULL,'Organizador del Evento','Organizador',0,1,'comision'),('pais_destino',2,NULL,'País destino','País destino',0,1,'tipo_viaje'),('pais_origen',2,NULL,'País origen','País origen',0,1,'tipo_viaje'),('tarifa_con_pernocta',1,24,'Tarifa Con Pernocta','Tarifa Con Pernocta',0,1,'comision'),('tarifa_correspondiente',1,NULL,'Tarifa Correspondiente','Tarifa Correspondiente',0,1,'comision'),('tarifa_sin_pernocta',1,25,'Tarifa Sin Pernocta','Tarifa Sin Pernocta',0,1,'comision'),('tipo_invitado',2,19,'Tipo de Invitado','Tipo de Invitado',0,2,'comision'),('tipo_pago',1,2,'Tipo de Pago','Tipo de Pago',1,2,'comision'),('tipo_pasaje',1,15,'Aéreo o terrestre','Tipo de pasaje',0,2,'comision'),('tipo_representacion',2,18,'Tipo Representacion','Tipo de Representación',0,2,'comision'),('tipo_viaje',1,14,'Nacional o internacional','Tipo de viaje',0,2,'tipo_viaje'),('tipo_zona',2,20,'Tipo de Zona','Tipo de Zona',0,2,'comision'),('unidad_administrativa',2,17,'Unidad Administrativa','Unidad Administrativa',0,2,'funcionario'),('url_evento',2,NULL,'URL del evento','URL del evento',0,1,'evento'),('viaticos_comprobados',1,NULL,'Viáticos comprobados','Viáticos comprobados',0,1,'viaticos'),('viaticos_devueltos',1,NULL,'Viáticos devueltos','Viáticos devueltos',0,1,'viaticos'),('viaticos_sin_comprobar',1,NULL,'Viáticos sin comprobar','Viáticos sin comprobar',0,1,'viaticos'),('vinculo_internet',2,NULL,'Vínculo Internet','Vínculo Internet',0,1,'comision');
/*!40000 ALTER TABLE `campos_dinamicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paises`
--

DROP TABLE IF EXISTS `paises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paises` (
  `id_pais` INT NOT NULL AUTO_INCREMENT ,
  `clave_pais` VARCHAR(3) NOT NULL ,
  `nombre_pais` VARCHAR(300) NOT NULL ,
  `predeterminado` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`id_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paises`
--

LOCK TABLES `paises` WRITE;
/*!40000 ALTER TABLE `paises` DISABLE KEYS */;
-- INSERT INTO `paises` VALUES (1,'MX','México',1),(2,'USA','Estados Unidos de América',0),(3,'CAN','Canadá',0),(4,'UK','Reino Unido',0),(5,'ARG','Argentina',0),(6,'CH','Chile',0),(7,'CHI','China',0),(8,'SLV','El Salvador',0),(9,'MAU','Mauricio',0),(10,'BR','Brasil',0);
/*!40000 ALTER TABLE `paises` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados`
--

LOCK TABLES `estados` WRITE;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
-- INSERT INTO `estados` VALUES (1,'Distrito Federal',1),(2,'Estado de México',1),(3,'Nuevo León',1),(4,'Jalisco',1),(5,'Nueva York',2),(6,'Quintana Roo',1),(7,'Manchester',4),(8,'Buenos Aires',5),(9,'Guanajuato',1),(10,'Santiago',6),(11,'Vancouver',3),(12,'Coahuila',1),(13,'Ningbo',7),(14,'Distrito de Columbia',2),(15,'San Salvador',8),(16,'Port Louis',9),(17,'Brasil',10),(18,'Baja California',1);
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciudades`
--

LOCK TABLES `ciudades` WRITE;
/*!40000 ALTER TABLE `ciudades` DISABLE KEYS */;
-- INSERT INTO `ciudades` VALUES (1,'Ciudad de México',1,1,NULL,NULL),(2,'Monterrey',1,3,NULL,NULL),(3,'Guadalajara',1,4,NULL,NULL),(4,'Nueva York',2,5,NULL,NULL),(7,'Manchester',4,7,'53.4807593','-2.2426305'),(8,'Chetumal',1,6,'18.5001889','-88.3483756'),(9,'Buenos Aires',5,8,'-34.6036844','-58.3815591'),(10,'San Miguel de Allende',1,9,'20.9144491','-100.745235'),(11,'Toluca',1,2,'19.2826098','-99.6556653'),(12,'Santiago',6,10,'-33.4488897','-70.6692655'),(13,'Vancouver',3,11,'49.2827291','-123.1207375'),(14,'Saltillo',1,12,'25.4267244','-100.9954254'),(15,'Ningbo',7,12,'29.868336','121.54399'),(16,'Washington, D. C.',2,14,'38.8031495','-77.11974'),(17,'San Salvador',8,15,'13.6929403','-89.2181911'),(18,'Port Louis',9,16,'-20.348404','57.55215200000001'),(19,'Brasilia',10,17,'-14.235004','-51.92528'),(20,'Mexicali',1,18,'32.6245389','-115.4522623');
/*!40000 ALTER TABLE `ciudades` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfiles`
--

LOCK TABLES `perfiles` WRITE;
/*!40000 ALTER TABLE `perfiles` DISABLE KEYS */;
INSERT INTO `perfiles` VALUES (1,'Administrador'),(2,'Configurador'),(3,'Usuario'),(4,'Carga_Masiva');
/*!40000 ALTER TABLE `perfiles` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posiciones`
--

LOCK TABLES `posiciones` WRITE;
/*!40000 ALTER TABLE `posiciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `posiciones` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `tipo_persona`
--

LOCK TABLES `tipo_persona` WRITE;
/*!40000 ALTER TABLE `tipo_persona` DISABLE KEYS */;
INSERT INTO `tipo_persona` VALUES (1,'COM','Comisionado'),(2,'FUN','Funcionario'),(3,'INV','Invitado');
/*!40000 ALTER TABLE `tipo_persona` ENABLE KEYS */;
UNLOCK TABLES;

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
  `id_posicion` INT NULL ,
  `cargo` varchar(200) DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  PRIMARY KEY (`id_persona`),
  KEY `fk_funcionarios_categoria1_idx` (`id_categoria`),
  KEY `fk_personas_tipo_persona1_idx` (`id_tipo_persona`),
  INDEX `fk_personas_posiciones1_idx` (`id_posicion` ASC) ,
  CONSTRAINT `fk_funcionarios_categoria1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_personas_tipo_persona1` FOREIGN KEY (`id_tipo_persona`) REFERENCES `tipo_persona` (`id_tipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_personas_posiciones1` FOREIGN KEY (`id_posicion` ) REFERENCES `viajes_claros`.`posiciones` (`id_posicion` ) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
-- INSERT INTO `personas` VALUES (1,'Francisco','Gonzalez','Caballero','Ingeniero','xxx@yyy.com',1,2,NULL,NULL,'2014-12-31'),(2,'Adrián','Alcalá','Méndez','Ingeniero','xxx@yyy.com',1,2,NULL,NULL,'2013-12-31'),(3,'Pedro','López','','Ingeniero','pedro.lopez@mail.com',1,2,NULL,'Director general','2014-12-31'),(4,'Ricardo','Raya','Aranda','Licenciado','ricardo.raya@mail.com',1,2,NULL,'Jefe de Departamento de Verificación en Materia de Datos Personales','2015-05-31'),(5,'Ximena','Puente','de la Mora','Licenciada','ximena.puente@mail.com',1,2,NULL,'Comisionada Presidente','2014-08-30'),(6,'José de Jesús','Ramírez','Sánchez','Ingeniero','jose.ramirez@mail.com',1,2,NULL,'Coordinador Ejecutivo','2015-01-31'),(7,'Luis Gustavo','Parra','Noriega','Ingeniero','luis.parra@mail.com',1,2,NULL,'Coordinador de Protección de Datos Personales','2015-02-28'),(8,'Eduardo Felipe','Fernández','Sánchez','Ingeniero','eduardo.fernandez@mail.com',1,2,NULL,'Director General de Administración','2014-10-30'),(9,'Tania','Sánchez','','Ingeniero','tania.sanchez@mail.com',1,2,NULL,'Director General','2015-05-01'),(10,'María del Rosario','Vásquez','','Ingeniero','maria.vasquez@mail.com',1,2,NULL,'Director General','2015-03-31');
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;

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
  `id_persona` int(11) NULL,
  `id_area` int(11) NULL,
  `id_bonita` LONG NULL ,
  PRIMARY KEY (`id_usuario`),
  KEY `fk_usuarios_perfiles_idx` (`id_perfil`),
  KEY `fk_usuarios_dependencias1_idx` (`id_dependencia`),
  KEY `fk_usuarios_funcionarios1_idx` (`id_persona`),
  KEY `fk_usuarios_areas1_idx` (`id_area`),
  CONSTRAINT `fk_usuarios_areas1` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id_area`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_dependencias1` FOREIGN KEY (`id_dependencia`) REFERENCES `dependencias` (`id_dependencia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_funcionarios1` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_perfiles` FOREIGN KEY (`id_perfil`) REFERENCES `perfiles` (`id_perfil`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'ADMIN','MzAAwhpBVmmgGZWu/fXHIIoFWFTYC6oyFVNjtqpeinc=','7XvNRxtw7B/lp3xz3cGi1w==','Administrador',1,0,0,1,1,null,null,1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comisiones`
--

LOCK TABLES `comisiones` WRITE;
/*!40000 ALTER TABLE `comisiones` DISABLE KEYS */;
-- INSERT INTO `comisiones` VALUES (1,'P',1,3,3),(2,'P',1,1,1),(3,'P',1,1,1),(4,'P',1,4,4),(5,'P',1,5,5),(6,'P',1,2,2),(7,'P',1,6,6),(8,'P',1,7,7),(9,'P',1,8,8),(10,'P',1,9,9),(11,'P',1,10,10),(12,'P',1,1,1),(13,'P',1,1,1),(14,'P',1,1,1),(15,'P',1,1,1),(16,'EA',1,5,5),(17,'RV',1,4,4),(18,'EV',1,6,6),(19,'P',1,2,2);
/*!40000 ALTER TABLE `comisiones` ENABLE KEYS */;
UNLOCK TABLES;

CREATE TABLE `registros_gastos_comision` (
  `id_registro_gasto_comision` int(11) NOT NULL AUTO_INCREMENT,
  `id_comision` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_registro_gasto_comision`),
  KEY `fk_id_comision` (`id_comision`),
  CONSTRAINT `fk_id_comision` FOREIGN KEY (`id_comision`) REFERENCES `comisiones` (`id_comision`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comisiones_desglose_gastos`
--

LOCK TABLES `comisiones_desglose_gastos` WRITE;
/*!40000 ALTER TABLE `comisiones_desglose_gastos` DISABLE KEYS */;
/*!40000 ALTER TABLE `comisiones_desglose_gastos` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comisiones_detalle`
--

LOCK TABLES `comisiones_detalle` WRITE;
/*!40000 ALTER TABLE `comisiones_detalle` DISABLE KEYS */;
INSERT INTO `comisiones_detalle` VALUES (1,1,'','fecha_hora_salida',NULL,NULL,'2015-03-30 18:00:00'),(2,12,'','fecha_hora_salida','',NULL,'2015-12-05 18:00:00'),(3,12,'','fecha_hora_regreso',NULL,NULL,'2015-12-08 18:00:00'),(4,16,'','fecha_hora_salida','',NULL,'2015-11-25 18:00:00'),(5,16,'','fecha_hora_regreso','',NULL,'2015-11-28 18:00:00'),(6,17,'','fecha_hora_salida','',NULL,'2015-12-06 18:00:00'),(7,17,'','ciudad_destino','Manchester',NULL,NULL),(8,17,'','pais_destino','Reino Unido',NULL,NULL),(9,18,'','fecha_hora_salida','',NULL,'2015-12-10 18:00:00'),(10,18,'','fecha_hora_regreso','',NULL,'2015-12-11 18:00:00'),(11,17,'','fecha_hora_regreso','',NULL,'2015-12-06 18:00:00'),(12,19,'','fecha_hora_salida','',NULL,'2014-12-04 00:00:00'),(13,19,'','fecha_hora_salida',NULL,NULL,NULL),(14,9,'','pais_destino','México',NULL,NULL),(15,9,'','ciudad_destino','San Miguel de Allende',NULL,NULL),(16,9,'','fecha_hora_salida',NULL,NULL,'2014-09-05 00:00:00'),(21,1,'','fecha_hora_regreso','',NULL,'2015-04-04 00:00:00');
/*!40000 ALTER TABLE `comisiones_detalle` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `flujos_trabajo`
--

LOCK TABLES `flujos_trabajo` WRITE;
/*!40000 ALTER TABLE `flujos_trabajo` DISABLE KEYS */;
INSERT INTO `flujos_trabajo` VALUES (1,'Solicitud de Comision','Solicitud de Comision','1.0'),(2,'Solicitud de Viaticos','Solicitud de Viaticos y Hospedaje','1.0'),(3,'Ingreso de Comprobantes','Ingreso de Comprobantes de Gastos','1.0'),(4,'Solicitud de Publicacion','Solicitud de Publicacion','1.0');
/*!40000 ALTER TABLE `flujos_trabajo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jerarquias`
--

DROP TABLE IF EXISTS `jerarquias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jerarquias` (
  `id_jerarquia` INT NOT NULL AUTO_INCREMENT ,
    `nombre_jerarquia` VARCHAR(200) NULL ,
    `editable` TINYINT(1) NULL ,
  PRIMARY KEY (`id_jerarquia`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jerarquias`
--

LOCK TABLES `jerarquias` WRITE;
/*!40000 ALTER TABLE `jerarquias` DISABLE KEYS */;
INSERT INTO `jerarquias` VALUES (1,'Pleno',0),(2,'Presidencia',0),(3,'DGA',0);
/*!40000 ALTER TABLE `jerarquias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracion_aprobacion`
--

DROP TABLE IF EXISTS `configuracion_aprobacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuracion_aprobacion` (
  `id_conf_aprobacion` INT NOT NULL AUTO_INCREMENT ,
    `nombre` VARCHAR(200) NOT NULL ,
    `id_flujo` INT NOT NULL ,
    `id_dependencia` INT NOT NULL ,
    `id_area` INT NULL ,
    `id_jerarquia` INT NOT NULL ,
    `editable` TINYINT(1) NULL ,
    INDEX `fk_aprobadores_flujos_aprobacion1_idx` (`id_flujo` ASC) ,
    PRIMARY KEY (`id_conf_aprobacion`) ,
    INDEX `fk_configuracion_aprobacion_dependencias1_idx` (`id_dependencia` ASC) ,
    INDEX `fk_configuracion_aprobacion_areas1_idx` (`id_area` ASC) ,
    INDEX `fk_configuracion_aprobacion_jerarquias1_idx` (`id_jerarquia` ASC) ,
    CONSTRAINT `fk_aprobadores_flujos_aprobacion1`
      FOREIGN KEY (`id_flujo` )
      REFERENCES `viajes_claros`.`flujos_trabajo` (`id_flujo` )
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    CONSTRAINT `fk_configuracion_aprobacion_dependencias1`
      FOREIGN KEY (`id_dependencia` )
      REFERENCES `viajes_claros`.`dependencias` (`id_dependencia` )
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    CONSTRAINT `fk_configuracion_aprobacion_areas1`
      FOREIGN KEY (`id_area` )
      REFERENCES `viajes_claros`.`areas` (`id_area` )
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    CONSTRAINT `fk_configuracion_aprobacion_jerarquias1`
      FOREIGN KEY (`id_jerarquia` )
      REFERENCES `viajes_claros`.`jerarquias` (`id_jerarquia` )
      ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracion_aprobacion`
--

LOCK TABLES `configuracion_aprobacion` WRITE;
/*!40000 ALTER TABLE `configuracion_aprobacion` DISABLE KEYS */;
-- INSERT INTO `configuracion_aprobacion` VALUES (1,),(),();
/*!40000 ALTER TABLE `configuracion_aprobacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `secciones_formulario`
--

DROP TABLE IF EXISTS `secciones_formulario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secciones_formulario` (
  `id_seccion` int(11) NOT NULL AUTO_INCREMENT,
  `etiqueta` varchar(254) DEFAULT NULL,
  `nombre_seccion` varchar(150) NOT NULL,
  `id_flujo` int(11) NOT NULL,
  `orden_seccion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_seccion`),
  KEY `fk_id_seccion_formulario_flujo` (`id_flujo`),
  CONSTRAINT `fk_flujo_seccion` FOREIGN KEY (`id_flujo`) REFERENCES `flujos_trabajo` (`id_flujo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `secciones_formulario`
--

LOCK TABLES `secciones_formulario` WRITE;
/*!40000 ALTER TABLE `secciones_formulario` DISABLE KEYS */;
-- INSERT INTO `secciones_formulario` VALUES (1,'Información del viaje','informacion_viaje',1,1),(2,'Datos del empleado','datos_empleado',2,1),(3,'Datos del evento','datos_evento',2,2),(4,'seccion 4','seccion 4',1,1),(5,'Seccion 5','Seccion5',1,1),(6,'seccion 6','seccion6',1,1),(7,'seccion 7','seccion7',1,1),(8,'seccion8','seccion8',1,1),(9,'Información de Viáticos','info_viaticos',2,3),(10,'Información de Viáticos','info_viaticos',3,2),(11,'Informe de Comisión','informe_comision',4,1),(13,'Información de Comisiónes','info_comision',1,3);
/*!40000 ALTER TABLE `secciones_formulario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flujos_campos_config`
--

DROP TABLE IF EXISTS `flujos_campos_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flujos_campos_config` (
  `id_flujo` int(11) NOT NULL,
  `tabla` varchar(50) NOT NULL DEFAULT '',
  `campo` varchar(50) NOT NULL,
  `etiqueta` varchar(100) DEFAULT NULL,
  `lista_habilitada` tinyint(1) DEFAULT NULL,
  `obligatorio` tinyint(4) DEFAULT '0',
  `id_tipo_persona` int(11) NOT NULL DEFAULT '0',
  `id_seccion_formulario` int(11) DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  `subtipo` varchar(150) DEFAULT NULL,
  `solo_lectura` tinyint(1) DEFAULT NULL,
  `clase` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_flujo`,`tabla`,`campo`,`id_tipo_persona`),
  KEY `fk_flujos_campos_config_flujos_trabajo1_idx` (`id_flujo`),
  KEY `flujos_campos_config_tipo_persona_FK` (`id_tipo_persona`),
  KEY `flujos_campos_config_secciones_formulario_FK` (`id_seccion_formulario`),
  CONSTRAINT `fk_flujos_campos_config_flujos_trabajo1` FOREIGN KEY (`id_flujo`) REFERENCES `flujos_trabajo` (`id_flujo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `flujos_campos_config_secciones_formulario_FK` FOREIGN KEY (`id_seccion_formulario`) REFERENCES `secciones_formulario` (`id_seccion`),
  CONSTRAINT `flujos_campos_config_tipo_persona_FK` FOREIGN KEY (`id_tipo_persona`) REFERENCES `tipo_persona` (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flujos_campos_config`
--

LOCK TABLES `flujos_campos_config` WRITE;
/*!40000 ALTER TABLE `flujos_campos_config` DISABLE KEYS */;
-- INSERT INTO `flujos_campos_config` VALUES (1,'','aerolinea_ida','Aerolínea de ida',0,1,3,1,NULL,NULL,NULL,NULL),(1,'','aerolinea_regreso','Aerolínea de regreso',0,1,3,1,NULL,NULL,NULL,NULL),(1,'','area_funcionario','Área',0,1,1,1,2,'SIMPLE',1,NULL),(1,'','area_funcionario','Área',0,1,2,1,2,'SIMPLE',1,NULL),(1,'','area_funcionario','Área',0,1,3,1,2,'SIMPLE',1,NULL),(1,'','ciudad_destino','Ciudad',0,1,1,2,15,'SIMPLE',0,NULL),(1,'','ciudad_destino','Ciudad',0,1,2,2,15,'SIMPLE',0,NULL),(1,'','ciudad_destino','Ciudad',0,1,3,2,15,'SIMPLE',0,NULL),(1,'','descripcion','Descripción',0,1,1,2,10,'AREA',0,NULL),(1,'','descripcion','Descripción',0,1,2,2,10,'AREA',0,NULL),(1,' ','descripcion','Descripción',0,1,3,2,10,'AREA',0,NULL),(1,'','estado_destino','Estado',0,1,1,2,14,'SIMPLE',0,NULL),(1,'','estado_destino','Estado',0,1,2,2,14,'SIMPLE',0,NULL),(1,'','estado_destino','Estado',0,1,3,2,14,'SIMPLE',0,NULL),(1,'','fecha_hora_regreso','Fecha de regreso',0,1,1,1,NULL,NULL,NULL,NULL),(1,'','fecha_hora_regreso','Fecha de regreso',0,1,2,1,NULL,NULL,NULL,NULL),(1,'','fecha_hora_salida','Fecha de salida',0,0,1,1,NULL,NULL,NULL,NULL),(1,'','fecha_hora_salida','Fecha de salida',0,1,2,1,NULL,NULL,NULL,NULL),(1,'','fecha_regreso_comision','Regreso',0,1,1,3,18,'FECHA',0,NULL),(1,'','fecha_regreso_comision','Regreso',0,1,2,3,18,'FECHA',0,NULL),(1,'','fecha_regreso_comision','Regreso',0,1,3,3,18,'FECHA',0,NULL),(1,'','fecha_salida_comision','Salida',0,1,1,3,16,'FECHA',0,NULL),(1,'','fecha_salida_comision','Salida',0,1,2,3,16,'FECHA',0,NULL),(1,'','fecha_salida_comision','Salida',0,1,3,3,16,'FECHA',0,NULL),(1,'','fecha_solicitud_comision','Fecha de Solicitud',0,1,1,1,1,'FECHA',0,NULL),(1,'','fecha_solicitud_comision','Fecha de Solicitud',0,1,2,1,1,'FECHA',0,NULL),(1,'','fecha_solicitud_comision','Fecha de Solicitud',0,1,3,1,1,'FECHA',0,NULL),(1,'','homologacion','Homologación',1,1,1,4,20,NULL,0,'homologacion'),(1,'','homologacion','Homologación',1,1,2,4,20,NULL,0,'homologacion'),(1,'','homologacion','Homologación',1,1,3,4,20,NULL,0,'homologacion'),(1,'','hora_regreso_comision','Hora',0,1,1,3,19,'HORA',0,NULL),(1,'','hora_regreso_comision','Hora',0,1,2,3,19,'HORA',0,NULL),(1,'','hora_regreso_comision','Hora',0,1,3,3,19,'HORA',0,NULL),(1,'','hora_salida_comision','Hora',0,1,1,3,17,'HORA',0,NULL),(1,'','hora_salida_comision','Hora',0,1,2,3,17,'HORA',0,NULL),(1,'','hora_salida_comision','Hora',0,1,3,3,17,'HORA',0,NULL),(1,'','moneda','Moneda',1,1,1,4,32,NULL,0,NULL),(1,'','moneda','Moneda',1,1,2,4,32,NULL,0,NULL),(1,'','moneda','Moneda',1,1,3,4,32,NULL,0,NULL),(1,'','monto_con_pernocta','Monto',0,1,1,4,30,'SIMPLE',1,'muestraMontoCP'),(1,'','monto_con_pernocta','Monto',0,1,2,4,30,'SIMPLE',1,'muestraMontoCP'),(1,'','monto_con_pernocta','Monto',0,1,3,4,30,'SIMPLE',1,'muestraMontoCP'),(1,'','monto_letra','Monto a Viaticar en Letra',0,1,1,4,33,'SIMPLE',0,NULL),(1,'','monto_letra','Monto a Viaticar en Letra',0,1,2,4,33,'SIMPLE',0,NULL),(1,'','monto_letra','Monto a Viaticar en Letra',0,1,3,4,33,'SIMPLE',0,NULL),(1,'','monto_sin_pernocta','Monto',0,1,1,4,27,'SIMPLE',1,'muestraMontoSP'),(1,'','monto_sin_pernocta','Monto',0,1,2,4,27,'SIMPLE',1,'muestraMontoSP'),(1,'','monto_sin_pernocta','Monto',0,1,3,4,27,'SIMPLE',1,'muestraMontoSP'),(1,'','nacionalidad','Nacionalidad',0,1,3,6,9,'SIMPLE',0,NULL),(1,'','nivel_homologacion','Nivel Homologación',0,1,1,4,21,'SIMPLE',1,'nivelHomolagacion'),(1,'','nivel_homologacion','Nivel Homologación',0,1,2,4,21,'SIMPLE',1,'nivelHomolagacion'),(1,'','nivel_homologacion','Nivel Homologación',0,1,3,4,21,'SIMPLE',1,'nivelHomolagacion'),(1,'','nombre_evento','Evento ',0,1,1,1,NULL,NULL,NULL,NULL),(1,'','nombre_evento','Nombre del evento',0,1,2,1,NULL,NULL,NULL,NULL),(1,'','nombre_evento','Nombre del evento',0,1,3,1,NULL,NULL,NULL,NULL),(1,'','num_acuerdo','Número de Acuerdo',0,1,1,6,9,'SIMPLE',0,NULL),(1,'','num_acuerdo','Número de Acuerdo',0,1,2,6,9,'SIMPLE',0,NULL),(1,'','num_dias_con_pernocta','Num. Días Con Pernocta',0,1,1,4,29,'SIMPLE',0,'calculaMontoCP'),(1,'','num_dias_con_pernocta','Num. Días Con Pernocta',0,1,2,4,29,'SIMPLE',0,'calculaMontoCP'),(1,'','num_dias_con_pernocta','Num. Días Con Pernocta',0,1,3,4,29,'SIMPLE',0,'calculaMontoCP'),(1,'','num_dias_sin_pernocta','Num. Días Sin Pernocta',0,1,1,4,26,'SIMPLE',0,'calculaMontoSP'),(1,'','num_dias_sin_pernocta','Num. Días Sin Pernocta',0,1,2,4,26,'SIMPLE',0,'calculaMontoSP'),(1,'','num_dias_sin_pernocta','Num. Días Sin Pernocta',0,1,3,4,26,'SIMPLE',0,'calculaMontoSP'),(1,'','organizador','Organizador',0,0,1,2,11,'AREA',0,NULL),(1,'','organizador','Organizador',0,0,2,2,11,'AREA',0,NULL),(1,'','organizador','Organizador',0,0,3,2,11,'AREA',0,NULL),(1,'','pais_destino','País',0,1,1,2,13,'SIMPLE',0,NULL),(1,'','pais_destino','País',0,1,2,2,13,'SIMPLE',0,NULL),(1,'','pais_destino','País',0,1,3,2,13,'SIMPLE',0,NULL),(1,'','tarifa_con_pernocta','Tarifa Con Pernocta',1,1,1,4,28,'SIMPLE',1,'muestraTarifaCP'),(1,'','tarifa_con_pernocta','Tarifa Con Pernocta',1,1,2,4,28,'SIMPLE',1,'muestraTarifaCP'),(1,'','tarifa_con_pernocta','Tarifa Con Pernocta',1,1,3,4,28,'SIMPLE',1,'muestraTarifaCP'),(1,'','tarifa_correspondiente','Tarifa Correspondiente',0,1,1,4,31,'SIMPLE',1,'calculaTarifa'),(1,'','tarifa_correspondiente','Tarifa Correspondiente',0,1,2,4,31,'SIMPLE',1,'calculaTarifa'),(1,'','tarifa_correspondiente','Tarifa Correspondiente',0,1,3,4,31,'SIMPLE',1,'calculaTarifa'),(1,'','tarifa_sin_pernocta','Tarifa Sin Pernocta',1,1,1,4,25,'SIMPLE',1,'muestraTarifaSP'),(1,'','tarifa_sin_pernocta','Tarifa Sin Pernocta',1,1,2,4,25,'SIMPLE',1,'muestraTarifaSP'),(1,'','tarifa_sin_pernocta','Tarifa Sin Pernocta',1,1,3,4,25,'SIMPLE',1,'muestraTarifaSP'),(1,'','tipo_invitado','Tipo de Invitado',1,1,3,6,8,NULL,0,NULL),(1,'','tipo_pago','Tipo de Pago',1,1,1,4,24,NULL,0,NULL),(1,'','tipo_pago','Tipo de Pago',1,1,2,4,24,NULL,0,NULL),(1,'','tipo_pago','Tipo de Pago',1,1,3,4,24,NULL,0,NULL),(1,'','tipo_representacion','Tipo de Representacion',1,1,1,6,8,NULL,0,'tipoRepresentacion'),(1,'','tipo_representacion','Tipo de Representacion',1,1,2,6,8,NULL,0,'tipoRepresentacion'),(1,'','tipo_viaje','Tipo de viaje',0,1,1,1,NULL,NULL,NULL,NULL),(1,'','tipo_viaje','Tipo de Viaje',1,1,2,6,7,NULL,0,'tipoViaje'),(1,'','tipo_viaje','Tipo de Viaje',1,1,3,6,7,NULL,0,'tipoViaje'),(1,'','tipo_zona','Tipo de Zona',1,1,1,4,23,NULL,0,'tipoZona'),(1,'','tipo_zona','Tipo de Zona',1,1,2,4,23,NULL,0,'tipoZona'),(1,'','tipo_zona','Tipo de Zona',1,1,3,4,23,NULL,0,'tipoZona'),(1,'','vinculo_internet','Vínculo de Internet',0,0,1,2,12,'AREA',0,NULL),(1,'','vinculo_internet','Vínculo de Internet',0,0,2,2,12,'AREA',0,NULL),(1,'','vinculo_internet','Vínculo de Internet',0,0,3,2,12,'AREA',0,NULL),(1,'personas','apellido_materno','Apellido Materno',0,1,1,1,5,'SIMPLE',1,NULL),(1,'personas','apellido_materno','Apellido Materno',0,1,2,1,5,'SIMPLE',1,NULL),(1,'personas','apellido_materno','Apellido Materno',0,1,3,1,5,'SIMPLE',1,NULL),(1,'personas','apellido_paterno','Apellido Paterno',0,1,1,1,4,'SIMPLE',1,NULL),(1,'personas','apellido_paterno','Apellido Paterno',0,1,2,1,4,'SIMPLE',1,NULL),(1,'personas','apellido_paterno','Apellido Paterno',0,1,3,1,4,'SIMPLE',1,NULL),(1,'personas','cargo','Cargo',0,1,1,1,6,'SIMPLE',1,NULL),(1,'personas','cargo','Cargo',0,1,2,1,6,'SIMPLE',1,NULL),(1,'personas','cargo','Cargo',0,1,3,1,6,'SIMPLE',1,NULL),(1,'personas','nombres','Nombre',0,1,1,1,3,'SIMPLE',1,NULL),(1,'personas','nombres','Nombre',0,1,2,1,3,'SIMPLE',1,NULL),(1,'personas','nombres','Nombre',0,1,3,1,3,'SIMPLE',1,NULL),(2,'','aerolinea_ida','AEROLINEA_IDA',1,1,1,1,NULL,NULL,NULL,NULL),(2,'','aerolinea_ida','Aerolínea de ida',0,1,2,1,NULL,NULL,NULL,NULL),(2,'','aerolinea_ida','Aerolínea de ida',0,1,3,1,NULL,NULL,NULL,NULL),(2,'','aerolinea_regreso','Aerolínea de regreso',0,1,2,1,NULL,NULL,NULL,NULL),(2,'','nombre_evento','Nombre del evento',0,1,1,3,NULL,NULL,NULL,NULL),(3,'','aerolinea_ida','Aerolínea de ida',0,1,1,10,NULL,NULL,NULL,NULL),(3,'','costo_total_hospedaje','Costo total del hospedaje',0,1,1,1,NULL,NULL,NULL,NULL),(4,'','fecha_hora_regreso','Fecha de regreso',0,0,1,1,NULL,NULL,NULL,NULL),(4,'','fecha_hora_salida','Fecha de salida',0,0,1,1,NULL,NULL,NULL,NULL),(4,'','informe_contribucion','Contribución',0,1,1,1,NULL,NULL,NULL,NULL),(4,'','informe_resultados','Resultados',0,1,1,1,NULL,NULL,NULL,NULL),(4,'','url_evento','URL Evento',0,0,1,1,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `flujos_campos_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flujos_instancias`
--

DROP TABLE IF EXISTS `flujos_instancias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE  TABLE IF NOT EXISTS `viajes_claros`.`flujos_instancias` (
  `id_instancia` BIGINT NOT NULL ,
  `id_flujo` INT NOT NULL ,
  `id_comision` INT NOT NULL ,
  `fecha_inicio` DATETIME NULL ,
  `fecha_fin` DATETIME NULL ,
  `asignado` TINYINT(1) NULL ,
  PRIMARY KEY (`id_instancia`, `id_flujo`, `id_comision`) ,
  INDEX `fk_flujos_instancias_flujos_trabajo1_idx` (`id_flujo` ASC) ,
  INDEX `fk_flujos_instancias_comisiones1_idx` (`id_comision` ASC) ,
  CONSTRAINT `fk_flujos_instancias_flujos_trabajo1`
    FOREIGN KEY (`id_flujo` )
    REFERENCES `viajes_claros`.`flujos_trabajo` (`id_flujo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flujos_instancias_comisiones1`
    FOREIGN KEY (`id_comision` )
    REFERENCES `viajes_claros`.`comisiones` (`id_comision` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flujos_instancias`
--

LOCK TABLES `flujos_instancias` WRITE;
/*!40000 ALTER TABLE `flujos_instancias` DISABLE KEYS */;
/*!40000 ALTER TABLE `flujos_instancias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aprobaciones_bitacora`
--

DROP TABLE IF EXISTS `aprobaciones_bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE  TABLE IF NOT EXISTS `viajes_claros`.`aprobaciones_bitacora` (
  `id_instancia` BIGINT NOT NULL ,
  `id_flujo` INT NOT NULL ,
  `id_comision` INT NOT NULL ,
  `id_funcionario` INT NOT NULL ,
  `respuesta` VARCHAR(100) NOT NULL ,
  `fecha_evento` DATETIME NOT NULL ,
  PRIMARY KEY (`id_instancia`, `id_flujo`, `id_comision`, `id_funcionario`) ,
  INDEX `fk_aprobaciones_bitacora_funcionarios1_idx` (`id_funcionario` ASC) ,
  INDEX `fk_aprobaciones_bitacora_flujos_instancias1_idx` (`id_instancia` ASC, `id_flujo` ASC, `id_comision` ASC) ,
  CONSTRAINT `fk_aprobaciones_bitacora_funcionarios1`
    FOREIGN KEY (`id_funcionario` )
    REFERENCES `viajes_claros`.`personas` (`id_persona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aprobaciones_bitacora_flujos_instancias1`
    FOREIGN KEY (`id_instancia` , `id_flujo` , `id_comision` )
    REFERENCES `viajes_claros`.`flujos_instancias` (`id_instancia` , `id_flujo` , `id_comision` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aprobaciones_bitacora`
--

LOCK TABLES `aprobaciones_bitacora` WRITE;
/*!40000 ALTER TABLE `aprobaciones_bitacora` DISABLE KEYS */;
/*!40000 ALTER TABLE `aprobaciones_bitacora` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `graficas`
--

LOCK TABLES `graficas` WRITE;
/*!40000 ALTER TABLE `graficas` DISABLE KEYS */;
-- INSERT INTO `graficas` VALUES ('total_viaticos','Total de viáticos gastados',1),('hoteles_mas','Hoteles más visitados',2),('viajes_tipo','Viajes nacionales e internacionales',3),('viajes_transporte','Viajes por tipo',4),('viajes_por_mes','Viajes por mes',5),('ciudades_internacionales','Ciudades internacionales más visitadas',6),('aerolineas','Aerolíneas más usadas',7),('viajes_por_unidad','Viajes por Unidad Administrativa',8);
/*!40000 ALTER TABLE `graficas` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `graficas_config`
--

LOCK TABLES `graficas_config` WRITE;
/*!40000 ALTER TABLE `graficas_config` DISABLE KEYS */;
-- INSERT INTO `graficas_config` VALUES (1,1),(2,1),(3,1),(1,2),(2,2),(3,2),(1,3),(2,3),(3,3),(1,4),(2,4),(1,5),(2,5),(1,6),(1,7),(2,7),(1,8);
/*!40000 ALTER TABLE `graficas_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interfaz_config`
--

DROP TABLE IF EXISTS `interfaz_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interfaz_config` (
  `id_dependencia` INT NOT NULL ,
  `tabla` VARCHAR(50) NULL ,
  `campo` VARCHAR(50) NOT NULL ,
  `lista_habilitada` TINYINT(1) NOT NULL ,
  `etiqueta` VARCHAR(30) NULL ,
  `secuencia` INT NOT NULL ,
  `editable` TINYINT(1) NULL ,
  PRIMARY KEY (`id_dependencia`, `tabla`, `campo`) ,
  INDEX `fk_interfaz_config_dependencias1_idx` (`id_dependencia` ASC) ,
  CONSTRAINT `fk_interfaz_config_dependencias1`
    FOREIGN KEY (`id_dependencia` )
    REFERENCES `viajes_claros`.`dependencias` (`id_dependencia` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interfaz_config`
--

LOCK TABLES `interfaz_config` WRITE;
/*!40000 ALTER TABLE `interfaz_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `interfaz_config` ENABLE KEYS */;
UNLOCK TABLES;
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
-- Dumping data for table `sesiones_login`
--

LOCK TABLES `sesiones_login` WRITE;
/*!40000 ALTER TABLE `sesiones_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `sesiones_login` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `smtp_config`
--

LOCK TABLES `smtp_config` WRITE;
/*!40000 ALTER TABLE `smtp_config` DISABLE KEYS */;
-- INSERT INTO `smtp_config` VALUES (1,'smtp.gmail.com','465','INAIViajesClaros@gmail.com','INAIAdmin2016');
INSERT INTO `smtp_config` VALUES (1,'mail.ifai.org.mx','25','','');
/*!40000 ALTER TABLE `smtp_config` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `suscripcion_config`
--

LOCK TABLES `suscripcion_config` WRITE;
/*!40000 ALTER TABLE `suscripcion_config` DISABLE KEYS */;
-- INSERT INTO `suscripcion_config` VALUES (1,'aerolinea_ida'),(2,'aerolinea_ida'),(1,'aerolinea_regreso'),(2,'aerolinea_regreso'),(1,'antecedentes_comision'),(1,'cargo_funcionario'),(1,'ciudad_destino'),(2,'ciudad_destino'),(1,'ciudad_origen'),(2,'ciudad_origen'),(1,'costo_total'),(1,'costo_total_hospedaje'),(1,'costo_viaticos'),(1,'fecha_hora_regreso'),(1,'fecha_hora_salida'),(1,'informe_contribucion'),(1,'informe_resultados'),(1,'motivo_comision'),(1,'nombre_evento'),(2,'nombre_evento'),(1,'nombre_hotel'),(1,'pais_destino'),(1,'pais_origen'),(1,'tipo_pasaje'),(2,'tipo_pasaje'),(1,'tipo_viaje'),(1,'unidad_administrativa'),(1,'url_evento'),(1,'viaticos_comprobados'),(1,'viaticos_devueltos'),(1,'viaticos_sin_comprobar');
/*!40000 ALTER TABLE `suscripcion_config` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `suscripcion_email_config`
--

LOCK TABLES `suscripcion_email_config` WRITE;
/*!40000 ALTER TABLE `suscripcion_email_config` DISABLE KEYS */;
-- INSERT INTO `suscripcion_email_config` VALUES (0,'s.alejandro.l@gmail.com','María Adriana','Báez','Ricárdez'),(0,'s.alejandro.l@gmail.com','Sandra Mariana','Miramontes',''),(1,'abc','','',''),(1,'s.alejandro.l@gmail.com','','',''),(1,'xyz','','',''),(2,'','','',''),(2,'asd','','',''),(2,'email@no-spam.com','','',''),(3,'s_alejandro_l@hotmail.com','Pedro','López','');
/*!40000 ALTER TABLE `suscripcion_email_config` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `valores_dinamicos`
--

LOCK TABLES `valores_dinamicos` WRITE;
/*!40000 ALTER TABLE `valores_dinamicos` DISABLE KEYS */;
-- INSERT INTO `valores_dinamicos` VALUES (2,'ANT','Anticipados'),(2,'DEV','Devengados'),(3,'<=','<='),(3,'=','='),(3,'>=','>='),(4,'001','Primera clase'),(11,'3s','Tres estrellas'),(11,'4s','Cuatro estrellas'),(11,'5s','Cinco estrellas'),(13,'001','Plus'),(14,'INT','Internacional'),(14,'NAC','Nacional'),(15,'AER','Aéreo'),(15,'TER','Terrestre'),(16,'MAG','Magna'),(16,'PRE','Premium'),(17,'ABO','Abogacía'),(17,'COM','Comisiones'),(17,'FIN','Finanzas'),(18,'AN','Alto Nivel'),(18,'TEC','Técnico'),(19,'EXT','Extranjero'),(19,'NAC','Nacional'),(20,'MASEC','Más Económica'),(20,'MENEC','Menos Económica'),(21,'ANT','Anticipado'),(21,'DEV','Devengados'),(21,'NA','No Aplica'),(22,'NO','No'),(22,'SI','Sí'),(23,'EUR','EUR'),(23,'MXN','MXN'),(23,'USD','USD'),(24,'CP,AN,NO,MASEC','1850'),(24,'CP,AN,NO,MENEC','3600'),(24,'CP,TEC,NO,MASEC','1494'),(24,'CP,TEC,NO,MENEC','2032'),(24,'CP,TEC,SI,MASEC','1850'),(24,'CP,TEC,SI,MENEC','3600'),(24,'SP,INT','225'),(25,'CP,INT','450'),(25,'SP,AN,NO,MASEC','925'),(25,'SP,AN,NO,MENEC','925'),(25,'SP,TEC,NO,MASEC','747'),(25,'SP,TEC,NO,MENEC','747'),(25,'SP,TEC,SI,MASEC','925'),(25,'SP,TEC,SI,MENEC','925');
/*!40000 ALTER TABLE `valores_dinamicos` ENABLE KEYS */;
UNLOCK TABLES;

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
  CONSTRAINT `fk_viajes_claros_detalle_viajes_claros_config1` FOREIGN KEY (`tabla`, `campo`) REFERENCES `viajes_claros_config` (`tabla`, `campo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_viajes_claros_detalle_viajes_claros_instancias1` FOREIGN KEY (`id_viaje`) REFERENCES `viajes_claros_instancias` (`id_viaje`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viajes_claros_detalle`
--

LOCK TABLES `viajes_claros_detalle` WRITE;
/*!40000 ALTER TABLE `viajes_claros_detalle` DISABLE KEYS */;
INSERT INTO `viajes_claros_detalle` VALUES (1,'','aerolinea_ida','Aeroméxico',NULL,NULL),(1,'','aerolinea_regreso','Aeromar',NULL,NULL),(1,'','ciudad_destino','Manchester',NULL,NULL),(1,'','ciudad_origen','Ciudad de México',NULL,NULL),(1,'','costo_total',NULL,50272.46,NULL),(1,'','costo_total_hospedaje',NULL,19710.9,NULL),(1,'','costo_viaticos',NULL,20000,NULL),(1,'','fecha_hora_regreso',NULL,NULL,'2015-04-04 00:00:00'),(1,'','fecha_hora_salida',NULL,NULL,'2015-03-30 00:00:00'),(1,'','informe_contribucion','Fue posible allegarse de conocimiento y experiencias de otras autoridades de privacidad y protección de datos.',NULL,NULL),(1,'','informe_resultados','Se conocieron los avances que ha desarrollado la comisionada, como normatividad secundaria en materia de protección de datos personales en posesión del sector privado y las acciones que el IFAI ha emprendido en el cumplimiento de la Ley.',NULL,NULL),(1,'','motivo_comision','Asistir al tercer evento anual del \"International Enforcement Coordination Working Group\" (IECWG), organizado por la autoridad de información y privacidad del Reino Unido (Information Commissioner\'s Office, ICO, por sus siglas en inglés), los días 1, 2 y 3 de abril de 2014.',NULL,NULL),(1,'','nombre_evento','International Enforcement Coordination Working Group (IECWG)',NULL,NULL),(1,'','nombre_hotel','Hilton',NULL,NULL),(1,'','pais_destino','Reino Unido',NULL,NULL),(1,'','pais_origen','México',NULL,NULL),(1,'','tipo_pasaje','Aéreo',NULL,NULL),(1,'','tipo_viaje','Internacional',NULL,NULL),(1,'','unidad_administrativa','Finanzas',NULL,NULL),(1,'personas','apellido_paterno','López',NULL,NULL),(1,'personas','fecha_ingreso','',NULL,'2014-11-30 18:00:00'),(1,'personas','nombres','Pedro',NULL,NULL),(4,'','aerolinea_ida','Aeroméxico',NULL,NULL),(4,'','aerolinea_regreso','Aeroméxico',NULL,NULL),(4,'','ciudad_destino','Chetumal',NULL,NULL),(4,'','costo_total',NULL,3237.95,NULL),(4,'','costo_total_hospedaje',NULL,1710,NULL),(4,'','costo_viaticos',NULL,20000,NULL),(4,'','fecha_hora_regreso',NULL,NULL,'2015-07-13 18:00:00'),(4,'','fecha_hora_salida',NULL,NULL,'2015-07-12 18:00:00'),(4,'','informe_contribucion','Fomentar y contribuir a garantizar el derecho a la protección de datos personales a través de la vigilancia del mismo y la presencia del Instituto en el territorio nacional.',NULL,NULL),(4,'','informe_resultados','Se efectuaron las diligencias de notificación de los oficios de requerimiento de información con número IFAI/SPSP/DGV/1027/2014 e IFAI/SPDP/DGV/1028/2014, emitidos dentro de los expedientes IFAI.3s.02.02-105/2014 e IFAI.3S.02-131/2014, iniciados en contra de Pueblo Bonito Ocean Front Resorts and Spas e Instituto Internacional ',NULL,NULL),(4,'','motivo_comision','Llevar a cabo la Notificación de los oficios IFAI/SPSP/DGV/1027/2014 e IFAI/SPDP/DGV/1028/2014, correspondientes a los requerimientos de información emitidos dentro de los expedientes IFAI.3s.02.02-105/2014 e IFAI.3S.02-131/2014, iniciados contra el Pueblo Bonito Ocean Front Resorts and Spas e Instituto Internacional Libertad, A.C., respectivamente',NULL,NULL),(4,'','nombre_evento','Notificación - 12/jul/15 - Baja California Sur',NULL,NULL),(4,'','nombre_hotel','Fiesta Inn',NULL,NULL),(4,'','pais_destino','México',NULL,NULL),(4,'','tipo_pasaje','Aéreo',NULL,NULL),(4,'','tipo_viaje','Nacional',NULL,NULL),(4,'','unidad_administrativa','Finanzas',NULL,NULL),(4,'','viaticos_comprobados',NULL,10000,NULL),(4,'','viaticos_devueltos',NULL,8000,NULL),(4,'','viaticos_sin_comprobar',NULL,2000,NULL),(4,'personas','apellido_paterno','Puente',NULL,NULL),(4,'personas','nombres','Ximena',NULL,NULL),(5,'','aerolinea_ida','Aeroméxico',NULL,NULL),(5,'','aerolinea_regreso','Aeroméxico',NULL,NULL),(5,'','ciudad_destino','Buenos Aires',NULL,NULL),(5,'','costo_total',NULL,90411,NULL),(5,'','costo_total_hospedaje',NULL,23829.6,NULL),(5,'','costo_viaticos',NULL,20000,NULL),(5,'','fecha_hora_regreso',NULL,NULL,'2015-10-19 00:00:00'),(5,'','fecha_hora_salida',NULL,NULL,'2015-10-09 00:00:00'),(5,'','informe_contribucion','La participación del IFAI en la conferencia internacional reitera el compromiso del Instituto de garantizar el cumplimiento del derecho fundamental de protección de datos. Las ponencias de la sesión abierta, sobre temas de actualidad, permiten conocer los mecanismos novedosos que han diseñado los países para enfrentar los retos que el desarrollo de las tecnologías impone a los derechos de privacidad y protección de datos. En el caso de los talleres y seminarios organizados por los diferentes Grupos de Trabajo y organizaciones, el IFAI está especialmente interesado en los resultados de las investigaciones que estos actores llevan a cabo con el objetivo de fortalecer sus herramientas internas para cumplir con su misión como organismo constitucional autónomo, particularmente aquellas de difusión y educación. En el caso particular de la reunión del Grupo de Trabajo para la Cooperación Internacional para Hacer Cumplir la Ley, conviene destacar la aprobación del Global Cross Border Enforcement Cooperation Arrangement. Las autoridades que deseen participar en dicho Acuerdo, deberán manifestarlo durante la 37° edición de la Conferencia Internacional, la cual tendrá lugar en Amsterdam en 2015. En la sesión cerrada, presentamos los avances del Instituto en materia de protección de datos, haciendo énfasis en sus nuevas atribuciones como organismo constitucional autónomo y en las ventajas que éstas representan para la construcción de una sociedad mexicana transparente, abierta y democrát',NULL,NULL),(5,'','informe_resultados','Vinculación a nivel internacional en temas de protección de datos',NULL,NULL),(5,'','motivo_comision','La Conferencia tendrá sesiones abiertas y cerradas, estas últimas sólo para Autoridades garantes de Protección de Datos. En la sesión cerrada, que se celebrará el 13 y 14 de octubre, se presentarán reportes de avances en materia de protección de datos. En ésta, el IFAI informará respecto a los desarrollos en México derivados de la reforma constitucional en materia de transparencia. Asimismo, el Grupo de Trabajo de Coordinación Internacional para el Cumplimiento (IECWG), en el cual participa el IFAI, presentará el Acuerdo de Cooperación Transfronteriza en materia de Cumplimiento. Finalmente, se presentarán y votarán tres resoluciones sobre Big Data; Privacidad en la era digital; y cooperación internacional en materia de cumplimiento. En la sesión abierta, (15 y 16 de octubre) se llevarán a cabo tres reuniones plenarias y 12 paneles. Los temas de las sesiones previstas son la protección de datos en el mundo en desarrollo; el hacer y el deber hacer de los reguladores para una protección efectiva de la privacidad; Proyecto Marco de Riesgos de la Privacidad; Privacidad en la era digital, la resolución de Naciones Unidas, y E-salud y la protección de datos, entre otras.',NULL,NULL),(5,'','nombre_evento','36 Conferencia Internacional de Autoridades de Protección de Datos y Privacidad',NULL,NULL),(5,'','nombre_hotel','Hotel Invoice',NULL,NULL),(5,'','pais_destino','Argentina',NULL,NULL),(5,'','tipo_pasaje','Aéreo',NULL,NULL),(5,'','tipo_viaje','Internacional',NULL,NULL),(5,'','unidad_administrativa','Finanzas',NULL,NULL),(5,'','viaticos_comprobados',NULL,19000,NULL),(5,'','viaticos_devueltos',NULL,0,NULL),(5,'','viaticos_sin_comprobar',NULL,1000,NULL),(5,'personas','apellido_paterno','Alcalá',NULL,NULL),(5,'personas','nombres','Adrián',NULL,NULL),(6,'','aerolinea_ida','LAN',NULL,NULL),(6,'','aerolinea_regreso','LAN',NULL,NULL),(6,'','antecedentes_comision','La participación del IFAI en la primera edición de este Congreso Internacional en el 2013 y la estrecha vinculación que existe entre la Subsecretaría de Asuntos públicos del Gobierno de la Ciudad de Buenos Aires, Argentina y el Instituto.',NULL,NULL),(6,'','cargo_funcionario','Coordinador de Acceso a la Información',NULL,NULL),(6,'','ciudad_destino','Buenos Aires',NULL,NULL),(6,'','ciudad_origen','Ciudad de México',NULL,NULL),(6,'','costo_total',NULL,49739.22,NULL),(6,'','costo_total_hospedaje',NULL,11854.52,NULL),(6,'','costo_viaticos',NULL,20000,NULL),(6,'','fecha_hora_regreso',NULL,NULL,'2015-10-04 00:00:00'),(6,'','fecha_hora_salida',NULL,NULL,'2015-09-01 00:00:00'),(6,'','informe_contribucion','Se logró la interlocución con diferentes funcionarios encargados de la Transparencia y Acceso a la información en 11 países latinoamericanos, una fundación Internacional y un organismo Internacional.',NULL,NULL),(6,'','informe_resultados','Se propuso que la Dirección General de Asuntos Internacionales realice un plan de trabajo que tenga como fin desarrollar una agenda en conjunto con los miembros de la Red, en virtud de coadyuvar en temas que beneficien al Instituto en todo lo concerniente al acceso a la información.',NULL,NULL),(6,'','motivo_comision','Generar debate y reflexión sobre temas de anticorrupción, transparencia, acceso a la información y gobierno abierto, así como anunciar el lanzamiento del sitio de transparencia del gobierno de la Ciudad de Buenos Aires.',NULL,NULL),(6,'','nombre_evento','II Congreso Internacional de Transparencia',NULL,NULL),(6,'','nombre_hotel','Hotel Invoice',NULL,NULL),(6,'','pais_destino','Argentina',NULL,NULL),(6,'','tipo_viaje','Internacional',NULL,NULL),(6,'','unidad_administrativa','Finanzas',NULL,NULL),(6,'','url_evento','http://www.buenosaires.gob.ar/asuntos-publicos/congreso-de-la-transparencia',NULL,NULL),(6,'','viaticos_comprobados',NULL,1000,NULL),(6,'','viaticos_devueltos',NULL,18000,NULL),(6,'','viaticos_sin_comprobar',NULL,1000,NULL),(6,'personas','apellido_paterno','Ramírez',NULL,NULL),(6,'personas','nombres','José de Jesús',NULL,NULL),(7,'','aerolinea_ida','Interjet',NULL,NULL),(7,'','aerolinea_regreso','Interjet',NULL,NULL),(7,'','ciudad_destino','Chetumal',NULL,NULL),(7,'','ciudad_origen','Ciudad de México',NULL,NULL),(7,'','costo_total',NULL,6014,NULL),(7,'','costo_total_hospedaje',NULL,1276,NULL),(7,'','costo_viaticos',NULL,20000,NULL),(7,'','fecha_hora_regreso',NULL,NULL,'2015-07-04 00:00:00'),(7,'','fecha_hora_salida',NULL,NULL,'2015-07-04 00:00:00'),(7,'','informe_contribucion','Se analizaron los cambios en materia de atribuciones para el Instituto y los locales ya que a partir de las reformase vuelven sujetos obligados',NULL,NULL),(7,'','informe_resultados','Se presentaron temas en las diversas propuestas hechas al Congreso de la unión en materia legislativa los datos personales otro tópicos importantes para la construcción del Sistema Nacional de Transparencia',NULL,NULL),(7,'','motivo_comision','Sentar las bases para estandarizar los marcos regulatorios en la materia y homogenizar el ejercicio de los derechos de acceso a la información y la protección de datos personales, a partir de marcos regulatorios estandarizados que garanticen el ejercicio homogéneo de estos derechos en todo el país',NULL,NULL),(7,'','nombre_evento','XV Asamblea Nacional Ordinaria de la COMAIP - Quintana Roo 2014',NULL,NULL),(7,'','nombre_hotel','Fiesta Inn',NULL,NULL),(7,'','pais_destino','México',NULL,NULL),(7,'','pais_origen','México',NULL,NULL),(7,'','tipo_pasaje','Aéreo',NULL,NULL),(7,'','tipo_viaje','Nacional',NULL,NULL),(7,'','unidad_administrativa','Finanzas',NULL,NULL),(7,'','viaticos_comprobados',NULL,11000,NULL),(7,'','viaticos_devueltos',NULL,9000,NULL),(7,'','viaticos_sin_comprobar',NULL,0,NULL),(7,'personas','apellido_paterno','Parra',NULL,NULL),(7,'personas','nombres','Luis Gustavo',NULL,NULL),(8,'','aerolinea_ida','Volaris',NULL,NULL),(8,'','aerolinea_regreso','Volaris',NULL,NULL),(8,'','ciudad_destino','San Miguel de Allende',NULL,NULL),(8,'','ciudad_origen','Ciudad de México',NULL,NULL),(8,'','costo_total',NULL,1925.99,NULL),(8,'','costo_total_hospedaje',NULL,2266.95,NULL),(8,'','costo_viaticos',NULL,20000,NULL),(8,'','fecha_hora_regreso',NULL,NULL,'2014-09-05 18:00:00'),(8,'','fecha_hora_salida',NULL,NULL,'2014-09-05 00:00:00'),(8,'','informe_contribucion','Señalar las problemáticas actuales que enfrenta el ejercicio y tutela del derecho a la protección de datos personales en el sector público; generar consciencia sobre la importancia e impacto de los datos personales en el sector público federal',NULL,NULL),(8,'','informe_resultados','Se impartió la conferencia \"La transformación del IFAI\"',NULL,NULL),(8,'','motivo_comision','Exponer el proceso de transformación del IFAI a la luz de las reformas constitucionales y los retos de los nuevos sujetos obligados',NULL,NULL),(8,'','nombre_evento','Transparencia; Acceso a la Información y Protección de Datos en el Sector Ambiental',NULL,NULL),(8,'','nombre_hotel','Fiesta Inn',NULL,NULL),(8,'','pais_destino','México',NULL,NULL),(8,'','pais_origen','México',NULL,NULL),(8,'','tipo_pasaje','Terrestre',NULL,NULL),(8,'','tipo_viaje','Nacional',NULL,NULL),(8,'','unidad_administrativa','Finanzas',NULL,NULL),(8,'personas','apellido_paterno','Fernández',NULL,NULL),(8,'personas','nombres','Eduardo Felipe',NULL,NULL),(9,'','ciudad_destino','Toluca',NULL,NULL),(9,'','ciudad_origen','Ciudad de México',NULL,NULL),(9,'','costo_total',NULL,935.5,NULL),(9,'','costo_viaticos',NULL,20000,NULL),(9,'','fecha_hora_regreso',NULL,NULL,'2015-05-19 18:00:00'),(9,'','fecha_hora_salida',NULL,NULL,'2015-05-19 18:00:00'),(9,'','informe_contribucion','Promover la cultura de la transparencia en la gestión pública y la rendición de cuentas del gobierno a la sociedad  así como el ejercicio de los derechos de los gobernados en materia de Acceso a la Información y Protección de Datos Personales',NULL,NULL),(9,'','informe_resultados','Difundir el quehacer institucional del IFAI mediante la inserción de materiales informativos en la página institucional para dar a conocer a la sociedad en general y los distintos medios de comunicación las actividades que lleva a cabo el Instituto en materia de acceso a la información y protección de datos personales Con esta acción se logró mantener una presencia constante en los medios de comunicación',NULL,NULL),(9,'','motivo_comision','Promover la presencia del Instituto en los medios de comunicación informando con claridad y precisión a la sociedad en general de las actividades que realiza el Instituto',NULL,NULL),(9,'','nombre_evento','XVIII Sesión Ordinaria de la Región Centro de la Conferencia Mexicana para el Acceso a la Información Pública',NULL,NULL),(9,'','nombre_hotel','Hoteles Posada Real',NULL,NULL),(9,'','pais_destino','México',NULL,NULL),(9,'','pais_origen','México',NULL,NULL),(9,'','tipo_pasaje','Terrestre',NULL,NULL),(9,'','tipo_viaje','Nacional',NULL,NULL),(9,'','unidad_administrativa','Finanzas',NULL,NULL),(9,'personas','apellido_paterno','Sánchez',NULL,NULL),(9,'personas','nombres','Tania',NULL,NULL),(10,'','antecedentes_comision','El  VII Encuentro de la RTA donde el IFAI preside los trabajos de la RTA por lo que su participación en el encuentro indispensable para dar continuidad a los compromisos establecidos en el VI Encuetnro celebrado en México del 01 de octubre de 2013',NULL,NULL),(10,'','ciudad_destino','Santiago',NULL,NULL),(10,'','ciudad_origen','Ciudad de México',NULL,NULL),(10,'','costo_total',NULL,38414.74,NULL),(10,'','costo_total_hospedaje',NULL,12019.12,NULL),(10,'','costo_viaticos',NULL,20000,NULL),(10,'','fecha_hora_regreso',NULL,NULL,'2015-04-24 00:00:00'),(10,'','fecha_hora_salida',NULL,NULL,'2015-04-21 00:00:00'),(10,'','informe_contribucion','La participación del IFAI en ambos eventos contribuye a reafirmar el liderazgo del IFAI en materia de acceso a  la información en la región latinoamericana; refrendo del compromiso y liderazgo del IFAI frente a la RTA como una contraparte interesada en el fortalecimiento de las capacidades de sus contrapartes regionales',NULL,NULL),(10,'','informe_resultados','Generar una reunión virtual del Consejo Directivo; Trabajar en la definición de la agenda del siguiente encuentro; elaborar propuesta de creación de mecanismo para ampliar el diálogo con la sociedad civil y los expertos; proponer un consejo consultivo en la Red; traducir al español los documentos que el IFAI ha generado en el marco del Grupo de Trabajo de Acceso a la Información de AGA; dar seguimiento al desarrollo de los proyectos de indicadores y de archivos; hacer una revisión acuciosa de los Informes para identificar información relevante para los miembros de la RTA; así como posibilidades de colaboración con la OEA',NULL,NULL),(10,'','motivo_comision','VII Encuentro de la RTA (22 de abril). - El IFAI preside los trabajos de la RTA, por lo que su participación en el Encuentro es indispensable para dar continuidad a los compromisos establecidos en el VI Encuentro, celebrado en México el 01 de octubre de 2013 - El IFAI en su calidad de Presidencia y el Consejo para la Transparencia, representando a la Secretaría Ejecutiva, presentarán una propuesta de Agenda de Cooperación Internacional y se anunciarán dos proyectos de cooperación, sobre los temas de archivos e indicadores, que serán ejecutados con apoyo de la Unión Europea.y se instalará el Consejo Directivo de la Red. V Seminario Internacional de Transparencia, “LIBERTAD DE EXPRESIÓN y transparencia” (23 y 24 de abril). - La participación del IFAI en ambos eventos contribuye a reafirmar el liderazgo del IFAI en materia de acceso a la información en la región latinoamericana - Se esperan mayores detalles sobre la participación de los funcionarios del IFAI en la agenda del Seminario',NULL,NULL),(10,'','nombre_evento','Seminario Internacional de Transparencia 2014 “Libertad de Expresión y Transparencia”',NULL,NULL),(10,'','nombre_hotel','Crowne Plaza',NULL,NULL),(10,'','pais_destino','Chile',NULL,NULL),(10,'','pais_origen','México',NULL,NULL),(10,'','tipo_pasaje','Aéreo',NULL,NULL),(10,'','tipo_viaje','Internacional',NULL,NULL),(10,'','unidad_administrativa','Finanzas',NULL,NULL),(10,'','url_evento','http://www.consejotransparencia.cl/v-seminario-internacional-de-transparencia/consejo/2014-03-31/163811.html',NULL,NULL),(10,'personas','apellido_paterno','Vásquez',NULL,NULL),(10,'personas','nombres','María del Rosario',NULL,NULL),(11,'','antecedentes_comision','El 15 de noviembre de 2010,  APPA reconoció al IFAI como miembro de pleno derecho mediante una carta firmada por el Comisionado de Información de Australia, en nombre de las demás autoridades participantes. El IFAI participa en actividades de APPA, como la Semana de Concientización de la Privacidad (PAW), la cual tiene como objetivo sensibilizar a entidades y empresas que están reguladas por las leyes de privacidad, así como a',NULL,NULL),(11,'','ciudad_destino','Vancouver',NULL,NULL),(11,'','ciudad_origen','Ciudad de México',NULL,NULL),(11,'','costo_total',NULL,36272.4,NULL),(11,'','costo_total_hospedaje',NULL,12109.46,NULL),(11,'','costo_viaticos',NULL,20000,NULL),(11,'','fecha_hora_regreso',NULL,NULL,'2015-12-05 00:00:00'),(11,'','fecha_hora_salida',NULL,NULL,'2015-12-11 00:00:00'),(11,'','informe_contribucion','La participación en el foro APPA representa la oportunidad de impulsar un liderazgo del nuevo IFAI en uno de los espacios de colaboración de Autoridades de Protección de Datos más relevantes para el país, considerando la importancia de las economías que componen la región.',NULL,NULL),(11,'','informe_resultados','Acercamiento del Instituto con las misiones diplomáticas del país acreditadas en el exterior, que permita la exploración de espacios de capacitación a funcionarios y de divulgación de información relevante para los migrantes de México. Asimismo, se amplía la oportunidad de capacitación para funcionarios del IFAI en una materia de alta responsabilidad para el Instituto, la protección de datos personales.',NULL,NULL),(11,'','motivo_comision','Durante el 42° Foro APPA, se contempla una participación del IFAI en dos momentos: a. En la sesión 2 titulada Informes jurisdiccionales, en la cual cada miembro presenta un avance de sus cambios normativos en la materia; y, b. En la sesión 13, titulada Desarrollos mundiales en materia de privacidad, en la que abordará temas vinculados con la Red Iberoamericana de Protección de Datos, presidida por el IFAI.',NULL,NULL),(11,'','nombre_evento','42° Foro de Autoridades de Privacidad de Asia-Pacífico (APPA)',NULL,NULL),(11,'','nombre_hotel','Delta Vancouver Suites',NULL,NULL),(11,'','pais_destino','Canadá',NULL,NULL),(11,'','pais_origen','México',NULL,NULL),(11,'','tipo_pasaje','Aéreo',NULL,NULL),(11,'','tipo_viaje','Internacional',NULL,NULL),(11,'','unidad_administrativa','Comisiones',NULL,NULL),(11,'','url_evento','http://www.appaforum.org/',NULL,NULL),(11,'personas','apellido_paterno','González',NULL,NULL),(11,'personas','nombres','Francisco',NULL,NULL),(12,'','ciudad_destino','Saltillo',NULL,NULL),(12,'','ciudad_origen','Ciudad de México',NULL,NULL),(12,'','costo_total',NULL,6680,NULL),(12,'','costo_viaticos',NULL,20000,NULL),(12,'','fecha_hora_regreso',NULL,NULL,'2015-04-02 00:00:00'),(12,'','fecha_hora_salida',NULL,NULL,'2015-04-02 00:00:00'),(12,'','informe_contribucion','Con esto se contribuye a una correcta defensa al Instituto en el cual es parte, y así se cumplen con las atribuciones conferidas a esta Dirección General.',NULL,NULL),(12,'','informe_resultados','Se comentó el asunto, con el Titular del Juzgado y la Secretaria del Juzgado encargada del asunto, ante los cuales fueron expuestos los argumentos de este Instituto a fin de que se dicte resolución favorable al mismo. Cabe destacar que dichos funcionarios comentaron que era probable que los auxiliara un Juzgado de Distrito en Acapulco, Guerrero, para el dictado de la sentencia correspondiente.',NULL,NULL),(12,'','motivo_comision','Llevar a cabo la defensa del IFAI, por un amparo promovido por el Quejoso Ricardo Aguirre Cuellar, referente al recurso de revisión RDA 4093/13, radicado en esa entidad, ante el Juzgado de distrito, para el dictado de la resolución correspondiente.',NULL,NULL),(12,'','nombre_evento','Notificación - 02/abr/14 - Coahuila',NULL,NULL),(12,'','nombre_hotel','Hoteles Posada Real',NULL,NULL),(12,'','pais_destino','México',NULL,NULL),(12,'','pais_origen','México',NULL,NULL),(12,'','tipo_pasaje','Aéreo',NULL,NULL),(12,'','tipo_viaje','Nacional',NULL,NULL),(12,'personas','apellido_paterno','Miramontes',NULL,NULL),(12,'personas','nombres','Sandra Mariana',NULL,NULL),(13,'','ciudad_destino','Ningbo',NULL,NULL),(13,'','ciudad_origen','Ciudad de México',NULL,NULL),(13,'','costo_total',NULL,51837.52,NULL),(13,'','costo_total_hospedaje',NULL,23154.15,NULL),(13,'','costo_viaticos',NULL,20000,NULL),(13,'','fecha_hora_regreso',NULL,NULL,'2015-02-22 00:00:00'),(13,'','fecha_hora_salida',NULL,NULL,'2015-02-13 00:00:00'),(13,'','informe_contribucion','La asistencia a las reuniones del DPS y del ECSG de APEC, durante febrero de 2014, permitieron al IFAI dar seguimiento a los temas de privacidad que se están tratando a nivel regional. En específico, permitió conocer el estado del Sistema de CBPRs y de la inquietud de la industria en el sentido que es importante que se cuenten con más Economías dentro del Sistema, más terceros certificadores y más organizaciones certificadas para comenzar a hacer transferencias internacionales y evaluar los beneficios del sistema en operación.',NULL,NULL),(13,'','informe_resultados','Se anexa programa con actividades y resultados.',NULL,NULL),(13,'','motivo_comision','Participar en la Reunión del subgrupo de Privacidad de Datos del Grupo Directivo de Comercio Electrónico y en la Reunión Conjunta APEC-Unión Europea, en el marco de la Primera Reunión de Altos Funcionarios y Reuniones Relacionadas de APEC (First Senior Officials´Meeting and Related Meetings-SOM1), que se llevará a cabo en Ningbo, China, del 16 al 20 de febrero de 2014.',NULL,NULL),(13,'','nombre_evento','Primera Reunión Ministerial de APEC y reuniones relacionadas, 2014, celebradas en Ningbo, China',NULL,NULL),(13,'','nombre_hotel','Hotel Malibú',NULL,NULL),(13,'','pais_destino','China',NULL,NULL),(13,'','pais_origen','México',NULL,NULL),(13,'','tipo_pasaje','Aéreo',NULL,NULL),(13,'','tipo_viaje','Internacional',NULL,NULL),(13,'','viaticos_comprobados',NULL,17000,NULL),(13,'','viaticos_devueltos',NULL,0,NULL),(13,'','viaticos_sin_comprobar',NULL,3000,NULL),(13,'personas','apellido_materno','Pérez',NULL,NULL),(13,'personas','apellido_paterno','Higuera',NULL,NULL),(13,'personas','nombres','Melissa',NULL,NULL),(14,'','ciudad_destino','Washington, D. C.',NULL,NULL),(14,'','ciudad_origen','Ciudad de México',NULL,NULL),(14,'','costo_total',NULL,24352.27,NULL),(14,'','costo_total_hospedaje',NULL,12457.41,NULL),(14,'','costo_viaticos',NULL,20000,NULL),(14,'','fecha_hora_regreso',NULL,NULL,'2015-03-08 00:00:00'),(14,'','fecha_hora_salida',NULL,NULL,'2015-03-04 00:00:00'),(14,'','informe_contribucion','Las reuniones de alto nivel junto con autoridades de protección de datos personales de Canadá, Francia, Reino Unido y la Unión Europea, con congresistas norteamericanos y funcionarios de la Oficina del Presidente de Estados Unidos de América, resultaron en un enriquecedor intercambio de ideas en materia de privacidad y protección de datos personales, a partir de la visión de diversas autoridades, mediante una exposición y discusión de distintos puntos de vista. El IFAI, por conducto de la Comisionada María Elena Pérez-Jaén Zermeño, aportó las experiencias y aprendizajes que se han tenido en México en el corto periodo del ejercicio y de la protección de datos de este derecho, así como las principales tendencias en materia de protección de privacidad puestas en práctica. En concreto, asistencia de los servidores públicos que representaron al IFAI a estas reuniones permitirá al Instituto reflexionar sobre temas útiles para mejorar y enriquecer las prácticas actuales en la privacidad y protección de datos, así como generar sinergias con otras autoridades de la región sobre el tema, en el marco de redes de cooperación existentes de los cuales México es integrante.Las reuniones de alto nivel junto con autoridades de protección de datos personales de Canadá, Francia, Reino Unido y la Unión Europea, con congresistas norteamericanos y funcionarios de la Oficina del Presidente de Estados Unidos de América, resultaron en un enriquecedor intercambio de ideas en materia de privacidad y pr',NULL,NULL),(14,'','informe_resultados','Se anexa programa con actividades y resultados.',NULL,NULL),(14,'','motivo_comision','Participar en reuniones de alto nivel junto con autoridades de privacidad y protección de datos personales de Canadá, Francia, Holanda, Reino Unido y la Unión Europea, con congresistas norteamericanos y funcionarios de la Oficina del Presidente de Estados unidos de América, que se llevaron a cabo en Washington, D.C., el 5 y 6 de marzo de 2014, con el objeto de tratar temas de interés de la comunidad internacional en torno a la protección de datos personales, los cuales se detallan en el presente informe de comisión. Participar los días 6 y 7 de marzo en la Reunión Global de la Asociación Internacional de Profesionales de Privacidad 2014 (IAPP 2014), en el panel Regulatory Enforcement: Around the World in 90 minutes.',NULL,NULL),(14,'','nombre_evento','Reunión Global de la Asociación Internacional de Profesionales de Privacidad',NULL,NULL),(14,'','nombre_hotel','Hilton',NULL,NULL),(14,'','pais_destino','Estados Unidos de América',NULL,NULL),(14,'','pais_origen','México',NULL,NULL),(14,'','tipo_pasaje','Aéreo',NULL,NULL),(14,'','tipo_viaje','Internacional',NULL,NULL),(14,'','url_evento','https://privacyassociation.org/',NULL,NULL),(14,'personas','apellido_materno','Ricárdez',NULL,NULL),(14,'personas','apellido_paterno','Báez',NULL,NULL),(14,'personas','fecha_ingreso','',NULL,'2015-02-15 18:00:00'),(14,'personas','nombres','María Adriana',NULL,NULL),(15,'','ciudad_destino','San Salvador',NULL,NULL),(15,'','ciudad_origen','Ciudad de México',NULL,NULL),(15,'','costo_total',NULL,613.07,NULL),(15,'','costo_viaticos',NULL,20000,NULL),(15,'','fecha_hora_regreso',NULL,NULL,'2015-10-08 00:00:00'),(15,'','fecha_hora_salida',NULL,NULL,'2015-10-05 00:00:00'),(15,'','informe_contribucion','La participación del IFAI en  eventos contribuye a reafirmar el liderazgo del IFAI en materia de acceso a  la información en la región latinoamericana; refrendo del compromiso y liderazgo del IFAI frente al vínculo con otras autoridades en materia de protección de datos y presencia en la RIPDP',NULL,NULL),(15,'','informe_resultados','La participación del IFAI permitió compartir la experiencia de México en el desarrollo normativo del derecho a la protección de datos personales y en la implementación de la estrategia que se ha seguido para garantizar este derecho a nivel federal en concreto con los sujetos regulados por el IFAI',NULL,NULL),(15,'','motivo_comision','Compartir la experiencia de México en particular la del IFAI en la implementación del derecho de protección de datos personales',NULL,NULL),(15,'','nombre_evento','Taller Internacional sobre Protección de Datos Personales ',NULL,NULL),(15,'','nombre_hotel','Maritim Hotel',NULL,NULL),(15,'','pais_destino','El Salvador',NULL,NULL),(15,'','pais_origen','México',NULL,NULL),(15,'','tipo_pasaje','Aéreo',NULL,NULL),(15,'','tipo_viaje','Internacional',NULL,NULL),(15,'','viaticos_comprobados',NULL,11000,NULL),(15,'','viaticos_devueltos',NULL,7000,NULL),(15,'','viaticos_sin_comprobar',NULL,2000,NULL),(15,'personas','apellido_materno','Ricárdez',NULL,NULL),(15,'personas','apellido_paterno','Báez',NULL,NULL),(15,'personas','fecha_ingreso',NULL,NULL,'2015-01-31 18:00:00'),(15,'personas','nombres','María Adriana',NULL,NULL),(16,'','antecedentes_comision','La Conferencia Internacional de Autoridades de Protección de Datos y Privacidad (CIAPDP), es el evento más importante en el ámbito internacional en protección de datos y privacidad. Desde hace 30 años reúne anualmente a autoridades garantes de protección de datos y privacidad, expertos, académicos y representantes de las principales empresas de internet, quienes discuten y revisan los temas más importantes en la materia e impulsan acuerdos de cooperación que fomenten el cumplimiento de las leyes, contribuyendo a garantizar el derecho fundamental de la protección de datos',NULL,NULL),(16,'','ciudad_destino','Port Louis',NULL,NULL),(16,'','ciudad_origen','Ciudad de México',NULL,NULL),(16,'','costo_total',NULL,101704.94,NULL),(16,'','costo_viaticos',NULL,20000,NULL),(16,'','fecha_hora_regreso',NULL,NULL,'2015-10-16 00:00:00'),(16,'','fecha_hora_salida',NULL,NULL,'2015-10-12 00:00:00'),(16,'','informe_contribucion','La participación del IFAI en la conferencia internacional reitera el compromiso del Instituto de garantizar el cumplimiento del derecho fundamental de protección de datos. Las ponencias de la sesión abierta, sobre temas de actualidad, permiten conocer los mecanismos novedosos que han diseñado los países para enfrentar los retos que el desarrollo de las tecnologías impone a los derechos de privacidad y protección de datos. En el caso de los talleres y seminarios organizados por los diferentes Grupos de Trabajo y organizaciones, el IFAI está especialmente interesado en los resultados de las investigaciones que estos actores llevan a cabo con el objetivo de fortalecer sus herramientas internas para cumplir con su misión como organismo constitucional autónomo, particularmente aquellas de difusión y educación. En el caso particular de la reunión del Grupo de Trabajo para la Cooperación Internacional para Hacer Cumplir la Ley, conviene destacar la aprobación del Global Cross Border Enforcement Cooperation Arrangement. Las autoridades que deseen participar en dicho Acuerdo, deberán manifestarlo durante la 37° edición de la Conferencia Internacional, la cual tendrá lugar en Amsterdam en 2015. En la sesión cerrada, presentamos los avances del Instituto en materia de protección de datos, haciendo énfasis en sus nuevas atribuciones como organismo constitucional autónomo y en las ventajas que éstas representan para la construcción de una sociedad mexicana transparente, abierta y democrát',NULL,NULL),(16,'','informe_resultados','Vinculación a nivel internacional en temas de protección de datos',NULL,NULL),(16,'','motivo_comision','La Conferencia tendrá sesiones abiertas y cerradas, estas últimas sólo para Autoridades garantes de Protección de Datos. En la sesión cerrada, que se celebrará el 13 y 14 de octubre, se presentarán reportes de avances en materia de protección de datos. En ésta, el IFAI informará respecto a los desarrollos en México derivados de la reforma constitucional en materia de transparencia. Asimismo, el Grupo de Trabajo de Coordinación Internacional para el Cumplimiento (IECWG), en el cual participa el IFAI, presentará el Acuerdo de Cooperación Transfronteriza en materia de Cumplimiento. Finalmente, se presentarán y votarán tres resoluciones sobre Big Data; Privacidad en la era digital; y cooperación internacional en materia de cumplimiento. En la sesión abierta, (15 y 16 de octubre) se llevarán a cabo tres reuniones plenarias y 12 paneles. Los temas de las sesiones previstas son la protección de datos en el mundo en desarrollo; el hacer y el deber hacer de los reguladores para una protección efectiva de la privacidad; Proyecto Marco de Riesgos de la Privacidad; Privacidad en la era digital, la resolución de Naciones Unidas, y E-salud y la protección de datos, entre otras.',NULL,NULL),(16,'','nombre_evento','36 Conferencia Internacional de Autoridades de Protección de Datos y Privacidad',NULL,NULL),(16,'','pais_destino','Mauricio',NULL,NULL),(16,'','pais_origen','México',NULL,NULL),(16,'','tipo_pasaje','Aéreo',NULL,NULL),(16,'','tipo_viaje','Internacional',NULL,NULL),(16,'','url_evento','http://www.privacyconference2014.org/en/',NULL,NULL),(16,'personas','apellido_materno','Chepov',NULL,NULL),(16,'personas','apellido_paterno','Monterrey',NULL,NULL),(16,'personas','nombres','Rosendoevgueni',NULL,NULL),(17,'','antecedentes_comision','La RTA es una organización conformada por las autoridades de América Latina responsables de garantizar el derecho de acceso a la información pública, cuya finalidad es mantener un espacio permanente y formal de diálogo, de cooperación, y de intercambio de conocimientos y experiencias entre sus miembros. Hasta octubre de 2014, la Red cuenta con un total de 16 miembros pertenecientes a 11 países latinoamericanos, una fundación internacional y un organismo internacional, consolidándose como un referente internacional en la materia. El IFAI Preside la Red de Transparencia y Acceso a la Información desde 2012 y tiene la posibilidad de reelegirse en 2015 por un periodo de tres años y ha sido sede de tres de los siete encuentros celebrados hasta el momento, en los que participan todos los miembros de la Red para presentar los avances de los grupos de trabajo, aprobar el ingreso de nuevos miembros y definir los próximos pasos para la Red. En su 8ª edición, el Encuentro se celebrará en una sede distinta a la de la Presidencia y Secretaría Ejecutiva de la Red, México y Chile, respectivamente.',NULL,NULL),(17,'','ciudad_destino','Brasilia',NULL,NULL),(17,'','ciudad_origen','Ciudad de México',NULL,NULL),(17,'','costo_total',NULL,97337.77,NULL),(17,'','costo_total_hospedaje',NULL,33008.17,NULL),(17,'','costo_viaticos',NULL,20000,NULL),(17,'','fecha_hora_regreso',NULL,NULL,'2015-11-11 11:00:00'),(17,'','fecha_hora_salida',NULL,NULL,'2015-11-03 00:00:00'),(17,'','informe_contribucion','Como Presidente de la RAT, la asistencia del IFAI contribuyó a fortalecer su liderazgo regional en materia de transparencia y acceso a la información, aportó al debate regional en materia de archivos y generó un intercambio de experiencias útiles para nuestro país, especialmente tomando en consideración la reciente reforma en materia de transparencia en México, que implica la creación de una Ley General de Archivos.',NULL,NULL),(17,'','informe_resultados','Archivos: Análisis de la normativa existente de cada uno de los países miembros de la RTA y un diagnóstico de la situación actual de los archivos públicos, de próxima publicación. Jurisprudencia y Criterios Administrativos: Procura generar un registro de los criterios de jurisprudencia y administrativos en materia de acceso a la información de cada una de las instituciones miembro. Indicadores de impacto: Se realizó un primer levantamiento de los indicadores existentes en cada uno de los países, para responder luego a la pregunta ¿Qué estamos midiendo? Difusión y Capacitación: Se encuentra en ejecución un plan de capacitación regional para los miembros, a través del Espacio Colaborativo. Gobierno Abierto: Los órganos garantes ven en la política de gobierno abierto una oportunidad para profundizar en la política de transparencia y el derecho de acceso a la información pública al tiempo que también conectar este tema con la agenda más amplia de participación pública y rendición de cuenta',NULL,NULL),(17,'','motivo_comision','Durante las jornadas del Encuentro de la RTA, los días 4 y 5 de noviembre, el IFAI en su calidad de Presidencia, dio la bienvenida a nuevas instituciones a este espacio de colaboración, rindió un informe sobre el avance del derecho de acceso a la información en el país, presentó la plataforma Corpus Iuris IFAI y exploró nuevas oportunidades de colaboración institucional con organismos internacionales. El seminario de Río de Janeiro tuvo como propósito analizar el cumplimiento por parte de instituciones públicas brasileñas de la Ley de Acceso a la Información publicada en 2011 y en el que se buscó dar a conocer la experiencia internacional así como brindar a los asistentes la oportunidad de participar en talleres prácticos sobre las herramientas para el ejercicio del derecho de acceso a la información, el periodismo basado en el acceso a la información y datos abiertos. Dentro del “Taller Regional para la construcción del modelo de gestión de Archivos”: Presentación de las directrices y guías de implementación centrales del Modelo de Gestión de Archivos para su posterior análisis por parte de los países integrantes de la RTA. Por lo que se refiere al “VIII Encuentro de la Red de Transparencia y Acceso a la Información”: aprobación del ingreso de la Procuraduría General de Colombia, Procuraduría de Derechos de Guatemala, y el Instituto de Acceso a la Información Pública de Honduras. En el Seminario Evaluación Nacional de Transparencia Gubernamental se presentaron y debatieron los resultados obtenidos del estudio realizado por la Escuela Brasileña de Administración Pública y de Empresas (EBAPE) y el Centro de Tecnología y Sociedad Derecho Río, de la Fundación Getúlio Vargas en ocho niveles de gobierno (estados de Minas Gerais, Río de Janeiro y Sao Paulo, incluyendo sus capitales en el Distrito Federal y la Unión) con respecto a la aplicación por los organismos públicos brasileños de la Ley de Acceso a la Información (Ley 12.527 de 2011).',NULL,NULL),(17,'','nombre_evento','VII Encuentro de la Red de Transparencia y Acceso a la Información (RTA)',NULL,NULL),(17,'','pais_destino','Brasil',NULL,NULL),(17,'','pais_origen','México',NULL,NULL),(17,'','tipo_pasaje','Aéreo',NULL,NULL),(17,'','tipo_viaje','Internacional',NULL,NULL),(17,'personas','apellido_materno','Chepov',NULL,NULL),(17,'personas','apellido_paterno','Monterrey',NULL,NULL),(17,'personas','nombres','Rosendoevgueni',NULL,NULL),(18,'','ciudad_destino','Mexicali',NULL,NULL),(18,'','ciudad_origen','Ciudad de México',NULL,NULL),(18,'','costo_total',NULL,17751.45,NULL),(18,'','costo_viaticos',NULL,20000,NULL),(18,'','fecha_hora_regreso',NULL,NULL,'2015-06-27 18:00:00'),(18,'','fecha_hora_salida',NULL,NULL,'2015-06-24 00:00:00'),(18,'','informe_contribucion','Tener una aproximación de nivel de conocimiento y socialización  del derecho a la protección de datos personales entre la sociedad mexicana, representada por servidores públicos del Poder Ejecutivo de Baja California empresas y organizaciones de la sociedad civil de dicho Estado',NULL,NULL),(18,'','informe_resultados','Generar conciencia sobre la importancia e impacto del valor cuantitativo y cualitativo de los datos personales dentro de una contexto global y digital;  sensibilizar sobre la responsabilidad que implica compartir los datos personales con terceros; promover y difundir los derechos',NULL,NULL),(18,'','motivo_comision','Participar como instructora en un curso sobre le régimen de protección de datos personales aplicable al sector público federal y en otro curso sobre el alcance y principales obligaciones previstas en la Ley Federal de Protección de Datos Personales en Posesión de  los Particulares. Asimismo impartir una plática sobre el régimen de protección de datos personales aplicable al sector privado',NULL,NULL),(18,'','nombre_evento','Plática sobre la Ley Federal de Protección de Datos Personales en Posesión de Particulares',NULL,NULL),(18,'','nombre_hotel','Colonial',NULL,NULL),(18,'','pais_destino','México',NULL,NULL),(18,'','pais_origen','México',NULL,NULL),(18,'','tipo_pasaje','Aéreo',NULL,NULL),(18,'','tipo_viaje','Nacional',NULL,NULL),(18,'personas','apellido_materno','Urbina',NULL,NULL),(18,'personas','apellido_paterno','Alcalde',NULL,NULL),(18,'personas','cargo','Director de Atención General',NULL,NULL),(18,'personas','fecha_ingreso',NULL,NULL,'2014-11-30 18:00:00'),(18,'personas','nombres','Samantha',NULL,NULL),(20,'','ciudad_destino','Caracas',NULL,NULL),(20,'','fecha_hora_salida','',NULL,'2015-12-02 18:00:00'),(20,'','pais_destino','Venezuela',NULL,NULL),(20,'personas','apellido_paterno','López',NULL,NULL),(20,'personas','nombres','Pedro',NULL,NULL);
/*!40000 ALTER TABLE `viajes_claros_detalle` ENABLE KEYS */;
UNLOCK TABLES;

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
  `id_archivo` bigint NULL ,
  PRIMARY KEY (`id_viaje`),
  KEY `fk_viajes_claros_instancias_dependencias1_idx` (`id_dependencia`),
  KEY `fk_viajes_claros_instancias_archivos_procesados1_idx` (`id_archivo`),
  KEY `fk_viajes_claros_instancias_comisiones1_idx` (`id_comision`),
  CONSTRAINT `fk_viajes_claros_instancias_archivos_procesados1` FOREIGN KEY (`id_archivo`) REFERENCES `archivos_procesados` (`id_archivo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_viajes_claros_instancias_comisiones1` FOREIGN KEY (`id_comision`) REFERENCES `comisiones` (`id_comision`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_viajes_claros_instancias_dependencias1` FOREIGN KEY (`id_dependencia`) REFERENCES `dependencias` (`id_dependencia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viajes_claros_instancias`
--

LOCK TABLES `viajes_claros_instancias` WRITE;
/*!40000 ALTER TABLE `viajes_claros_instancias` DISABLE KEYS */;
INSERT INTO `viajes_claros_instancias` VALUES (1,1,'2014-12-31 18:00:00',1,NULL),(3,1,'1969-12-31 18:00:00',4,NULL),(4,1,'2015-01-31 18:00:00',5,NULL),(5,1,'2015-03-03 18:00:00',6,NULL),(6,1,'2015-03-31 18:00:00',7,NULL),(7,1,'2015-05-01 18:00:00',8,NULL),(8,1,'2015-05-31 18:00:00',9,NULL),(9,1,'2015-07-31 18:00:00',10,NULL),(10,1,'2015-08-31 18:00:00',11,NULL),(11,1,'2015-12-15 18:00:00',12,NULL),(12,2,'2015-12-06 18:00:00',NULL,1),(13,2,'2014-12-31 18:00:00',NULL,1),(14,2,'2015-01-31 18:00:00',NULL,1),(15,2,'2014-10-31 18:00:00',NULL,1),(16,2,'2014-09-01 18:00:00',NULL,1),(17,2,'2014-08-31 18:00:00',NULL,1),(18,2,'2014-07-31 18:00:00',NULL,1),(20,1,'2015-12-10 18:00:00',NULL,1);
/*!40000 ALTER TABLE `viajes_claros_instancias` ENABLE KEYS */;
UNLOCK TABLES;

-- -----------------------------------------------------
-- Table `viajes_claros`.`jerarquia_miembros`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `viajes_claros`.`jerarquia_miembros` (
  `id_miembro` INT NOT NULL AUTO_INCREMENT ,
  `id_jerarquia` INT NOT NULL ,
  `id_usuario` INT NOT NULL ,
  PRIMARY KEY (`id_miembro`) ,
  INDEX `fk_jerarquia_miembros_jerarquias1_idx` (`id_jerarquia` ASC) ,
  INDEX `fk_jerarquia_miembros_usuarios1_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_jerarquia_miembros_jerarquias1`
    FOREIGN KEY (`id_jerarquia` )
    REFERENCES `viajes_claros`.`jerarquias` (`id_jerarquia` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jerarquia_miembros_usuarios1`
    FOREIGN KEY (`id_usuario` )
    REFERENCES `viajes_claros`.`usuarios` (`id_usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

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
DROP FUNCTION IF EXISTS `actualiza_archivos_procesados`;;
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
DROP FUNCTION IF EXISTS `actualiza_area`;;
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
DROP FUNCTION IF EXISTS `actualiza_categoria`;;
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
DROP FUNCTION IF EXISTS `actualiza_ciudad`;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_ciudad`(id integer, nombre text, pais integer, edo integer) RETURNS int(11)
BEGIN
	update `viajes_claros`.`ciudades`
	set nombre_ciudad = nombre
	   ,id_pais = pais
	   ,id_estado = edo
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
DROP FUNCTION IF EXISTS `actualiza_contra`;;
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
DROP FUNCTION IF EXISTS `actualiza_dependencia`;;
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
DROP FUNCTION IF EXISTS `actualiza_estado`;;
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
DROP FUNCTION IF EXISTS `actualiza_jerarquia`;;
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
DROP FUNCTION IF EXISTS `actualiza_miembro`;;
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
DROP FUNCTION IF EXISTS `actualiza_pais`;;
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
DROP FUNCTION IF EXISTS `actualiza_persona`;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_persona`(id int, nombre text, ape_Paterno text, ape_Materno text
																	  ,tit text, e_mail text, id_cat integer, id_tipo integer
																	  ,id_pos integer) RETURNS int(11)
BEGIN
	update `viajes_claros`.`personas`
	set nombres = nombre
	   ,apellido_paterno = ape_Paterno
	   ,apellido_materno = ape_Materno
	   ,titulo = tit
	   ,email = e_mail
       ,id_categoria = id_cat
       ,id_tipo_persona = id_tipo
	   ,id_posicion = id_pos
	where id_persona = id;

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
DROP FUNCTION IF EXISTS `actualiza_posicion`;;
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
DROP FUNCTION IF EXISTS `actualiza_usuario`;;
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
DROP FUNCTION IF EXISTS `actualiza_viajes_claros_det`;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_viajes_claros_det`(id int(11), tab text, camp text, valorT text, valorN double, valorF DateTime) RETURNS int(11)
BEGIN
	declare vn_existe int;
    
    select count(*)
    into vn_existe
    from viajes_claros.viajes_claros_detalle
    where id_viaje = id
    and tabla = tab
	and campo = camp
    and id_archivo is not null;
    
    if(vn_existe > 0) then
		update viajes_claros.viajes_claros_detalle 
        set valor_texto = valorT,
			valor_numerico = valorN,
            valor_fecha = valorF
		where id_viaje = id
        and tabla = tab
        and campo = camp
        and id_archivo is not null;
		
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
DROP FUNCTION IF EXISTS `elimina_area`;;
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
DROP FUNCTION IF EXISTS `elimina_categoria`;;
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
DROP FUNCTION IF EXISTS `elimina_ciudad`;;
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
DROP FUNCTION IF EXISTS `elimina_dependencia`;;
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
DROP FUNCTION IF EXISTS `elimina_estado`;;
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
DROP FUNCTION IF EXISTS `elimina_jerarquia`;;
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
DROP FUNCTION IF EXISTS `elimina_miembro`;;
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
DROP FUNCTION IF EXISTS `elimina_pais`;;
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
DROP FUNCTION IF EXISTS `elimina_persona`;;
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
DROP FUNCTION IF EXISTS `elimina_posicion`;;
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
DROP FUNCTION IF EXISTS `elimina_usuario`;;
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
DROP FUNCTION IF EXISTS `elimina_viajes_claros_det`;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_viajes_claros_det`(id_viaje int(11), tab text, camp text, valorT text, valorN double, valorF DateTime) RETURNS int(11)
BEGIN

	declare vn_existe int;
    
	select count(*)
    into vn_existe
    from viajes_claros.viajes_claros_detalle
    where id_viaje = id
    and tabla = tab
	and campo = camp
    and id_archivo is not null;
    
    if(vn_existe > 0) then
		delete
        from viajes_claros.viajes_claros_detalle
		where id_viaje = id
		and tabla = tab
		and campo = camp
		and id_archivo is not null;
		
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
DROP FUNCTION IF EXISTS `inserta_area`;;
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
DROP FUNCTION IF EXISTS `inserta_categoria`;;
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
DROP FUNCTION IF EXISTS `inserta_ciudad`;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_ciudad`(nombre text, pais integer, edo integer) RETURNS int(11)
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
		insert into `viajes_claros`.`ciudades`
		values (default, nombre, pais, edo);
		
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP FUNCTION IF EXISTS `inserta_comision`;;
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
DROP FUNCTION IF EXISTS `inserta_dependencia`;;
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
DROP FUNCTION IF EXISTS `inserta_estado`;;
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
DROP FUNCTION IF EXISTS `inserta_jerarquia`;;
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
DROP FUNCTION IF EXISTS `inserta_miembro`;;
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
DROP FUNCTION IF EXISTS `inserta_pais`;;
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
DROP FUNCTION IF EXISTS `inserta_persona`;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_persona`(nombre text, ape_Paterno text, ape_Materno text
																	,tit text, e_mail text, id_cat integer
																	,id_tipo integer, id_pos integer) RETURNS int(11)
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
		insert into `viajes_claros`.`personas`
		values (default, nombre, ape_Paterno, ape_Materno, tit, e_mail, id_cat, id_tipo, id_pos);
		
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
DROP FUNCTION IF EXISTS `inserta_posicion`;;
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
DROP FUNCTION IF EXISTS `inserta_usuario`;;
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
												id_perfil, id_persona, id_area, jefe_area)
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
DROP FUNCTION IF EXISTS `inserta_viajes_claros_det`;;
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
DROP FUNCTION IF EXISTS `inserta_viajes_claros_instancias`;;
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
DROP FUNCTION IF EXISTS `valida_usuario`;;
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
DROP PROCEDURE IF EXISTS `delete_buscador_despliegue`;;
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
DROP PROCEDURE IF EXISTS `delete_buscador_filtro`;;
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
DROP PROCEDURE IF EXISTS `delete_campo_dinamico`;;
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
DROP PROCEDURE IF EXISTS `delete_flujos_campos_config`;;
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
DROP PROCEDURE IF EXISTS `delete_graficas_dependencia`;;
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
DROP PROCEDURE IF EXISTS `delete_interfaz_config`;;
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
DROP PROCEDURE IF EXISTS `delete_listas_valores`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_listas_valores`(idLista INT)
BEGIN
	
	DELETE FROM listas_valores WHERE id_lista=idLista;
	
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
DROP PROCEDURE IF EXISTS `delete_seccion_formulario`;;
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
DROP PROCEDURE IF EXISTS `delete_suscripcion_config_por_dep`;;
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
DROP PROCEDURE IF EXISTS `delete_valores_dinamicos`;;
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
DROP PROCEDURE IF EXISTS `delete_viajes_claros_config`;;
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
DROP PROCEDURE IF EXISTS `elimina_procesados_det`;;
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
DROP PROCEDURE IF EXISTS `exists_valor_dinamico`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_areas_con_comisiones`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_areas_con_comisiones`()
BEGIN

SELECT a.id_area, a.nombre_area 
FROM areas a
INNER JOIN usuarios u ON u.id_area=a.id_area
INNER JOIN personas p ON p.id_persona=u.id_persona
INNER JOIN comisiones c ON c.id_persona=p.id_persona
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
DROP PROCEDURE IF EXISTS `get_areas_con_comisiones_calendar`;;
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
DROP PROCEDURE IF EXISTS `get_calendario_eventos_mes_anio`;;
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
		CASE WHEN com.estatus='P' THEN 'COMISIÓN PUBLICADA' 
			ELSE CASE WHEN com.estatus='EA' THEN 'COMISIÓN EN ESPERA DE APROBACIÓN' 
				ELSE CASE WHEN com.estatus='R' THEN 'COMISIÓN RECHAZADA' 
					ELSE CASE WHEN com.estatus='A' THEN 'COMISIÓN AUTORIZADA' 
						ELSE CASE WHEN com.estatus='EV' THEN 'COMISIÓN EN APROBACIÓN DE VIÁTICO' 
							ELSE CASE WHEN com.estatus='RV' THEN 'COMISIÓN RECHAZADA EN VIÁTICOS' 
								ELSE CASE WHEN com.estatus='F' THEN 'COMISIÓN FONDEADA' 
									ELSE CASE WHEN com.estatus='EG' THEN 'COMISIÓN EN APROBACIÓN DE GASTOS' 
										ELSE CASE WHEN com.estatus='RG' THEN 'COMISIÓN RECHAZADA EN GASTOS' 
											ELSE CASE WHEN com.estatus='CM' THEN 'COMISIÓN COMPROBADA' 
												ELSE CASE WHEN com.estatus='EP' THEN 'COMISIÓN EN ESPERA DE PUBLICACIÓN' 
													ELSE CASE WHEN com.estatus='RP' THEN 'COMISIÓN RECHAZADA EN PUBLICACIÓN' 
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
	'COMISIÓN PUBLICADA'  as estatus,
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
DROP PROCEDURE IF EXISTS `get_campos_base`;;
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
DROP PROCEDURE IF EXISTS `get_campos_carga_disponibles`;;
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
DROP PROCEDURE IF EXISTS `get_campos_config_disponibles`;;
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
DROP PROCEDURE IF EXISTS `get_campos_config_por_tabla`;;
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
DROP PROCEDURE IF EXISTS `get_campos_despliegue_disponibles`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_campos_despliegue_por_dependencia`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_campos_despliegue_por_dependencia`(idDep INT)
BEGIN
	
	SELECT conf.id_dependencia, conf.tabla, conf.campo,
	CASE WHEN base.despliegue IS NULL THEN din.despliegue ELSE base.despliegue END as despliegue
FROM buscador_despliegue_config conf
LEFT JOIN campos_base base ON base.tabla = conf.tabla AND base.campo = conf.campo
LEFT JOIN campos_dinamicos din ON din.nombre_campo = conf.campo
WHERE conf.id_dependencia = idDep;
	
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
DROP PROCEDURE IF EXISTS `get_campos_dinamicos`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_campos_filtros_disponibles`;;
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
DROP PROCEDURE IF EXISTS `get_campos_flujo_disponibles`;;
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
DROP PROCEDURE IF EXISTS `get_campos_por_tabla_config`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_campos_por_tabla_config`(IN nombreTabla VARCHAR(50))
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
DROP PROCEDURE IF EXISTS `get_campo_dinamico_por_nombre`;;
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
DROP PROCEDURE IF EXISTS `get_catalogo_tabla_campo`;;
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
DROP PROCEDURE IF EXISTS `get_categorias_campo`;;
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
DROP PROCEDURE IF EXISTS `get_cat_comparadores`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_comisiones_detalle_por_id_comision`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_comisiones_en_curso_por_id_persona`;;
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
/*!50003 DROP PROCEDURE IF EXISTS `get_comision_detalle_id_comision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_comision_detalle_id_comision`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_dependencias`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_dependencias`()
BEGIN
	
	SELECT id_dependencia, nombre_dependencia, siglas, predeterminada FROM dependencias;
	
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_detalle_usuario_por_nombre_usuario`;;
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

END;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_filtros_por_dependencia`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_filtros_por_dependencia`(IN idDependencia INT(10))
BEGIN
	
	
	
	SELECT id_dependencia, tabla, campo, despliegue, 
	CASE WHEN tipo_dato=1 THEN 'INT' ELSE (CASE WHEN tipo_dato=2 THEN 'VARCHAR' ELSE (CASE WHEN tipo_dato=3 THEN 'DATE' ELSE 'UNDEFINED' END)  END) END as tipo_dato, 
	CASE WHEN tipo_control=1 THEN 'TEXT' ELSE (CASE WHEN tipo_control=2 THEN 'SELECT' ELSE (CASE WHEN tipo_control=3 THEN 'DATE' ELSE 'UNDEFINED' END) END) END as tipo_control, 
	operador, id_lista FROM 
	(
	SELECT b.id_dependencia, b.tabla, b.campo, b.operador, din.id_lista,
	CASE WHEN base.despliegue IS NULL THEN din.despliegue ELSE base.despliegue END as despliegue, 
	CASE WHEN base.tipo_dato IS NULL THEN din.tipo_dato ELSE base.tipo_dato END as tipo_dato,
	CASE WHEN base.tipo_control IS NULL THEN din.tipo_control ELSE base.tipo_control END as tipo_control
	FROM buscador_filtros_config b
	LEFT JOIN campos_base base ON base.tabla = b.tabla AND base.campo = b.campo 
	LEFT JOIN campos_dinamicos din ON din.nombre_campo = b.campo
	WHERE b.id_dependencia=idDependencia
	) A
	;
	
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_flujos_campos_config_por_flujo_tipo_persona_seccion`;;
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
DROP PROCEDURE IF EXISTS `get_flujos_campos_config_por_id_flujo`;;
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
DROP PROCEDURE IF EXISTS `get_flujos_campos_config_por_id_flujo_categoria`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_flujos_campos_config_por_id_flujo_tipo_persona`;;
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
DROP PROCEDURE IF EXISTS `get_flujos_trabajo`;;
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
DROP PROCEDURE IF EXISTS `get_funcionarios_por_area_calendar`;;
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
DROP PROCEDURE IF EXISTS `get_funcionarios_por_dependencia`;;
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
/*!50003 DROP PROCEDURE IF EXISTS `get_funcionarios_resumen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_funcionarios_resumen`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_funcionarios_resumen`()
BEGIN


SELECT p.id_persona, p.nombres, p.apellido_paterno, p.apellido_materno, p.cargo,
	SUM(v.valor_numerico) as total_gasto, v.valor_numerico as viaje_mas_costoso, 
	v.id_viaje as id_viaje_mas_costoso, p.fecha_ingreso, d.siglas
FROM personas p
INNER JOIN comisiones c ON c.id_persona=p.id_persona
INNER JOIN viajes_claros_instancias i ON i.id_comision=c.id_comision
INNER JOIN usuarios u ON u.id_persona=p.id_persona
INNER JOIN dependencias d ON d.id_dependencia=u.id_dependencia
LEFT JOIN viajes_claros_detalle v ON v.id_viaje=i.id_viaje AND v.campo='costo_total'
WHERE p.id_tipo_persona<>3 
AND v.valor_numerico=(
	SELECT MAX(v2.valor_numerico) FROM viajes_claros_detalle v2
    WHERE v2.id_viaje=v.id_viaje AND v2.campo='costo_total'
)
GROUP BY p.id_persona

UNION ALL
SELECT 0 as id_persona, nom.valor_texto as nombres, 
	ap1.valor_texto as apellido1, 
	IFNULL(ap2.valor_texto, '') as apellido2,
	car.valor_texto as cargo,
	SUM(costo.valor_numerico) as total_gasto,
	costo.valor_numerico as viaje_mas_costoso,
	costo.id_viaje as id_viaje_mas_costoso,
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
		AND costo.valor_numerico=(
			SELECT MAX(v2.valor_numerico) FROM viajes_claros_detalle v2
		    WHERE v2.id_viaje=costo.id_viaje AND v2.tabla='' AND v2.campo='costo_total'
		)
	GROUP BY nombres, apellido1, apellido2;


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
DROP PROCEDURE IF EXISTS `get_funcionario_por_id`;;
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
DROP PROCEDURE IF EXISTS `get_funcionario_por_id_viaje`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_funcionario_resumen`;;
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

SELECT id_persona, nombres, apellido1, apellido2, cargo, id_dependencia, siglas, 
	total_viajes, total_costo, fecha_ingreso 
FROM (
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
	GROUP BY nombres, apellido1, apellido2
) A 
WHERE nombres=idNombres
AND apellido1=apellido1
AND apellido2=apellido2
;


END IF;


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
DROP PROCEDURE IF EXISTS `get_graficas`;;
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
DROP PROCEDURE IF EXISTS `get_graficas_por_dependencia`;;
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
DROP PROCEDURE IF EXISTS `get_headers_carga`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_headers_viajes`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_headers_viajes`(idDependencia INT)
BEGIN
	
	SELECT des.tabla, des.campo, 
	CASE WHEN b.despliegue IS NULL THEN d.despliegue ELSE b.despliegue END as despliegue
FROM buscador_despliegue_config des
LEFT JOIN campos_base b ON b.tabla=des.tabla AND b.campo=des.campo
LEFT JOIN campos_dinamicos d ON d.nombre_campo=des.campo AND des.tabla=''
WHERE id_dependencia = idDependencia;
	
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
DROP PROCEDURE IF EXISTS `get_listas_valores`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_mapa_viajes_por_ciudad_pais`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_mapa_viajes_por_ciudad_pais`(idDependencia INT(11),
	inCiudad VARCHAR(200), inPais VARCHAR(200))
BEGIN
	
	

IF idDependencia = 1 THEN 

	SELECT i.id_viaje, cd.valor_texto as ciudad, pa.valor_texto as pais, 
		DATE_FORMAT(f.valor_fecha, '%d/%m/%Y') as fecha, c.id_persona,
		p.nombres, p.apellido_paterno, p.apellido_materno
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='' AND pa.campo='pais_destino'
	INNER JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='' AND f.campo='fecha_hora_salida'
	INNER JOIN comisiones c ON c.id_comision=i.id_comision
	INNER JOIN personas p ON p.id_persona=c.id_persona
	WHERE i.id_dependencia=idDependencia
	AND cd.valor_texto=inCiudad
	AND pa.valor_texto=inPais
	;

ELSE 

	SELECT i.id_viaje, cd.valor_texto as ciudad, pa.valor_texto as pais, 
		DATE_FORMAT(f.valor_fecha, '%d/%m/%Y') as fecha, 0 as id_persona,
		n.valor_texto as nombres, a1.valor_texto as apellido1, IFNULL(a2.valor_texto, '') as apellido2
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='' AND pa.campo='pais_destino'
	LEFT JOIN viajes_claros_detalle f ON f.id_viaje=i.id_viaje AND f.tabla='' AND f.campo='fecha_hora_salida'
	INNER JOIN viajes_claros_detalle n ON n.id_viaje=i.id_viaje AND n.tabla='personas' AND n.campo='nombres'
	INNER JOIN viajes_claros_detalle a1 ON a1.id_viaje=i.id_viaje AND a1.tabla='personas' AND a1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle a2 ON a2.id_viaje=i.id_viaje AND a2.tabla='personas' AND a2.campo='apellido_materno'
	WHERE i.id_dependencia=idDependencia
	AND cd.valor_texto=inCiudad
	AND pa.valor_texto=inPais
	;

END IF;

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_secciones_formulario_por_id_flujo`;;
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
DROP PROCEDURE IF EXISTS `get_smtp_config`;;
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
DROP PROCEDURE IF EXISTS `get_suscripcion_campos_por_cat`;;
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
DROP PROCEDURE IF EXISTS `get_suscripcion_ultimos_viajes`;;
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
DROP PROCEDURE IF EXISTS `get_tablas`;;
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
DROP PROCEDURE IF EXISTS `get_tablas_base`;;
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
DROP PROCEDURE IF EXISTS `get_tablas_carga_disponibles`;;
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
DROP PROCEDURE IF EXISTS `get_tablas_despliegue_disponibles`;;
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
DROP PROCEDURE IF EXISTS `get_tablas_filtros_disponibles`;;
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
DROP PROCEDURE IF EXISTS `get_tablas_flujo_disponibles`;;
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
DROP PROCEDURE IF EXISTS `get_tipos_control`;;
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
DROP PROCEDURE IF EXISTS `get_tipos_dato`;;
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
DROP PROCEDURE IF EXISTS `get_total_gasto_anio`;;
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
DROP PROCEDURE IF EXISTS `get_total_gasto_por_dependencia`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_total_gasto_por_dependencia_anio`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_gasto_por_dependencia_anio`(idDependencia INT(11))
BEGIN

SELECT SUM(d.valor_numerico) 
FROM viajes_claros_detalle d
INNER JOIN viajes_claros_instancias i ON i.id_viaje=d.id_viaje
INNER JOIN viajes_claros_detalle v ON v.id_viaje=i.id_viaje AND v.tabla='' AND v.campo='fecha_hora_salida'
WHERE d.tabla='' AND d.campo='costo_total'
AND i.id_dependencia=idDependencia
AND YEAR(v.valor_fecha) = YEAR(CURDATE());


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
DROP PROCEDURE IF EXISTS `get_total_viajes_por_dependencia`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_total_viajes_por_dependencia_anio`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_viajes_por_dependencia_anio`(idDependencia INT(11))
BEGIN
	
	
SELECT count(*) 
FROM viajes_claros_instancias i
INNER JOIN viajes_claros_detalle v ON v.id_viaje=i.id_viaje AND v.tabla='' AND v.campo='fecha_hora_salida'
WHERE id_dependencia=idDependencia
AND YEAR(v.valor_fecha) = YEAR(CURDATE());	

	
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_total_viaticos_por_dependencia`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_viaticos_por_dependencia`(idDependencia INT(10))
BEGIN
	
	SELECT SUM(v.valor_numerico)
FROM viajes_claros_detalle v
INNER JOIN viajes_claros_instancias i ON i.id_viaje=v.id_viaje
WHERE campo='costo_viaticos'
AND i.id_dependencia=idDependencia;
	
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_ubicaciones_mapa`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_ubicaciones_mapa`(idDependencia INT(11))
BEGIN
	
SELECT cd.valor_texto as ciudad, pa.valor_texto as pais, 
	g.valor_numerico as gasto_total, A.latitud, A.longitud
FROM viajes_claros_instancias i
INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='' AND cd.campo='ciudad_destino'
INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='' AND pa.campo='pais_destino'
LEFT JOIN viajes_claros_detalle g ON g.id_viaje=i.id_viaje AND g.tabla='' AND g.campo='costo_total'
INNER JOIN (
	SELECT c.nombre_ciudad, p.nombre_pais, c.latitud, c.longitud
	FROM ciudades c
	INNER JOIN paises p ON p.id_pais=c.id_pais) A ON A.nombre_ciudad=cd.valor_texto AND A.nombre_pais=pa.valor_texto
WHERE i.id_dependencia=idDependencia;	


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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_ubicaciones_mapa_por_persona`;;
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
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='' AND pa.campo='pais_destino'
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
	INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='' AND cd.campo='ciudad_destino'
	INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='' AND pa.campo='pais_destino'
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
DROP PROCEDURE IF EXISTS `get_usuario_por_nombre_usuario`;;
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
DROP PROCEDURE IF EXISTS `get_valores_dinamicos`;;
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
DROP PROCEDURE IF EXISTS `get_valores_dinamicos_por_id`;;
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
DROP PROCEDURE IF EXISTS `get_valores_dinamicos_por_id_lista`;;
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
DROP PROCEDURE IF EXISTS `get_viajes_claros_config`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_viajes_por_dependencia`;;
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
DROP PROCEDURE IF EXISTS `get_viajes_por_dependencia_carga`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_viajes_por_filtros`;;
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
	CASE WHEN v.valor_texto IS NULL THEN CASE WHEN v.valor_numerico IS NULL THEN DATE_FORMAT(v.valor_fecha, ''%d/%m/%Y %H:%i'') ELSE v.valor_numerico END ELSE v.valor_texto END AS valor
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
DROP PROCEDURE IF EXISTS `get_viajes_por_persona`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_viajes_resumen_por_persona`;;
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
		CASE WHEN v.valor_texto IS NULL THEN CASE WHEN v.valor_numerico IS NULL THEN DATE_FORMAT(v.valor_fecha, ''%d/%m/%Y %H:%i'') ELSE v.valor_numerico END ELSE v.valor_texto END AS valor
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
	LEFT JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='' AND pa.campo='pais_destino'
	LEFT JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='' AND cd.campo='ciudad_destino'
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
/*!50003 DROP PROCEDURE IF EXISTS `get_viaje_datos_por_categoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `get_viaje_datos_por_categoria`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_viaje_datos_por_categoria`(IN idViaje INT(11), 
	IN codigoCat VARCHAR(60))
BEGIN
	
	SELECT IFNULL(b.despliegue, d.despliegue) AS despliegue,
	CASE WHEN v.valor_texto IS NULL THEN (CASE WHEN v.valor_numerico IS NULL THEN v.valor_fecha ELSE v.valor_numerico END) ELSE v.valor_texto END as valor
	FROM viajes_claros_detalle v 
	LEFT JOIN campos_base b ON b.tabla=v.tabla AND b.campo=v.campo
	LEFT JOIN campos_dinamicos d ON d.nombre_campo=v.campo AND v.tabla=''
	where v.id_viaje=idViaje
	AND (b.categoria=codigoCat OR d.categoria=codigoCat);
	
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
DROP PROCEDURE IF EXISTS `get_viaje_datos_suscripcion`;;
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
DROP PROCEDURE IF EXISTS `get_viaje_resumen_por_id`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `grafica_aerolineas_por_dep`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_aerolineas_por_dep`(idDependencia INT(10))
BEGIN
	

SELECT det.valor_texto, count(det.valor_texto) num
FROM viajes_claros_detalle det
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=det.id_viaje
WHERE ins.id_dependencia=idDependencia
AND (det.campo='aerolinea_ida' or det.campo='aerolinea_regreso')
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `grafica_ciudades_internacionales`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_ciudades_internacionales`(idDependencia INT(10))
BEGIN

SELECT CONCAT(det.valor_texto, ', ', pa.valor_texto), count(det.valor_texto) num
FROM viajes_claros_detalle det
INNER JOIN viajes_claros_detalle inter ON inter.id_viaje=det.id_viaje AND inter.campo='tipo_viaje' AND inter.valor_texto='Internacional'
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=det.id_viaje
INNER JOIN viajes_claros_detalle pa ON pa.id_viaje=det.id_viaje AND pa.campo='pais_destino'
WHERE det.campo='ciudad_destino'
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
/*!50003 DROP PROCEDURE IF EXISTS `grafica_ciudades_nacionales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `grafica_ciudades_nacionales`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_ciudades_nacionales`(idDependencia INT(10))
BEGIN
	
SELECT det.id_viaje, det.campo, det.valor_texto 
FROM viajes_claros_detalle det
INNER JOIN viajes_claros_detalle inter ON inter.id_viaje=det.id_viaje AND inter.campo='tipo_viaje' AND inter.valor_texto='Nacional'
INNER JOIN viajes_claros_instancias ins ON ins.id_viaje=det.id_viaje
WHERE det.campo='ciudad_destino'
AND ins.id_dependencia=idDependencia;	

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `grafica_funcionarios_mas_viajes_por_dep`;;
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
		AND i.id_dependencia=2
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
DROP PROCEDURE IF EXISTS `grafica_funcionarios_mayor_gasto_por_dep`;;
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
DROP PROCEDURE IF EXISTS `grafica_hoteles_por_dep`;;
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
/*!50003 DROP PROCEDURE IF EXISTS `grafica_porcentajes_viajes_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `grafica_porcentajes_viajes_funcionario`;;
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
				DATEDIFF(fin.valor_fecha, ini.valor_fecha) as dias_viaje, 
				DATEDIFF(NOW(), p.fecha_ingreso) as dias_desde_ingreso
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
				DATEDIFF(fin.valor_fecha, ini.valor_fecha) as dias_viaje, 
				DATEDIFF(NOW(), f.valor_fecha) as dias_desde_ingreso
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
/*!50003 DROP PROCEDURE IF EXISTS `grafica_tipo_pasaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `grafica_tipo_pasaje`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_tipo_pasaje`(idDependencia INT(10))
BEGIN
	
SELECT v.valor_texto, count(v.valor_texto)
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
/*!50003 DROP PROCEDURE IF EXISTS `grafica_tipo_viaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `grafica_tipo_viaje`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_tipo_viaje`(idDependencia INT)
BEGIN

	
SELECT v.valor_texto, count(v.valor_texto)
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
/*!50003 DROP PROCEDURE IF EXISTS `grafica_ultimos_viajes_por_area` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `grafica_ultimos_viajes_por_area`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_ultimos_viajes_por_area`(idArea INT(11))
BEGIN
	

SELECT i.id_viaje, DATE_FORMAT(i.fecha_publicacion, '%d/%m/%Y') fecha_publicacion,
	IFNULL(ev.valor_texto, '') as nombre_evento,
	IFNULL(pa.valor_texto, '') as pais_destino,
	IFNULL(cd.valor_texto, '') as ciudad_destino,
	IFNULL(costo.valor_numerico, 0) as costo_total
FROM viajes_claros_instancias i
INNER JOIN comisiones c ON c.id_comision=i.id_comision
INNER JOIN personas p ON p.id_persona=c.id_persona
INNER JOIN usuarios u ON u.id_persona=p.id_persona
LEFT JOIN viajes_claros_detalle costo ON costo.id_viaje=i.id_viaje AND costo.tabla='' AND costo.campo='costo_total'
LEFT JOIN viajes_claros_detalle cd ON cd.id_viaje=i.id_viaje AND cd.tabla='' AND cd.campo='ciudad_destino'
LEFT JOIN viajes_claros_detalle pa ON pa.id_viaje=i.id_viaje AND pa.tabla='' AND pa.campo='pais_destino'
LEFT JOIN viajes_claros_detalle ev ON ev.id_viaje=i.id_viaje AND ev.tabla='' AND ev.campo='nombre_evento'
WHERE u.id_area=idArea
ORDER BY i.fecha_publicacion DESC LIMIT 3
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `grafica_ultimos_viajes_por_dep`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_ultimos_viajes_por_dep`(IN idDependencia INT(11))
BEGIN

	

	select v.id_viaje, v.id_dependencia, DATE_FORMAT(v.fecha_publicacion, '%d/%m/%y') as fecha_publicacion, 
	0 as id_persona, ev.valor_texto as nombre_evento, pais.valor_texto as pais_destino, 
	cd.valor_texto as ciudad_destino
from viajes_claros_instancias v
INNER JOIN viajes_claros_detalle ev ON ev.id_viaje=v.id_viaje AND ev.campo='nombre_evento'
INNER JOIN viajes_claros_detalle pais ON pais.id_viaje=v.id_viaje AND pais.campo='pais_destino'
INNER JOIN viajes_claros_detalle cd ON cd.id_viaje=v.id_viaje AND cd.campo='ciudad_destino'
WHERE v.id_dependencia=idDependencia
ORDER BY v.fecha_publicacion DESC LIMIT 3;

	
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
DROP PROCEDURE IF EXISTS `grafica_viajes_por_mes`;;
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
/*!50003 DROP PROCEDURE IF EXISTS `grafica_viaticos_por_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `grafica_viaticos_por_funcionario`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `grafica_viaticos_por_funcionario`(IN idPersona INT(11),
	inNombres VARCHAR(200), inApellido1 VARCHAR(200), inApellido2 VARCHAR(200))
BEGIN


IF idPersona > 0 THEN
	SELECT v.campo, SUM(v.valor_numerico)
	FROM viajes_claros_detalle v
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=v.id_viaje
	INNER JOIN comisiones c ON c.id_comision=i.id_comision
	WHERE v.campo='viaticos_comprobados'
	AND c.id_persona=idPersona
	GROUP BY c.id_persona
UNION ALL
	SELECT v.campo, SUM(v.valor_numerico)
	FROM viajes_claros_detalle v
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=v.id_viaje
	INNER JOIN comisiones c ON c.id_comision=i.id_comision
	WHERE v.campo='viaticos_sin_comprobar'
	AND c.id_persona=idPersona
	GROUP BY c.id_persona
UNION ALL
	SELECT v.campo, SUM(v.valor_numerico)
	FROM viajes_claros_detalle v
	INNER JOIN viajes_claros_instancias i ON i.id_viaje=v.id_viaje
	INNER JOIN comisiones c ON c.id_comision=i.id_comision
	WHERE v.campo='viaticos_devueltos'
	AND c.id_persona=idPersona
	GROUP BY c.id_persona;
	

ELSE

	SELECT 'Viáticos comprobados',
		IFNULL(SUM(v1.valor_numerico), 0) as valor
	FROM viajes_claros_instancias i
	INNER JOIN viajes_claros_detalle nom ON nom.id_viaje=i.id_viaje AND nom.tabla='personas' AND nom.campo='nombres'
	INNER JOIN viajes_claros_detalle ap1 ON ap1.id_viaje=i.id_viaje AND ap1.tabla='personas' AND ap1.campo='apellido_paterno'
	LEFT JOIN viajes_claros_detalle ap2 ON ap2.id_viaje=i.id_viaje AND ap2.tabla='personas' AND ap2.campo='apellido_materno'
	LEFT JOIN viajes_claros_detalle v1 ON v1.id_viaje=i.id_viaje AND v1.tabla='' AND v1.campo='viaticos_comprobados'
	WHERE nom.valor_texto=inNombres
	AND ap1.valor_texto=inApellido1
	AND IF(ap2.valor_texto is null, '', ap2.valor_texto)=inApellido2
UNION ALL
	SELECT 'Viáticos sin comprobar',
		IFNULL(SUM(v2.valor_numerico), 0) as valor
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
		IFNULL(SUM(v3.valor_numerico), 0) as valor
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
DROP PROCEDURE IF EXISTS `inserta_archivos_procesados`;;
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
DROP PROCEDURE IF EXISTS `inserta_archivos_procesados_det`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `insert_buscador_despliegue_config`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_buscador_despliegue_config`(idDep INT, nombreTabla VARCHAR(50), nombreCampo VARCHAR(50))
BEGIN
	
	INSERT INTO buscador_despliegue_config(id_dependencia, tabla, campo)
	VALUES(idDep, nombreTabla, nombreCampo);
	
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `insert_buscador_filtros_config`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_buscador_filtros_config`(IN idDep INT(10), IN nombreTabla VARCHAR(50), IN nombreCampo VARCHAR(50), IN operador VARCHAR(50))
BEGIN
	
	
	SET @tipoControl = (SELECT CASE WHEN base.tipo_control IS NULL THEN din.tipo_control ELSE base.tipo_control END as tipo_control
		FROM viajes_claros_config c
		LEFT JOIN campos_base base ON base.tabla = c.tabla AND base.campo = c.campo
		LEFT JOIN campos_dinamicos din ON din.nombre_campo = c.campo
		WHERE c.campo=nombreCampo AND c.tabla=nombreTabla);
		
	SET @operador = (SELECT CASE WHEN @tipoControl=1 THEN 'LIKE' ELSE 
					(CASE WHEN @tipoControl=2 THEN '=' ELSE operador END) END);	
	
		
	INSERT INTO buscador_filtros_config
	(id_dependencia, tabla, campo, operador)
	VALUES(idDep, nombreTabla, nombreCampo, @operador);
	
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
DROP PROCEDURE IF EXISTS `insert_campo_dinamico`;;
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
/*!50003 DROP PROCEDURE IF EXISTS `insert_comisiones_detalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `insert_comisiones_detalle`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_comisiones_detalle`(IN idCom INT(11), IN tabla VARCHAR(50), 
IN campo VARCHAR(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN
INSERT INTO comisiones_detalle VALUES(DEFAULT, idCom, tabla, campo, valorTexto, valorNumerico, valorFecha);
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `insert_flujos_campos_config`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_flujos_campos_config`(
		IN idFlujo INT(11), IN idTipoPersona INT(11), 
		IN inTabla VARCHAR(200), IN inCampo VARCHAR(200), 
		IN inEtiqueta VARCHAR(200), IN listaHabilitada TINYINT(3), 
		IN inObligatorio TINYINT(3), IN idSeccion INT(11), IN inOrden INT(11))
BEGIN

	
INSERT INTO flujos_campos_config
(id_flujo, tabla, campo, etiqueta, lista_habilitada, obligatorio, id_tipo_persona, id_seccion_formulario, orden)
VALUES(idFlujo, inTabla, inCampo, inEtiqueta, listaHabilitada, inObligatorio, idTipoPersona, idSeccion, inOrden);

	
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
DROP PROCEDURE IF EXISTS `insert_grafica_config`;;
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
DROP PROCEDURE IF EXISTS `insert_interfaz_config`;;
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
DROP PROCEDURE IF EXISTS `insert_listas_valores`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `insert_secciones_formulario`;;
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
DROP PROCEDURE IF EXISTS `insert_suscripcion_config`;;
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
DROP PROCEDURE IF EXISTS `insert_suscripcion_email_config`;;
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
DROP PROCEDURE IF EXISTS `insert_valores_dinamicos`;;
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
DROP PROCEDURE IF EXISTS `insert_viajes_claros_config`;;
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
DROP PROCEDURE IF EXISTS `obtener_categoria`;;
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
DROP PROCEDURE IF EXISTS `obten_area`;;
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
DROP PROCEDURE IF EXISTS `obten_areas`;;
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
DROP PROCEDURE IF EXISTS `obten_bitacora`;;
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
DROP PROCEDURE IF EXISTS `obten_categorias`;;
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
DROP PROCEDURE IF EXISTS `obten_ciudad`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_ciudad`(id integer)
BEGIN
	select id_ciudad, nombre_ciudad, id_pais, id_estado
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
DROP PROCEDURE IF EXISTS `obten_ciudades`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_ciudades`()
BEGIN
	select id_ciudad, nombre_ciudad, id_pais, id_estado
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
DROP PROCEDURE IF EXISTS `obten_dependencia`;;
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
DROP PROCEDURE IF EXISTS `obten_dependencias`;;
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
DROP PROCEDURE IF EXISTS `obten_dependencia_by_Id`;;
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
DROP PROCEDURE IF EXISTS `obten_errores_carga`;;
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
DROP PROCEDURE IF EXISTS `obten_estado`;;
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
DROP PROCEDURE IF EXISTS `obten_estados`;;
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
DROP PROCEDURE IF EXISTS `obten_id_viaje`;;
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
DROP PROCEDURE IF EXISTS `obten_jerarquia`;;
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
DROP PROCEDURE IF EXISTS `obten_jerarquias`;;
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
DROP PROCEDURE IF EXISTS `obten_layout`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_layout`()
BEGIN
	select tabla, campo, lista_habilitada, etiqueta, secuencia, null tipo_dato
	from `viajes_claros`.`interfaz_config` 
	where 1=1
	order by secuencia;

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
DROP PROCEDURE IF EXISTS `obten_miembro`;;
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
DROP PROCEDURE IF EXISTS `obten_miembros`;;
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
DROP PROCEDURE IF EXISTS `obten_pais`;;
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
DROP PROCEDURE IF EXISTS `obten_paises`;;
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
DROP PROCEDURE IF EXISTS `obten_perfil`;;
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
DROP PROCEDURE IF EXISTS `obten_perfiles`;;
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
DROP PROCEDURE IF EXISTS `obten_persona`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_persona`(id int(11))
BEGIN
	select id_persona, nombres, apellido_paterno, apellido_materno, titulo
		  ,email, id_categoria, id_tipo_persona, id_posicion
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
DROP PROCEDURE IF EXISTS `obten_personas`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_personas`()
BEGIN
	select id_persona, nombres, apellido_paterno, apellido_materno, titulo
		  ,email, id_categoria, id_tipo_persona, id_posicion
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
DROP PROCEDURE IF EXISTS `obten_posicion`;;
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
DROP PROCEDURE IF EXISTS `obten_posiciones`;;
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
DROP PROCEDURE IF EXISTS `obten_proceso`;;
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
DROP PROCEDURE IF EXISTS `obten_procesos`;;
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
DROP PROCEDURE IF EXISTS `obten_tipo_persona`;;
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
DROP PROCEDURE IF EXISTS `obten_tipo_personas`;;
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
DROP PROCEDURE IF EXISTS `obten_usuario`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_usuario`(id integer)
BEGIN
	select id_usuario, usuario, contrasena, salt, descripcion, habilitado, intentos
		  ,id_perfil, id_dependencia, id_persona, id_area, jefe_area
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
DROP PROCEDURE IF EXISTS `obten_usuarios`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_usuarios`()
BEGIN
	select id_usuario, usuario, contrasena, salt, descripcion, habilitado, intentos
		  ,id_perfil, id_dependencia, id_persona, id_area, jefe_area
	from `viajes_claros`.`usuarios`
	order by usuario;

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
DROP PROCEDURE IF EXISTS `obten_usuario_by_str`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_usuario_by_str`(us text)
BEGIN
	select id_usuario, usuario, contrasena, salt, descripcion, habilitado, intentos
		  ,id_perfil, id_dependencia, id_persona, id_area, jefe_area
	from `viajes_claros`.`usuarios`
	where 1=1
	and usuario = us;

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
DROP PROCEDURE IF EXISTS `obten_viajes_fecha`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_viajes_fecha`(fecha_salida datetime)
BEGIN
	select * from `viajes_claros`.`viajes_claros_detalle`
	where valor_fecha = fecha_salida;

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
DROP PROCEDURE IF EXISTS `obten_viaje_x_id`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_viaje_x_id`(id int(11))
BEGIN
	select * from `viajes_claros`.`viajes_claros_detalle`
	where valor_fecha = fecha_salida;

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
DROP PROCEDURE IF EXISTS `update_campo_dinamico`;;
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
/*!50003 DROP PROCEDURE IF EXISTS `update_comision_detalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `update_comision`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_comision`(IN idComision INT(11),nuevoEstatus varchar(2))
BEGIN	
	UPDATE comisiones SET estatus = nuevoEstatus WHERE id_comision = idComision;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `update_flujos_campos_config`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_flujos_campos_config`(
	IN idFlujo INT(11), IN idTipoPersona INT(11), 
	IN inTabla VARCHAR(200), IN inCampo VARCHAR(200), 
	IN inEtiqueta VARCHAR(200), IN listaHabilitada TINYINT(3), 
	IN inObligatorio TINYINT(3), IN idSeccion INT(11), inOrden INT(11))
BEGIN
	
UPDATE flujos_campos_config
SET etiqueta=inEtiqueta, lista_habilitada=listaHabilitada, obligatorio=inObligatorio,
	id_seccion_formulario=idSeccion, orden=inOrden
WHERE id_flujo=idFlujo AND id_tipo_persona=idTipoPersona AND tabla=inTabla AND campo=inCampo;


	
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
DROP PROCEDURE IF EXISTS `update_interfaz_config`;;
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
DROP PROCEDURE IF EXISTS `update_listas_valores`;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
DROP PROCEDURE IF EXISTS `update_seccion_formulario`;;
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
DROP PROCEDURE IF EXISTS `update_valor_dinamico`;;
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
DROP PROCEDURE IF EXISTS `valida_dato`;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `valida_dato`(tabla text, campo text, filtro text)
BEGIN
   if tabla is not null then
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

-- Dump completed on 2015-12-15 23:00:54

DELIMITER $$


DROP PROCEDURE IF EXISTS `get_gastos_campos_config`$$
DELIMITER $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_gastos_campos_config`()
BEGIN

SELECT g.campo, g.etiqueta, 
	g.lista_habilitada, g.obligatorio,g.orden, d.id_lista,
	CASE WHEN d.tipo_control=1 THEN 'TEXTO' 
		ELSE CASE WHEN d.tipo_control=2 THEN 'LISTA'
			ELSE CASE WHEN d.tipo_control=3 THEN 'CALENDARIO'
				ELSE 'OTRO' END END END as tipo_control,
	CASE WHEN d.tipo_dato=1 THEN 'NUMERO' 
		ELSE (CASE WHEN d.tipo_dato=2 THEN 'TEXTO' 
			ELSE (CASE WHEN d.tipo_dato=3 THEN 'FECHA' 
				ELSE 'UNDEFINED' END)  END) END as tipo_dato,
                g.subtipo
FROM gastos_campos_config g
LEFT JOIN campos_dinamicos d ON d.nombre_campo=g.campo
ORDER BY g.orden;

END$$
DELIMITER $$

DROP PROCEDURE IF EXISTS `get_gastos_campos_config_headers`$$
DELIMITER $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_gastos_campos_config_headers`()
BEGIN

SELECT g.etiqueta
FROM gastos_campos_config g
ORDER BY g.orden;

END$$
DELIMITER $$

DROP function IF EXISTS `inserta_registro_gasto_comision`$$
DELIMITER $$
CREATE  DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_registro_gasto_comision`(idComision integer) RETURNS int(11)
BEGIN
	INSERT INTO `viajes_claros`.`registros_gastos_comision` VALUES(default, idComision);
	RETURN LAST_INSERT_ID();
END$$
DELIMITER $$


DROP PROCEDURE IF EXISTS `insert_comisiones_desglose_gastos`$$
DELIMITER $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_comisiones_desglose_gastos`(IN idCom INT(11), IN idRegistroGasto INT(11), 
IN campo VARCHAR(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN
INSERT INTO comisiones_desglose_gastos VALUES(DEFAULT, idCom, NULL, campo, valorTexto, valorNumerico, valorFecha,idRegistroGasto);
END$$
DELIMITER $$

DROP PROCEDURE IF EXISTS `get_comision_desglose_gastos_id_comision`$$
DELIMITER $$

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
END$$
DELIMITER $$

DROP PROCEDURE IF EXISTS `get_comision_desglose_gastos_id_registro_gasto`$$
DELIMITER $$
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
END$$
DELIMITER $$


DROP PROCEDURE IF EXISTS `update_comision_desglose_gastos`$$
DELIMITER $$

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_comision_desglose_gastos`(IN idComision INT(11),IN idRegistro INT(11),IN camp varchar(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN	
	UPDATE comisiones_desglose_gastos SET valor_texto = valorTexto, valor_numerico = valorNumerico, valor_fecha = valorFecha WHERE id_comision = idComision AND id_registro_gasto_comision = idRegistro AND campo=camp;
END$$
DELIMITER $$

DROP PROCEDURE IF EXISTS `get_desglose_gastos_id_comision`$$
DELIMITER $$

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_desglose_gastos_id_comision`(IN idComision INT(11),IN idRegistroGastoComision INT(11),IN campo varchar(50),IN tipoValor tinyint(4))
BEGIN	
SELECT 
	CASE WHEN tipoValor=1 THEN cdg.valor_numerico 
		ELSE (CASE WHEN tipoValor=2 THEN cdg.valor_texto
			ELSE (CASE WHEN tipoValor=3 THEN cdg.valor_fecha
				ELSE 'UNDEFINED' END)  END) END as valor_campo
FROM comisiones_desglose_gastos cdg
WHERE cdg.id_comision=idComision AND cdg.id_registro_gasto_comision=idRegistroGastoComision AND cdg.campo = campo;
END$$
DELIMITER $$

DROP PROCEDURE IF EXISTS `delete_registro_gastos_id_comision`$$
DELIMITER $$

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_registro_gastos_id_comision`(IN idComision INT(11),IN idRegistroGastoComision INT(11))
BEGIN	
DELETE FROM comisiones_desglose_gastos WHERE id_registro_gasto_comision=idRegistroGastoComision;
DELETE FROM registros_gastos_comision WHERE id_comision = idComision AND id_registro_gasto_comision=idRegistroGastoComision;
END$$
DELIMITER $$

DELIMITER ;;
use viajes_claros;;
DROP PROCEDURE IF EXISTS `get_detalle_usuario_por_nombre_usuario`;;
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

END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_flujos_campos_config_por_id_flujo_tipo_persona`;;

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
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_secciones_formulario_por_id_flujo`;;
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


END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_flujos_campos_config_por_flujo_tipo_persona_seccion`;;
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

END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_comisiones_en_curso_por_id_persona`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_comisiones_en_curso_por_id_persona`(idPersona INT(11))
BEGIN

	
SELECT c.id_comision, c.estatus, c.id_dependencia, c.id_persona, c.id_usuario
FROM comisiones c
WHERE id_persona=idPersona
AND estatus != 'P'
ORDER BY c.id_comision;

END;;
DELIMITER ;;

DROP FUNCTION IF EXISTS `inserta_comision`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_comision`(est text,idDep integer,idPers integer,idUsr integer) RETURNS int(11)
BEGIN
	INSERT INTO `viajes_claros`.`comisiones` VALUES(default, est, idDep, idPers, idUsr);
	RETURN LAST_INSERT_ID();
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `insert_comisiones_detalle`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_comisiones_detalle`(IN idCom INT(11), IN tabla VARCHAR(50), 
	IN campo VARCHAR(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN
INSERT INTO comisiones_detalle VALUES(DEFAULT, idCom, tabla, campo, valorTexto, valorNumerico, valorFecha);
END;;
DELIMITER ;;


DROP PROCEDURE IF EXISTS `get_comisiones_detalle_por_id_comision`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_comisiones_detalle_por_id_comision`(idPersona INT(11))
BEGIN

	
SELECT c.id_comision, c.estatus, c.id_dependencia, c.id_persona, c.id_usuario
FROM comisiones c

WHERE id_persona=idPersona
AND estatus != 'P'
ORDER BY c.id_comision;

END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_comision_detalle_id_comision`;;
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
END;;
DELIMITER ;;


DROP PROCEDURE IF EXISTS `update_comision_detalle`;;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_comision_detalle`(IN idComision INT(11),IN tab varchar(50),IN camp varchar(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN	
	UPDATE comisiones_detalle SET valor_texto = valorTexto, valor_numerico = valorNumerico, valor_fecha = valorFecha WHERE id_comision = idComision AND tabla = tab AND campo=camp;
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `update_comision`;;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_comision`(IN idComision INT(11),nuevoEstatus varchar(2))
BEGIN	
	UPDATE comisiones SET estatus = nuevoEstatus WHERE id_comision = idComision;
END;;
DELIMITER ;;


DROP PROCEDURE IF EXISTS `get_gastos_campos_config`;;
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

END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_gastos_campos_config_headers`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_gastos_campos_config_headers`()
BEGIN

SELECT g.etiqueta
FROM gastos_campos_config g
ORDER BY g.orden;

END;;
DELIMITER ;;

DROP function IF EXISTS `inserta_registro_gasto_comision`;;
DELIMITER ;;
CREATE  DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_registro_gasto_comision`(idComision integer) RETURNS int(11)
BEGIN
	INSERT INTO `viajes_claros`.`registros_gastos_comision` VALUES(default, idComision);
	RETURN LAST_INSERT_ID();
END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS `insert_comisiones_desglose_gastos`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_comisiones_desglose_gastos`(IN idCom INT(11), IN idRegistroGasto INT(11), 
IN campo VARCHAR(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN
INSERT INTO comisiones_desglose_gastos VALUES(DEFAULT, idCom, NULL, campo, valorTexto, valorNumerico, valorFecha,idRegistroGasto);
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_comision_desglose_gastos_id_comision`;;
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
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_comision_desglose_gastos_id_registro_gasto`;;
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
END;;
DELIMITER ;;


DROP PROCEDURE IF EXISTS `update_comision_desglose_gastos`;;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_comision_desglose_gastos`(IN idComision INT(11),IN idRegistro INT(11),IN camp varchar(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN	
	UPDATE comisiones_desglose_gastos SET valor_texto = valorTexto, valor_numerico = valorNumerico, valor_fecha = valorFecha WHERE id_comision = idComision AND id_registro_gasto_comision = idRegistro AND campo=camp;
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_desglose_gastos_id_comision`;;
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
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `delete_registro_gastos_id_comision`;;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_registro_gastos_id_comision`(IN idComision INT(11),IN idRegistroGastoComision INT(11))
BEGIN	
DELETE FROM comisiones_desglose_gastos WHERE id_registro_gasto_comision=idRegistroGastoComision;
DELETE FROM registros_gastos_comision WHERE id_comision = idComision AND id_registro_gasto_comision=idRegistroGastoComision;
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_registros_gastos_por_id_comision`;;
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

END;;
DELIMITER ;;

use viajes_claros;;
DROP PROCEDURE IF EXISTS `get_detalle_usuario_por_nombre_usuario`;;
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

END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_flujos_campos_config_por_id_flujo_tipo_persona`;;

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
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_secciones_formulario_por_id_flujo`;;
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


END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_flujos_campos_config_por_flujo_tipo_persona_seccion`;;
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

END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_comisiones_en_curso_por_id_persona`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_comisiones_en_curso_por_id_persona`(idPersona INT(11))
BEGIN

	
SELECT c.id_comision, c.estatus, c.id_dependencia, c.id_persona, c.id_usuario
FROM comisiones c
WHERE id_persona=idPersona
AND estatus != 'P'
ORDER BY c.id_comision;

END;;
DELIMITER ;;

DROP FUNCTION IF EXISTS `inserta_comision`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_comision`(est text,idDep integer,idPers integer,idUsr integer) RETURNS int(11)
BEGIN
	INSERT INTO `viajes_claros`.`comisiones` VALUES(default, est, idDep, idPers, idUsr);
	RETURN LAST_INSERT_ID();
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `insert_comisiones_detalle`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_comisiones_detalle`(IN idCom INT(11), IN tabla VARCHAR(50), 
IN campo VARCHAR(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN
IF ((valorTexto IS NOT NULL OR valorFecha IS NOT NULL) AND valorNumerico = 0) THEN
	INSERT INTO comisiones_detalle VALUES(DEFAULT, idCom, tabla, campo, valorTexto, NULL, valorFecha);
ELSE 
	INSERT INTO comisiones_detalle VALUES(DEFAULT, idCom, tabla, campo, valorTexto, valorNumerico, valorFecha);
END IF;
END;;
DELIMITER ;;


DROP PROCEDURE IF EXISTS `get_comisiones_detalle_por_id_comision`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_comisiones_detalle_por_id_comision`(idPersona INT(11))
BEGIN

	
SELECT c.id_comision, c.estatus, c.id_dependencia, c.id_persona, c.id_usuario
FROM comisiones c

WHERE id_persona=idPersona
AND estatus != 'P'
ORDER BY c.id_comision;

END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_comision_detalle_id_comision`;;
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
END;;
DELIMITER ;;


DROP PROCEDURE IF EXISTS `update_comision_detalle`;;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_comision_detalle`(IN idComision INT(11),IN tab varchar(50),IN camp varchar(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN	
IF ((valorTexto IS NOT NULL OR valorFecha IS NOT NULL) AND valorNumerico = 0) THEN
	UPDATE comisiones_detalle SET valor_texto = valorTexto, valor_numerico = NULL, valor_fecha = valorFecha WHERE id_comision = idComision AND tabla = tab AND campo=camp;
ELSE 
	UPDATE comisiones_detalle SET valor_texto = valorTexto, valor_numerico = valorNumerico, valor_fecha = valorFecha WHERE id_comision = idComision AND tabla = tab AND campo=camp;
END IF;
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `update_comision`;;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_comision`(IN idComision INT(11),nuevoEstatus varchar(2))
BEGIN	
	UPDATE comisiones SET estatus = nuevoEstatus WHERE id_comision = idComision;
END;;
DELIMITER ;;


DROP PROCEDURE IF EXISTS `get_gastos_campos_config`;;
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

END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_gastos_campos_config_headers`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_gastos_campos_config_headers`()
BEGIN

SELECT g.etiqueta
FROM gastos_campos_config g
ORDER BY g.orden;

END;;
DELIMITER ;;

DROP function IF EXISTS `inserta_registro_gasto_comision`;;
DELIMITER ;;
CREATE  DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_registro_gasto_comision`(idComision integer) RETURNS int(11)
BEGIN
	INSERT INTO `viajes_claros`.`registros_gastos_comision` VALUES(default, idComision);
	RETURN LAST_INSERT_ID();
END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS `insert_comisiones_desglose_gastos`;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_comisiones_desglose_gastos`(IN idCom INT(11), IN idRegistroGasto INT(11), 
IN campo VARCHAR(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN
IF ((valorTexto IS NOT NULL OR valorFecha IS NOT NULL) AND valorNumerico = 0) THEN
	INSERT INTO comisiones_desglose_gastos VALUES(DEFAULT, idCom, NULL, campo, valorTexto, NULL, valorFecha,idRegistroGasto);
ELSE 
	INSERT INTO comisiones_desglose_gastos VALUES(DEFAULT, idCom, NULL, campo, valorTexto, valorNumerico, valorFecha,idRegistroGasto);
END IF;
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_comision_desglose_gastos_id_comision`;;
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
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_comision_desglose_gastos_id_registro_gasto`;;
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
END;;
DELIMITER ;;


DROP PROCEDURE IF EXISTS `update_comision_desglose_gastos`;;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_comision_desglose_gastos`(IN idComision INT(11),IN idRegistro INT(11),IN camp varchar(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN	
IF ((valorTexto IS NOT NULL OR valorFecha IS NOT NULL) AND valorNumerico = 0) THEN
	UPDATE comisiones_desglose_gastos SET valor_texto = valorTexto, valor_numerico = NULL, valor_fecha = valorFecha WHERE id_comision = idComision AND id_registro_gasto_comision = idRegistro AND campo=camp;
ELSE 
	UPDATE comisiones_desglose_gastos SET valor_texto = valorTexto, valor_numerico = valorNumerico, valor_fecha = valorFecha WHERE id_comision = idComision AND id_registro_gasto_comision = idRegistro AND campo=camp;
END IF;
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_desglose_gastos_id_comision`;;
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
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `delete_registro_gastos_id_comision`;;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_registro_gastos_id_comision`(IN idComision INT(11),IN idRegistroGastoComision INT(11))
BEGIN	
DELETE FROM comisiones_desglose_gastos WHERE id_registro_gasto_comision=idRegistroGastoComision;
DELETE FROM registros_gastos_comision WHERE id_comision = idComision AND id_registro_gasto_comision=idRegistroGastoComision;
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_registros_gastos_por_id_comision`;;
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

END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_flujos_comision_reporte`;;
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
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_reporte_comision_por_flujo`;;
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
END;;
DELIMITER ;;

DELIMITER $$

USE viajes_claros$$

DROP PROCEDURE IF EXISTS viajes_claros.`tiene_layout` $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `tiene_layout`(id_dep int(11)) 

BEGIN
   
	  select count(*)
	  from viajes_claros.interfaz_config ic       
      where 1=1
	  and ic.id_dependencia = id_dep;
    
END$$

DROP PROCEDURE IF EXISTS viajes_claros.`obten_layout` $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_layout`(id_dep int(11))

BEGIN
	select tabla, campo, lista_habilitada, etiqueta, secuencia, null tipo_dato
	from `viajes_claros`.`interfaz_config` 
	where 1=1
    and id_dependencia = id_dep
	order by secuencia;

END$$

DROP PROCEDURE IF EXISTS viajes_claros.`obten_interfaz_carga` $$
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
	union all
	select ic.tabla, ic.campo, ic.lista_habilitada, etiqueta, secuencia, null
		from `viajes_claros`.`interfaz_config` ic 
        where 1=1
        and ic.etiqueta = 'Operacion'
	order by secuencia;

END$$

DROP PROCEDURE IF EXISTS viajes_claros.`valida_dato` $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `valida_dato`(tabla text, campo text, filtro text) 

BEGIN
   if tabla is not null then
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
    
END$$

DROP PROCEDURE IF EXISTS viajes_claros.`obten_id_dependencia` $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_id_dependencia`(siglas_dep text) 

BEGIN
	select id_dependencia
	from `viajes_claros`.`dependencias`
	where 1=1
	and siglas = siglas_dep;
    
END$$

DROP PROCEDURE IF EXISTS viajes_claros.`obten_id_viaje` $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_id_viaje`(id_arch bigint) 

BEGIN
	select id_viaje
	from `viajes_claros`.`viajes_claros_instancias`
	where 1=1
	and id_archivo = id_arch;
    
END$$

DROP PROCEDURE IF EXISTS viajes_claros.`obten_bitacora` $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_bitacora`(id_arch bigint)

BEGIN
	select id_archivo, nombre_archivo, fecha_carga, total_registros, total_aceptados, total_rechazados
	from `viajes_claros`.`archivos_procesados`
	where 1=1
	and id_archivo = id_arch;

END$$

DROP PROCEDURE IF EXISTS viajes_claros.`obten_errores_carga` $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_errores_carga`(id_arch bigint)

BEGIN
	select id_error, id_archivo, id_linea, estatus, comentarios
	from `viajes_claros`.`archivo_lineas` 
	where 1=1
    and id_archivo = id_arch;

END$$

DROP FUNCTION IF EXISTS viajes_claros.`inserta_viajes_claros_instancias` $$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_viajes_claros_instancias`(id_dep int(11), id_arch bigint) RETURNS int(11)

BEGIN
	/*declare vn_existe	int;

	select count(*)
	into vn_existe
	from `viajes_claros`.`viajes_claros_instancias`
	where 1=1
	and id_dependencia = id_dep
    and id_archivo = id_arch;

	if vn_existe > 0 then
		return -1;
	else*/
		insert into `viajes_claros`.`viajes_claros_instancias`
		values (default, id_dep, now(), null, id_arch);
		
		return LAST_INSERT_ID();
	-- end if;

END$$

DROP FUNCTION IF EXISTS viajes_claros.`inserta_viajes_claros_det` $$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_viajes_claros_det`(id_viaje int(11), tabla text, campo text, valorT text, valorN double, valorF DateTime) RETURNS int(11)

BEGIN

		insert into `viajes_claros`.`viajes_claros_detalle`
		values (id_viaje, tabla, campo, valorT, valorN, valorF);
		
		return 0;

END$$

DROP FUNCTION IF EXISTS viajes_claros.`elimina_viajes_claros_det` $$
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

END$$

DROP FUNCTION IF EXISTS viajes_claros.`actualiza_viajes_claros_det` $$
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

END$$

DROP PROCEDURE IF EXISTS viajes_claros.`inserta_archivos_procesados` $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `inserta_archivos_procesados`(id_arch bigint, nom_archivo text)

BEGIN
	insert into `viajes_claros`.`archivos_procesados`
	values (id_arch, nom_archivo, now(), 0, 0, 0);
    commit;

END$$

DROP FUNCTION IF EXISTS viajes_claros.`actualiza_archivos_procesados` $$
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

END$$

DROP PROCEDURE IF EXISTS viajes_claros.`inserta_archivos_procesados_det` $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `inserta_archivos_procesados_det`(id_arch bigint, num_reg int(11), error text)

BEGIN
	insert into `viajes_claros`.`archivo_lineas`
	values (default, id_arch, num_reg, null, error);
    commit;

END$$

DROP PROCEDURE IF EXISTS viajes_claros.`elimina_procesados_det` $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `elimina_procesados_det`(id_arch bigint)

BEGIN
	delete from `viajes_claros`.`archivo_lineas`
	where id_archivo = id_arch;

END$$

DROP PROCEDURE IF EXISTS viajes_claros.`obten_viajes_fecha` $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_viajes_fecha`(fecha_salida datetime)

BEGIN
	select distinct id_viaje from `viajes_claros`.`viajes_claros_detalle`
	where valor_fecha = fecha_salida
    and campo = 'fecha_hora_salida';

END$$

DROP PROCEDURE IF EXISTS viajes_claros.`obten_viaje_x_id` $$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_viaje_x_id`(id int(11))

BEGIN
	select * from `viajes_claros`.`viajes_claros_detalle`
	where id_viaje = id;

END$$

-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

USE viajes_claros$$

DROP FUNCTION IF EXISTS `viajes_claros`.`valida_usuario`$$
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
END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`inserta_categoria`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_categoria`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_categoria`(id int, nombre text, hospedaje double, viaticos double) RETURNS int(11)

BEGIN
	update `viajes_claros`.`categoria`
	set nombre_categoria = nombre
	   ,tope_hospedaje = hospedaje
	   ,tope_viaticos = viaticos
	where id_categoria = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`elimina_categoria`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_categoria`(id int) RETURNS int(11)

BEGIN
	delete
	from `viajes_claros`.`categoria`
	where id_categoria = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`inserta_persona`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_persona`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`elimina_persona`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_persona`(id int) RETURNS int(11)

BEGIN
	delete
	from `viajes_claros`.`personas`
	where id_persona = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`inserta_dependencia`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_dependencia`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`elimina_dependencia`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_dependencia`(id int) RETURNS int(11)

BEGIN
	delete
	from `viajes_claros`.`dependencias`
	where id_dependencia = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`inserta_area`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_area`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_area`(id integer, nombre text, id_dep integer) RETURNS int(11)

BEGIN
	update `viajes_claros`.`areas`
	set nombre_area = nombre
	   ,id_dependencia = id_dep
	where 1=1
    and id_area = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`elimina_area`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_area`(id int) RETURNS int(11)

BEGIN
	delete
	from `viajes_claros`.`areas`
	where id_area = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`inserta_pais`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_pais`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`elimina_pais`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_pais`(id int) RETURNS int(11)

BEGIN
	delete
	from `viajes_claros`.`paises`
	where id_pais = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`inserta_estado`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_estado`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_estado`(id integer, nombre text, pais integer) RETURNS int(11)

BEGIN
	update `viajes_claros`.`estados`
	set nombre_estado = nombre
	   ,id_pais = pais
	where 1=1
    and id_estado = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`elimina_estado`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_estado`(id int) RETURNS int(11)

BEGIN
	delete
	from `viajes_claros`.`estados`
	where id_estado = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`inserta_ciudad`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_ciudad`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`elimina_ciudad`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_ciudad`(id int) RETURNS int(11)

BEGIN
	delete
	from `viajes_claros`.`ciudades`
	where id_ciudad = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`inserta_usuario`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_usuario`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_id_bonita`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_id_bonita`(id int, bonita long) RETURNS int(11)

BEGIN
	update `viajes_claros`.`usuarios`
	set id_bonita = bonita
	where id_usuario = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`elimina_usuario`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_usuario`(id int) RETURNS int(11)

BEGIN
	delete
	from `viajes_claros`.`usuarios`
	where id_usuario = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_contra`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_contra`(id int, contra text, salt text) RETURNS int(11)

BEGIN
	update `viajes_claros`.`usuarios`
	set contrasena = contra
	    ,salt = salt
	where id_usuario = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`inserta_posicion`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_posicion`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`elimina_posicion`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_posicion`(id int) RETURNS int(11)

BEGIN
	delete
	from `viajes_claros`.`posiciones`
	where id_posicion = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`inserta_jerarquia`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_jerarquia`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`elimina_jerarquia`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_jerarquia`(id int) RETURNS int(11)

BEGIN
	delete
	from `viajes_claros`.`jerarquias`
	where id_jerarquia = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`inserta_miembro`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_miembro`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_miembro`(id integer, id_jerar integer, id_usu integer) RETURNS int(11)

BEGIN
	update `viajes_claros`.`jerarquia_miembros`
	set id_jerarquia = id_jerar
	   ,id_usuario = id_usu
	where id_miembro = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`elimina_miembro`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_miembro`(id int) RETURNS int(11)

BEGIN
	delete
	from `viajes_claros`.`jerarquia_miembros`
	where id_miembro = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`inserta_grupo_aprobacion`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_grupo_aprobacion`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`elimina_grupo_aprobacion`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `elimina_grupo_aprobacion`(id int) RETURNS int(11)

BEGIN
	delete
	from `viajes_claros`.`configuracion_aprobacion`
	where id_conf_aprobacion = id;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`inserta_instancia`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_instancia`(flujo integer, inst long, comis integer) RETURNS int(11)

BEGIN
	insert into `viajes_claros`.`flujos_instancias`
	values (inst, flujo, comis, now(), null, 0);

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_instancia`$$
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

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`inserta_bitacora`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_bitacora`(inst bigint,flujo integer,com integer
																	,func integer,resp text) RETURNS int(11)

BEGIN
	insert into `viajes_claros`.`aprobaciones_bitacora`
	values (inst, flujo, com, func, resp, now());

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`actualiza_edo_comision`$$
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `actualiza_edo_comision`(comision integer, edo text) RETURNS int(11)

BEGIN
	update `viajes_claros`.`comisiones`
	set estatus = edo
	where id_comision = comision;

	return 0;

END$$

DROP FUNCTION IF EXISTS `viajes_claros`.`publica_viaje`$$
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

END$$

-- Siguen los ABC
DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_categorias`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_categorias`()

BEGIN
	select id_categoria, nombre_categoria, tope_hospedaje, tope_viaticos
	from `viajes_claros`.`categoria`;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obtener_categoria`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obtener_categoria`(id int)

BEGIN
	select id_categoria, nombre_categoria, tope_hospedaje, tope_viaticos
	from `viajes_claros`.`categoria`
	where id_categoria = id;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_tipo_personas`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_tipo_personas`()

BEGIN
	select id_tipo, codigo_tipo, descripcion
	from `viajes_claros`.`tipo_persona`;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_tipo_persona`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_tipo_persona`(id integer)

BEGIN
	select id_tipo, codigo_tipo, descripcion
	from `viajes_claros`.`tipo_persona`
	where 1=1
	and id_tipo = id;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_perfiles`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_perfiles`()

BEGIN
	select id_perfil, nombre_perfil
	from `viajes_claros`.`perfiles`;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_perfil`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_perfil`(id integer)

BEGIN
	select id_perfil, nombre_perfil
	from `viajes_claros`.`perfiles`
	where 1=1
	and id_perfil = id;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_personas`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_personas`()

BEGIN
	select id_persona, nombres, apellido_paterno, apellido_materno, titulo
		  ,email, id_categoria, id_tipo_persona, id_posicion, cargo, fecha_ingreso
	from `viajes_claros`.`personas`;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_persona`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_persona`(id int(11))

BEGIN
	select id_persona, nombres, apellido_paterno, apellido_materno, titulo
		  ,email, id_categoria, id_tipo_persona, id_posicion, cargo, fecha_ingreso
	from `viajes_claros`.`personas`
	where 1=1
	and id_persona = id;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_dependencias`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_dependencias`()

BEGIN
	select id_dependencia, siglas, nombre_dependencia, predeterminada
	from `viajes_claros`.`dependencias`;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_dependencia_by_Id`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_dependencia_by_Id`(id integer)

BEGIN
	select id_dependencia, siglas, nombre_dependencia, predeterminada
	from `viajes_claros`.`dependencias`
	where 1=1
	and id_dependencia = id;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_areas`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_areas`()

BEGIN
	select id_area, nombre_area, id_dependencia
	from `viajes_claros`.`areas`;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_area`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_area`(id integer)

BEGIN
	select id_area, nombre_area, id_dependencia
	from `viajes_claros`.`areas`
	where 1=1
	and id_area = id;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_paises`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_paises`()

BEGIN
	select id_pais, clave_pais, nombre_pais, predeterminado
	from `viajes_claros`.`paises`;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_pais`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_pais`(id integer)

BEGIN
	select id_pais, clave_pais, nombre_pais, predeterminado
	from `viajes_claros`.`paises`
	where 1=1
	and id_pais = id;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_estados`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_estados`()

BEGIN
	select id_estado, nombre_estado, id_pais
	from `viajes_claros`.`estados`;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_estado`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_estado`(id integer)

BEGIN
	select id_estado, nombre_estado, id_pais
	from `viajes_claros`.`estados`
	where 1=1
	and id_estado = id;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_ciudades`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_ciudades`()

BEGIN
	select id_ciudad, nombre_ciudad, id_pais, id_estado, latitud, longitud
	from `viajes_claros`.`ciudades`;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_ciudad`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_ciudad`(id integer)

BEGIN
	select id_ciudad, nombre_ciudad, id_pais, id_estado, latitud, longitud
	from `viajes_claros`.`ciudades`
	where 1=1
	and id_ciudad = id;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_usuarios`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_usuarios`()

BEGIN
	select id_usuario, usuario, contrasena, salt, descripcion, habilitado, intentos
		  ,id_perfil, id_dependencia, id_persona, id_area, jefe_area, id_bonita
	from `viajes_claros`.`usuarios`
	order by usuario;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_usuario`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_usuario`(id integer)

BEGIN
	select id_usuario, usuario, contrasena, salt, descripcion, habilitado, intentos
		  ,id_perfil, id_dependencia, id_persona, id_area, jefe_area, id_bonita
	from `viajes_claros`.`usuarios`
	where 1=1
	and id_usuario = id;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_usuario_by_str`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_usuario_by_str`(us text)

BEGIN
	select id_usuario, usuario, contrasena, salt, descripcion, habilitado, intentos
		  ,id_perfil, id_dependencia, id_persona, id_area, jefe_area, id_bonita
	from `viajes_claros`.`usuarios`
	where 1=1
	and usuario = us;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_usuario_bonita`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_usuario_bonita`(id bigint)

BEGIN
	select id_usuario, usuario, contrasena, salt, descripcion, habilitado, intentos
		  ,id_perfil, id_dependencia, id_persona, id_area, jefe_area, id_bonita
	from `viajes_claros`.`usuarios`
	where 1=1
	and id_bonita = id;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_usuario_jefe_area`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_usuario_jefe_area`(depen integer, area integer)

BEGIN
	select id_usuario, usuario, contrasena, salt, descripcion, habilitado, intentos
		  ,id_perfil, id_dependencia, id_persona, id_area, jefe_area, id_bonita
	from `viajes_claros`.`usuarios`
	where 1=1
	and id_dependencia = depen
	and id_area = area
	and jefe_area = 1;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_posiciones`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_posiciones`()

BEGIN
	select id_posicion, nombre_posicion
	from `viajes_claros`.`posiciones`
	order by nombre_posicion;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_posicion`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_posicion`(id integer)

BEGIN
	select id_posicion, nombre_posicion
	from `viajes_claros`.`posiciones`
	where 1=1
	and id_posicion = id
	order by nombre_posicion;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_procesos`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_procesos`()

BEGIN
	select id_flujo, nombre_flujo, descripcion, version
	from `viajes_claros`.`flujos_trabajo`
	order by id_flujo;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_proceso`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_proceso`(id integer)

BEGIN
	select id_flujo, nombre_flujo, descripcion, version
	from `viajes_claros`.`flujos_trabajo`
	where 1=1
	and id_flujo = id
	order by id_flujo;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_jerarquias`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_jerarquias`()

BEGIN
	select id_jerarquia, nombre_jerarquia, editable
	from `viajes_claros`.`jerarquias`
	order by id_jerarquia;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_jerarquia`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_jerarquia`(id integer)

BEGIN
	select id_jerarquia, nombre_jerarquia, editable
	from `viajes_claros`.`jerarquias`
	where 1=1
	and id_jerarquia = id
	order by id_jerarquia;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_miembros`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_miembros`(id_jerar integer)

BEGIN
	select id_miembro, id_jerarquia, id_usuario
	from `viajes_claros`.`jerarquia_miembros`
	where 1=1
	and id_jerarquia = id_jerar
	order by id_miembro;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_miembro`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_miembro`(id integer)

BEGIN
	select id_miembro, id_jerarquia, id_usuario
	from `viajes_claros`.`jerarquia_miembros`
	where 1=1
	and id_miembro = id
	order by id_miembro;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_grupos_aprobacion`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_grupos_aprobacion`()

BEGIN
	select id_conf_aprobacion, nombre, id_flujo, id_dependencia, id_area, id_jerarquia, editable
	from `viajes_claros`.`configuracion_aprobacion`
	where 1=1
	order by id_conf_aprobacion;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_grupo_aprobacion`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_grupo_aprobacion`(id integer)

BEGIN
	select id_conf_aprobacion, nombre, id_flujo, id_dependencia, id_area, id_jerarquia, editable
	from `viajes_claros`.`configuracion_aprobacion`
	where 1=1
	and id_conf_aprobacion = id
	order by id_conf_aprobacion;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_grupo_aprobacion_by_area`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_grupo_aprobacion_by_area`(flujo integer, depen integer, area integer)

BEGIN
	select id_conf_aprobacion, nombre, id_flujo, id_dependencia, id_area, id_jerarquia, editable
	from `viajes_claros`.`configuracion_aprobacion`
	where 1=1
	and id_flujo = flujo
	and id_dependencia = depen
	and id_area = area;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_grupo_aprobacion_by_name`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_grupo_aprobacion_by_name`(nom text, flujo integer)

BEGIN
	select id_conf_aprobacion, nombre, id_flujo, id_dependencia, id_area, id_jerarquia, editable
	from `viajes_claros`.`configuracion_aprobacion`
	where 1=1
	and id_flujo = flujo
	and nombre like concat('%',nom,'%');

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_instancia`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_instancia`(id long)

BEGIN
	select id_flujo, id_instancia, id_comision, fecha_inicio, fecha_fin, asignado
	from `viajes_claros`.`flujos_instancias`
	where 1=1
	and id_instancia = id
	order by fecha_inicio desc;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_instancias`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_instancias`()

BEGIN
	select id_flujo, id_instancia, id_comision, fecha_inicio, fecha_fin, asignado
	from `viajes_claros`.`flujos_instancias`
	where 1=1
	order by fecha_inicio desc;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_instancia_by_usr`$$
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

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_seccs_notif_flujo`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_seccs_notif_flujo`(flujo integer)

BEGIN
	select id_seccion, etiqueta, nombre_seccion, id_flujo, orden_seccion
	from `viajes_claros`.`secciones_formulario`
	where 1=1
	and id_flujo = flujo
	order by orden_seccion;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_info_seccs_notif`$$
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

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`obten_mail_server`$$
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `obten_mail_server`()

BEGIN
	select id, host, puerto, usuario, password
	from `viajes_claros`.`smtp_config`;

END$$

DROP PROCEDURE IF EXISTS `viajes_claros`.`es_comision_nacional`$$
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

END$$

-- Siguen las consultas

GRANT EXECUTE ON FUNCTION viajes_claros.valida_usuario TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.inserta_categoria TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.actualiza_categoria TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.elimina_categoria TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.inserta_persona TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.actualiza_persona TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.elimina_persona TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.inserta_dependencia TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.actualiza_dependencia TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.elimina_dependencia TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.inserta_area TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.actualiza_area TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.elimina_area TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.inserta_pais TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.actualiza_pais TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.elimina_pais TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.inserta_estado TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.actualiza_estado TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.elimina_estado TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.inserta_ciudad TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.actualiza_ciudad TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.elimina_ciudad TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.inserta_usuario TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.actualiza_usuario TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.elimina_usuario TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.actualiza_contra TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.inserta_posicion TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.actualiza_posicion TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.elimina_posicion TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.inserta_jerarquia TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.actualiza_jerarquia TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.elimina_jerarquia TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.inserta_miembro TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.actualiza_miembro TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.elimina_miembro TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.inserta_grupo_aprobacion TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.actualiza_grupo_aprobacion TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON FUNCTION viajes_claros.elimina_grupo_aprobacion TO 'viajes_admin'@'localhost'$$

GRANT EXECUTE ON PROCEDURE viajes_claros.obten_categorias TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obtener_categoria TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_tipo_personas TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_tipo_personas TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_perfiles TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_perfil TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_personas TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_persona TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_dependencias TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_dependencia_by_Id TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_areas TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_area TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_paises TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_pais TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_estados TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_estado TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_ciudades TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_ciudad TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_usuarios TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_usuario TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_usuario_by_str TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_posiciones TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_posicion TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_procesos TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_proceso TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_jerarquias TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_jerarquia TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_miembros TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_miembro TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_grupos_aprobacion TO 'viajes_admin'@'localhost'$$
GRANT EXECUTE ON PROCEDURE viajes_claros.obten_grupo_aprobacion TO 'viajes_admin'@'localhost'$$

DELIMITER ;
use viajes_claros;
DROP PROCEDURE IF EXISTS `get_detalle_usuario_por_nombre_usuario`;
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

END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_flujos_campos_config_por_id_flujo_tipo_persona`;;

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
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_secciones_formulario_por_id_flujo`;;
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


END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_flujos_campos_config_por_flujo_tipo_persona_seccion`;;
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

END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_comisiones_en_curso_por_id_persona`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_comisiones_en_curso_por_id_persona`(idPersona INT(11))
BEGIN

	
SELECT c.id_comision, c.estatus, c.id_dependencia, c.id_persona, c.id_usuario
FROM comisiones c
WHERE id_persona=idPersona
AND estatus != 'P'
ORDER BY c.id_comision;

END;;
DELIMITER ;;

DROP FUNCTION IF EXISTS `inserta_comision`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_comision`(est text,idDep integer,idPers integer,idUsr integer) RETURNS int(11)
BEGIN
	INSERT INTO `viajes_claros`.`comisiones` VALUES(default, est, idDep, idPers, idUsr);
	RETURN LAST_INSERT_ID();
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `insert_comisiones_detalle`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_comisiones_detalle`(IN idCom INT(11), IN tabla VARCHAR(50), 
IN campo VARCHAR(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN
IF ((valorTexto IS NOT NULL OR valorFecha IS NOT NULL) AND valorNumerico = 0) THEN
	INSERT INTO comisiones_detalle VALUES(DEFAULT, idCom, tabla, campo, valorTexto, NULL, valorFecha);
ELSE 
	INSERT INTO comisiones_detalle VALUES(DEFAULT, idCom, tabla, campo, valorTexto, valorNumerico, valorFecha);
END IF;
END;;
DELIMITER ;;


DROP PROCEDURE IF EXISTS `get_comisiones_detalle_por_id_comision`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_comisiones_detalle_por_id_comision`(idPersona INT(11))
BEGIN

	
SELECT c.id_comision, c.estatus, c.id_dependencia, c.id_persona, c.id_usuario
FROM comisiones c

WHERE id_persona=idPersona
AND estatus != 'P'
ORDER BY c.id_comision;

END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_comision_detalle_id_comision`;;
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
END;;
DELIMITER ;;


DROP PROCEDURE IF EXISTS `update_comision_detalle`;;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_comision_detalle`(IN idComision INT(11),IN tab varchar(50),IN camp varchar(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN	
IF ((valorTexto IS NOT NULL OR valorFecha IS NOT NULL) AND valorNumerico = 0) THEN
	UPDATE comisiones_detalle SET valor_texto = valorTexto, valor_numerico = NULL, valor_fecha = valorFecha WHERE id_comision = idComision AND tabla = tab AND campo=camp;
ELSE 
	UPDATE comisiones_detalle SET valor_texto = valorTexto, valor_numerico = valorNumerico, valor_fecha = valorFecha WHERE id_comision = idComision AND tabla = tab AND campo=camp;
END IF;
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `update_comision`;;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_comision`(IN idComision INT(11),nuevoEstatus varchar(2))
BEGIN	
	UPDATE comisiones SET estatus = nuevoEstatus WHERE id_comision = idComision;
END;;
DELIMITER ;;


DROP PROCEDURE IF EXISTS `get_gastos_campos_config`;;
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

END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_gastos_campos_config_headers`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_gastos_campos_config_headers`()
BEGIN

SELECT g.etiqueta
FROM gastos_campos_config g
ORDER BY g.orden;

END;;
DELIMITER ;;

DROP function IF EXISTS `inserta_registro_gasto_comision`;;
DELIMITER ;;
CREATE  DEFINER=`viajes_admin`@`localhost` FUNCTION `inserta_registro_gasto_comision`(idComision integer) RETURNS int(11)
BEGIN
	INSERT INTO `viajes_claros`.`registros_gastos_comision` VALUES(default, idComision);
	RETURN LAST_INSERT_ID();
END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS `insert_comisiones_desglose_gastos`;	
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_comisiones_desglose_gastos`(IN idCom INT(11), IN idRegistroGasto INT(11), 
IN campo VARCHAR(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN
IF ((valorTexto IS NOT NULL OR valorFecha IS NOT NULL) AND valorNumerico = 0) THEN
	INSERT INTO comisiones_desglose_gastos VALUES(DEFAULT, idCom, NULL, campo, valorTexto, NULL, valorFecha,idRegistroGasto);
ELSE 
	INSERT INTO comisiones_desglose_gastos VALUES(DEFAULT, idCom, NULL, campo, valorTexto, valorNumerico, valorFecha,idRegistroGasto);
END IF;
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_comision_desglose_gastos_id_comision`;;
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
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_comision_desglose_gastos_id_registro_gasto`;;
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
END;;
DELIMITER ;;


DROP PROCEDURE IF EXISTS `update_comision_desglose_gastos`;;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_comision_desglose_gastos`(IN idComision INT(11),IN idRegistro INT(11),IN camp varchar(50),IN valorTexto VARCHAR(300), IN valorNumerico DOUBLE, IN valorFecha DATETIME)
BEGIN	
IF ((valorTexto IS NOT NULL OR valorFecha IS NOT NULL) AND valorNumerico = 0) THEN
	UPDATE comisiones_desglose_gastos SET valor_texto = valorTexto, valor_numerico = NULL, valor_fecha = valorFecha WHERE id_comision = idComision AND id_registro_gasto_comision = idRegistro AND campo=camp;
ELSE 
	UPDATE comisiones_desglose_gastos SET valor_texto = valorTexto, valor_numerico = valorNumerico, valor_fecha = valorFecha WHERE id_comision = idComision AND id_registro_gasto_comision = idRegistro AND campo=camp;
END IF;
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_desglose_gastos_id_comision`;;
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
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `delete_registro_gastos_id_comision`;;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_registro_gastos_id_comision`(IN idComision INT(11),IN idRegistroGastoComision INT(11))
BEGIN	
DELETE FROM comisiones_desglose_gastos WHERE id_registro_gasto_comision=idRegistroGastoComision;
DELETE FROM registros_gastos_comision WHERE id_comision = idComision AND id_registro_gasto_comision=idRegistroGastoComision;
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_registros_gastos_por_id_comision`;;
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

END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_flujos_comision_reporte`;;
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
END;;
DELIMITER ;;

DROP PROCEDURE IF EXISTS `get_reporte_comision_por_flujo`;;
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
END;;
DELIMITER ;;


DROP PROCEDURE IF EXISTS `update_flujos_campos_config`;;
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

DROP PROCEDURE IF EXISTS `insert_flujos_campos_config`;;
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

DROP PROCEDURE IF EXISTS `insert_secciones_formulario`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `insert_secciones_formulario`(
	IN inEtiqueta VARCHAR(200), IN inNombre VARCHAR(200), IN idFlujo INT, IN orden INT)
BEGIN
	

INSERT INTO secciones_formulario
(etiqueta, nombre_seccion, id_flujo, orden_seccion)
VALUES(inEtiqueta, inNombre, idFlujo, orden);
	
	
END ;;

DROP PROCEDURE IF EXISTS `update_seccion_formulario`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `update_seccion_formulario`(
	idSeccion INT(11), inEtiqueta VARCHAR(200), 
	nombre VARCHAR(200), idFlujo INT(11), orden INT(11))
BEGIN

	
UPDATE secciones_formulario
SET etiqueta=inEtiqueta, nombre_seccion=nombre, id_flujo=idFlujo, orden_seccion=orden
WHERE id_seccion=idSeccion;

	
END ;;

DROP PROCEDURE IF EXISTS `update_gastos_campos_config`;;
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

DROP PROCEDURE IF EXISTS `insert_gastos_campos_config`;;
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


DROP PROCEDURE IF EXISTS `delete_gasto_campo_config`;;
DELIMITER ;;
CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `delete_gasto_campo_config`(
		IN idGastoCampoConfig INT(11))
BEGIN
	
	
DELETE FROM  gastos_campos_config
WHERE id_gasto_campo_config=idGastoCampoConfig;

END ;;

DROP PROCEDURE IF EXISTS `get_gastos_campos_config_edit`;;
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

END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS `get_total_gasto_por_dependencia_anio_esp`;
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

END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS `get_total_viajes_por_dependencia_anio_esp`;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_viajes_por_dependencia_anio_esp`(idDependencia INT(11), anio INT(11))
BEGIN
	
SELECT count(*) 
FROM viajes_claros_instancias i
INNER JOIN viajes_claros_detalle v ON v.id_viaje=i.id_viaje AND v.tabla='' AND v.campo='fecha_hora_salida'
WHERE id_dependencia=idDependencia
AND YEAR(v.valor_fecha) = anio;		
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS `get_total_viajes_por_dependencia_anio`;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_viajes_por_dependencia_anio`(idDependencia INT(11))
BEGIN
	
	
SELECT count(*) 
FROM viajes_claros_instancias
WHERE id_dependencia=idDependencia;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS `get_total_gasto_por_dependencia_anio`;
DELIMITER ;;

CREATE DEFINER=`viajes_admin`@`localhost` PROCEDURE `get_total_gasto_por_dependencia_anio`(idDependencia INT(11))
BEGIN

SELECT SUM(d.valor_numerico) 
FROM viajes_claros_detalle d
INNER JOIN viajes_claros_instancias i ON i.id_viaje=d.id_viaje
WHERE d.tabla='' AND d.campo='costo_total'
AND i.id_dependencia=idDependencia;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS `get_campos_filtros_disponibles`;
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

	
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS `obten_interfaz_carga`;
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

END;;
DELIMITER ;;
