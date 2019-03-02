<?php

//incluindo demais arquivos
include_once '../config/connectdata.php';
include_once '../objects/usuarios.php';

//Instanciando o banco e fazendo a conexão
$bancosinos = new Bancosinos();
$db = $bancosinos->getConnection();

//obj usuario
$usuarios = new Usuarios($db);

//Verifica se o método utilizado para conexão é POST
if ($_SERVER['REQUEST_METHOD'] == 'POST') {

  //Obtem os dados inseridos na view
  $usuarios->usuario = isset($_POST['email']) ? $_POST['email'] : die();
  $usuarios->senha = isset($_POST['senha']) ? $_POST['senha'] : die();

  // Valida o tipo de usuário, no caso abaixo usa o login e senha do administrador do sistema para definir as permissões do usuario
  if ($usuarios->usuario == "sinos-conhecimento@gmail.com" && $usuarios->senha == "s&c"){
    $tipoUsuario = 1;//administrador
  }else{
    $tipoUsuario = 2;//aluno
  }


  //leitura dos dados recebidos por POST
  $stmt = $usuarios->autenticar();
  if($stmt->rowCount() > 0){
    $dados = $stmt->fetch(PDO::FETCH_ASSOC);
    // criação de array com dados
    $dadosUserArray = array(
      "status" =>true,
      "message" => "Login realizado com sucesso!",
      "tipoUsuario" => $tipoUsuario,
      "nome_aluno" => $dados['nome_aluno'],
      "cpf" => $dados['cpf']
    );
  }else{
    $dadosUserArray = array(
      "status" =>false,
      "message" => "Ops, Email ou Senha invalidos, não foi possível autenticar acesso!",
    );
  }

}else{
  $dadosUserArray = array(
    "status" =>false,
    "message" => "Ops, Por favor, utilize o método POST.!",
  );
}
print_r(json_encode($dadosUserArray));
echo json_encode($dadosUserArray);



?>
