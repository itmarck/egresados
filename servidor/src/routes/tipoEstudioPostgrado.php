<?php

use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/api/tiposPostgrado', function () {
  $data = $this->db->query("SELECT codigo,nombre,descripcion FROM tipoestudiopostgrado WHERE vigencia=1")->fetchAll();
  if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
  } else {
    echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado tipos de estudio', 'data' => []));
  }
});

$app->put('/api/tiposPostgrado/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  $descripcion = $request->getParam('descripcion');
  try {
    $cantidad = $this->db->exec("UPDATE tipoestudioPostgrado set
                                nombre ='$nombre',
                                descripcion= '$descripcion',
                                vigencia= 1  
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Tipo de estudio actualizado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han cambiado los datos'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});
