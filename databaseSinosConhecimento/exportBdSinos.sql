-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dbsinosconhecimento
-- ------------------------------------------------------
-- Server version	5.7.19

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
-- Table structure for table `alunos`
--

DROP TABLE IF EXISTS `alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alunos` (
  `cpf` varchar(11) NOT NULL,
  `nome_aluno` varchar(60) NOT NULL,
  `endereco` varchar(60) NOT NULL,
  `estado` varchar(45) NOT NULL,
  `municipio` varchar(45) NOT NULL,
  `telefone` varchar(45) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `senha` varchar(32) NOT NULL,
  PRIMARY KEY (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alunos`
--

LOCK TABLES `alunos` WRITE;
/*!40000 ALTER TABLE `alunos` DISABLE KEYS */;
INSERT INTO `alunos` VALUES ('11826487204','Kyara Luna','Lajinha ','MG','Juiz de Fora','90993999','Kyka@gmail.com','kyluna'),('15891622009','Maria Clarisse','Altos da gruta','GO','Goiania','61898898','clarisse@gmail.com','maclar'),('56663149040','Administrador','Casa do desenvolvedor','MG','Sjdr','99998899','sinos-conhecimento@gmail.com','s&c'),('83077243768','jose','centro','MG','Belo horizonte','91912838','jose@gmail.com','123');
/*!40000 ALTER TABLE `alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliacoes`
--

DROP TABLE IF EXISTS `avaliacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `avaliacoes` (
  `codigo_avaliacao` int(11) NOT NULL,
  `nome_avaliacao` varchar(60) NOT NULL,
  `data_avaliacao` date NOT NULL,
  `codigo_curso` int(11) NOT NULL,
  PRIMARY KEY (`codigo_avaliacao`),
  KEY `avaliacaoCurso_idx` (`codigo_curso`),
  CONSTRAINT `avaliacaoCurso` FOREIGN KEY (`codigo_curso`) REFERENCES `cursos` (`codigo_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacoes`
--

LOCK TABLES `avaliacoes` WRITE;
/*!40000 ALTER TABLE `avaliacoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursos`
--

DROP TABLE IF EXISTS `cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cursos` (
  `codigo_curso` int(11) NOT NULL,
  `nome_curso` varchar(45) NOT NULL,
  `ano` date NOT NULL,
  `semestre` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigo_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos`
--

LOCK TABLES `cursos` WRITE;
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
/*!40000 ALTER TABLE `cursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matricula`
--

DROP TABLE IF EXISTS `matricula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matricula` (
  `codigo_matricula` int(11) NOT NULL,
  `cpf_aluno` varchar(11) NOT NULL,
  `codigo_curso` int(11) NOT NULL,
  `data_matricula` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`codigo_matricula`),
  KEY `cpfAluno_idx` (`cpf_aluno`),
  KEY `cursoMatricula_idx` (`codigo_curso`),
  CONSTRAINT `cursoMatricula` FOREIGN KEY (`codigo_curso`) REFERENCES `cursos` (`codigo_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `matriculaAluno` FOREIGN KEY (`cpf_aluno`) REFERENCES `alunos` (`cpf`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matricula`
--

LOCK TABLES `matricula` WRITE;
/*!40000 ALTER TABLE `matricula` DISABLE KEYS */;
/*!40000 ALTER TABLE `matricula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas`
--

DROP TABLE IF EXISTS `notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notas` (
  `cpf_aluno` varchar(11) NOT NULL,
  `codigo_avaliacao` int(11) NOT NULL,
  `nota` float DEFAULT '0',
  PRIMARY KEY (`cpf_aluno`),
  KEY `nota_avaliacao_idx` (`codigo_avaliacao`),
  CONSTRAINT `nota_alunos` FOREIGN KEY (`cpf_aluno`) REFERENCES `alunos` (`cpf`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `nota_avaliacao` FOREIGN KEY (`codigo_avaliacao`) REFERENCES `avaliacoes` (`codigo_avaliacao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas`
--

LOCK TABLES `notas` WRITE;
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'dbsinosconhecimento'
--

--
-- Dumping routines for database 'dbsinosconhecimento'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-26 13:05:34
