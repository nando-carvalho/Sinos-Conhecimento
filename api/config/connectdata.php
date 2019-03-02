<?php
//Inicializando variaveis com dados do banco de dados local.
class Bancosinos{
  private $host = 'localhost';
  private $port = '3306';
  private $db_name = 'dbsinosconhecimento';
  private $usuario = 'dbSinos';
  private $senha = 'sinos&conhecimentoPuc';
  public $conn;

  /*Fazer conexão ao banco*/
  public function getConnection(){

    $this->conn = null;

    try{
      $this->conn = new PDO('mysql:host='.$this->host.';port='.$this->port.';dbname='.$this->db_name, $this->usuario, $this->senha);
      $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
      $this->conn->exec("SET NAMES UTF8");
    }catch(PDOException $exception){
      echo "Erro de conexão ao banco de dados: ".$exception->getMessage();
    }
    return $this->conn;
  }//endGetConnection

}//endClass


 ?>
