<?php

$app->get('/api/actividadesEconomica', function () {
  $nombres = $this->db->query("SELECT nombre FROM actividadeconomica WHERE vigencia=1")->fetchAll();
  $data = [];
  if ($nombres) {
    foreach ($nombres as $key => $value) {
      array_push($data, $value->nombre);
    }
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
  } else {
    echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado actividades economicas', 'data' => $data));
  }
});

$app->get('/api/actividades-objeto', function () {
  $data = $this->db->query("SELECT codigo, nombre, descripcion FROM actividadeconomica ")->fetchAll();
if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
  } else {
    echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado actividades economicas', 'data' => []));
  }
});

$app->get('/api/actividades-objeto-disabled', function () {
  $data = $this->db->query("SELECT codigo, nombre, descripcion FROM actividadeconomica WHERE vigencia = 0")->fetchAll();
if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
  } else {
    echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado actividades economicas', 'data' => $data));
  }
});

$app->post('/api/actividadEconomica/add', function (Request $request) {
  $nombre = $request->getParam('nombre');
  $descripcion = $request->getParam('descripcion');
  try {
    $cantidad = $this->db->exec("INSERT INTO actividadEconomica(nombre,descripcion,vigencia) 
                                  Values('$nombre','$descripcion',1)");

    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Actividad registrada correctamente'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar actividad economica'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->put('/api/actividadEconomica/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  $descripcion = $request->getParam('descripcion');
  try {
    $cantidad = $this->db->exec("UPDATE actividadEconomica set
                                nombre ='$nombre',
                                descripcion = '$descripcion',
                                vigencia= 1  
                                WHERE codigo = $codigo");



    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Actividad actualizada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar '));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->delete('/api/actividades-objeto-disabled', function (Request $request) {
  $codigo = $request->getParam('codigo');
  try {
    $cantidad = $this->db->exec("DELETE FROM actividadEconomica
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true));
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->patch('/api/actividadEconomica/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $vigencia = ($request->getParam('vigencia')) ? 0 : 1;
  $actividad = $request->db->getParam('actividad');
  try {
    if ($actividad != null) {
      $centros = $request->db->query("SELECT C.codigo from actividadEconomica A INNER JOIN centrolaboral C on C.codigoActividad = A.codigo WHERE A.codigo = $codigo")->fetchAll();
      if ($actividad == "0") {
        if ($centros) {
          echo json_encode(array('estado' => false, 'mensaje' => 'Uy. Parece que tiene datos enlazados, escoge una escuela que la reemplace'));
          exit;
        }
      } else {
        foreach ($centros as $key => $C) {
          $this->db->exec("UPDATE centrolaboral SET codigoActividad = $actividad where codigo = $C->codigo");
        }
      }
    }
    $cantidad = $this->db->exec("UPDATE actividadEconomica set
                                vigencia = $vigencia
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => (!$vigencia) ? 'Actividad eliminada, aun se puede recuperar' : 'Actividad recuperada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar la vigencia'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});
