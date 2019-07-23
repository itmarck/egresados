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

$app->put('/api/provincias/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  try {
    $cantidad = $this->db->exec("UPDATE provincia set
                                nombre ='$nombre',
                                vigencia= 1  
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Departamento actualizado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar '));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});