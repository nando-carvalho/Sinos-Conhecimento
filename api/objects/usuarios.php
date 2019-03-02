<?php

class Usuarios{

  /*Nome banco de dados e nome da tabela*/
  private $conn;
  private $tabela = "alunos";

  public $usuario;
  public $senha;

  public function __construct($db){
    $this->conn = $db;
  }
  /*Função realiza a autenticação do usuário ao banco de dados e retorna todos os dados do usuário da tabela alunos*/
  public function autenticar(){
    $query = "SELECT * FROM ".$this->tabela." WHERE email = '{$this->usuario}' AND senha = '{$this->senha}' ";

    $stmt = $this->conn->prepare($query);

    $stmt->execute();
    return $stmt;
  }


}//endUsuario












 ?>
