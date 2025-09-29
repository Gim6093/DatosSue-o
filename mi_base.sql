-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: mi_base
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `asistente_ia`
--

DROP TABLE IF EXISTS `asistente_ia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistente_ia` (
  `id_sugerencia` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `sugerencia` text NOT NULL,
  `fecha_generacion` datetime NOT NULL,
  `leida` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_sugerencia`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `asistente_ia_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistente_ia`
--

LOCK TABLES `asistente_ia` WRITE;
/*!40000 ALTER TABLE `asistente_ia` DISABLE KEYS */;
/*!40000 ALTER TABLE `asistente_ia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detector_facial`
--

DROP TABLE IF EXISTS `detector_facial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detector_facial` (
  `id_detector` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `estado_detectado` enum('despierto','dormido_ligero','dormido_profundo','REM') NOT NULL,
  `fecha_deteccion` datetime NOT NULL,
  `confianza` double NOT NULL,
  PRIMARY KEY (`id_detector`),
  KEY `idx_detector_fecha` (`id_usuario`,`fecha_deteccion`),
  CONSTRAINT `detector_facial_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `detector_facial_chk_1` CHECK ((`confianza` between 0 and 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detector_facial`
--

LOCK TABLES `detector_facial` WRITE;
/*!40000 ALTER TABLE `detector_facial` DISABLE KEYS */;
/*!40000 ALTER TABLE `detector_facial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadisticas_sueño`
--

DROP TABLE IF EXISTS `estadisticas_sueño`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadisticas_sueño` (
  `id_estadistica` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `periodo` enum('diario','semanal','mensual','anual') NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `promedio_horas` double NOT NULL,
  `calidad_promedio` double NOT NULL,
  `dias_registrados` int NOT NULL,
  PRIMARY KEY (`id_estadistica`),
  KEY `idx_estadisticas_periodo` (`id_usuario`,`periodo`),
  CONSTRAINT `estadisticas_sueño_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `estadisticas_sueño_chk_1` CHECK ((`calidad_promedio` between 0 and 10))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadisticas_sueño`
--

LOCK TABLES `estadisticas_sueño` WRITE;
/*!40000 ALTER TABLE `estadisticas_sueño` DISABLE KEYS */;
/*!40000 ALTER TABLE `estadisticas_sueño` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfil`
--

DROP TABLE IF EXISTS `perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfil` (
  `id_perfil` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `idioma` varchar(50) DEFAULT 'español',
  `notificaciones_activas` tinyint(1) DEFAULT '1',
  `volumen_general` int DEFAULT '80',
  `tema` varchar(50) DEFAULT 'claro',
  PRIMARY KEY (`id_perfil`),
  UNIQUE KEY `unique_usuario_perfil` (`id_usuario`),
  CONSTRAINT `perfil_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `perfil_chk_1` CHECK ((`volumen_general` between 0 and 100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil`
--

LOCK TABLES `perfil` WRITE;
/*!40000 ALTER TABLE `perfil` DISABLE KEYS */;
/*!40000 ALTER TABLE `perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist` (
  `id_playlist` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `temporizador` int DEFAULT '60',
  `fecha_creacion` date NOT NULL,
  PRIMARY KEY (`id_playlist`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist`
--

LOCK TABLES `playlist` WRITE;
/*!40000 ALTER TABLE `playlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist_sonido`
--

DROP TABLE IF EXISTS `playlist_sonido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist_sonido` (
  `id_playlist_sonido` int NOT NULL AUTO_INCREMENT,
  `id_playlist` int NOT NULL,
  `id_sonido` int NOT NULL,
  `volumen_playlist` int DEFAULT '80',
  `orden` int NOT NULL,
  PRIMARY KEY (`id_playlist_sonido`),
  UNIQUE KEY `unique_playlist_orden` (`id_playlist`,`orden`),
  KEY `id_sonido` (`id_sonido`),
  CONSTRAINT `playlist_sonido_ibfk_1` FOREIGN KEY (`id_playlist`) REFERENCES `playlist` (`id_playlist`) ON DELETE CASCADE,
  CONSTRAINT `playlist_sonido_ibfk_2` FOREIGN KEY (`id_sonido`) REFERENCES `sonido` (`id_sonido`) ON DELETE CASCADE,
  CONSTRAINT `playlist_sonido_chk_1` CHECK ((`volumen_playlist` between 0 and 100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist_sonido`
--

LOCK TABLES `playlist_sonido` WRITE;
/*!40000 ALTER TABLE `playlist_sonido` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlist_sonido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registro_sueño`
--

DROP TABLE IF EXISTS `registro_sueño`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro_sueño` (
  `id_registro` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_despertar` time NOT NULL,
  `duracion_total` double NOT NULL,
  `calidad_sueno` enum('mala','regular','buena','excelente') NOT NULL,
  `notas` text,
  PRIMARY KEY (`id_registro`),
  KEY `idx_usuario_fecha` (`id_usuario`,`fecha`),
  CONSTRAINT `registro_sueño_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro_sueño`
--

LOCK TABLES `registro_sueño` WRITE;
/*!40000 ALTER TABLE `registro_sueño` DISABLE KEYS */;
/*!40000 ALTER TABLE `registro_sueño` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sonido`
--

DROP TABLE IF EXISTS `sonido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sonido` (
  `id_sonido` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `categoria` enum('naturaleza','meditacion','urbano','blanco','instrumental') NOT NULL,
  `archivo_audio` varchar(255) NOT NULL,
  `duracion` double NOT NULL,
  `id_usuario_creador` int NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_sonido`),
  KEY `id_usuario_creador` (`id_usuario_creador`),
  KEY `idx_sonido_categoria` (`categoria`,`activo`),
  CONSTRAINT `sonido_ibfk_1` FOREIGN KEY (`id_usuario_creador`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sonido`
--

LOCK TABLES `sonido` WRITE;
/*!40000 ALTER TABLE `sonido` DISABLE KEYS */;
/*!40000 ALTER TABLE `sonido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suscripcion`
--

DROP TABLE IF EXISTS `suscripcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suscripcion` (
  `id_suscripcion` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `tipo_plan` enum('mensual','anual','vitalicio') NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `activa` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_suscripcion`),
  KEY `id_usuario` (`id_usuario`),
  KEY `idx_suscripcion_activa` (`activa`,`fecha_fin`),
  CONSTRAINT `suscripcion_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suscripcion`
--

LOCK TABLES `suscripcion` WRITE;
/*!40000 ALTER TABLE `suscripcion` DISABLE KEYS */;
/*!40000 ALTER TABLE `suscripcion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `tipo_usuario` enum('free','premium','admin') NOT NULL,
  `fecha_registro` date NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Ana','ana@email.com'),(2,'Luis','luis@email.com');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-29 16:13:42
