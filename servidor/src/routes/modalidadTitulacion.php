<?php

$app->get('/api/modalidadesTitulacion', function () {
  $data = $this->db->query("SELECT codigo,nombre,descripcion FROM modalidadtitulacion WHERE vigencia=1 ")->fetchAll();
  if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
  } else {
    echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
  }
});

$app->put('/api/modalidadesTitulacion/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  $descripcion = $request->getParam('descripcion');
  try {
    $cantidad = $this->db->exec("UPDATE modalidadTitulacion set
                                nombre ='$nombre',
                                descripcion= '$descripcion',
                                vigencia= 1  
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Modalidad actualizada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han cambiado los datos'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});