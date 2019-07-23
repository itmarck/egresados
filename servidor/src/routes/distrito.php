<?php

use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/api/distritos/{provincia}', function (Request $request) {
  $provincia =  $request->getAttribute('provincia');
  $data = $this->db->query("SELECT codigo,codigoProvincia,nombre from distrito WHERE vigencia=1 and codigoProvincia = $provincia")->fetchAll();
  if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
  } else {
    echo json_encode(array('estado' => false));
  }
});

$app->put('/api/distritos/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  try {
    $cantidad = $this->db->exec("UPDATE distrito set
                                nombre ='$nombre',
                                vigencia= 1  
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Distrito actualizado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar '));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});