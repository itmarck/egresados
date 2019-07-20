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
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudieron obtener los datos'));
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
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
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
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->post('/api/facultades/add', function (Request $request) {
  $nombre = $request->getParam('nombre');
  $siglas = $request->getParam('siglas');
  $estado = $request->getParam('estado');
  try {
    $cantidad = $this->db->exec("INSERT INTO facultad(nombre,siglas,estado,vigencia) 
                            Values('$nombre','$siglas',$estado,1)");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true));
    } else {
      echo json_encode(array('estado' => false));
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
      echo json_encode(array('estado' => true, 'mensaje' => 'Actualizado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->delete('/api/facultades/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
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
  try {
    $cantidad = $this->db->exec("UPDATE facultad set
                                vigencia = $vigencia
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Vigencia actualizada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar la vigencia'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});
