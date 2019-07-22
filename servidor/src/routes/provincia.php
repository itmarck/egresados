<?php
use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/api/provincias/{departamento}', function (Request $request) {
  $departamento = $request->getAttribute('departamento');
  $data = $this->db->query("SELECT codigo,codigoDepartamento,nombre FROM provincia WHERE vigencia=1 and codigoDepartamento = $departamento")->fetchAll();
  if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
  } else {
    echo json_encode(array('estado' => false));
  }
});
