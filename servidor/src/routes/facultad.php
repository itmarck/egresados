<?php

use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/api/facultades', function () {
  try {
    $data = $this->db->query("SELECT F.nombre FROM facultad F  WHERE vigencia=1")->fetchAll();
    if ($data) {
      $nombres = [];
      foreach ($data as $key => $value) {
        array_push($nombres, $value->nombre);
      }
      echo json_encode(array('estado' => true, 'data' => $nombres));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->get('/api/facultades-objeto', function () {
  try {
    $data = $this->db->query("SELECT codigo,nombre,siglas,estado,vigencia  FROM facultad ")->fetchAll();
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->get('/api/facultades-objeto-disabled', function () {
  try {
    $data = $this->db->query("SELECT codigo,nombre,siglas as descripcion, vigencia FROM facultad where vigencia = 0")->fetchAll();
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos', 'data' => []));
  }
});

$app->get('/api/facultades/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT codigo,nombre,siglas,estado FROM facultad WHERE codigo = $codigo and vigencia = 1 ")->fetchAll();;
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->post('/api/facultades', function (Request $request) {
  $nombre = $request->getParam('nombre');
  $siglas = $request->getParam('siglas');
  $estado = $request->getParam('estado');
  try {
    $cantidad = $this->db->exec("INSERT INTO facultad(nombre,siglas,estado,vigencia) 
                            Values('$nombre','$siglas',$estado,1)");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Facultad agregada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se ha agregado la facultad'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->put('/api/facultades/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  $siglas = $request->getParam('siglas');
  $estado = $request->getParam('estado');
  try {
    $cantidad = $this->db->exec("UPDATE facultad set
                                nombre ='$nombre',
                                siglas = '$siglas',
                                estado = '$estado' 
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Facultad actualizada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han cambiado los datos'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->delete('/api/facultades-objeto-disabled', function (Request $request) {
  $codigo = $request->getParam('codigo');
  try {
    $cantidad = $this->db->exec("DELETE FROM facultad 
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Eliminado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo eliminar'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->patch('/api/facultades/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $vigencia = ($request->getParam('vigencia')) ? 0 : 1;
  $facultad = $request->getParam('facultad');
  try {
    if ($facultad != null) {
      $escuelas = $this->db->query("SELECT C.codigo from facultad F INNER JOIN escuelaProfesional C on C.codigoFacultad = F.codigo WHERE F.codigo = $codigo ")->fetchAll();
      if ($facultad == "0") {
        if ($escuelas) {
          echo json_encode(array('estado' => false, 'mensaje' => 'Uy. Parece que tiene datos enlazados, escoge una facultad que la reemplace'));
          exit;
        }
      } else {
        foreach ($escuelas as $key => $C) {
          $this->db->exec("UPDATE escuelaprofesional SET codigoFacultad = $facultad where codigo = $C->codigo");
        }
      }
    }


    $cantidad = $this->db->exec("UPDATE facultad set
                                vigencia = $vigencia
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => (!$vigencia) ? 'Facultad eliminada, aun se puede recuperar' : 'Facultad recuperada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar la vigencia'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});
