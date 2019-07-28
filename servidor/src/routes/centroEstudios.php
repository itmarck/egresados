<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/centroEstudios', function () {
  try {
    $data = $this->db->query("SELECT razonSocial FROM centroestudios WHERE vigencia=1")->fetchAll();
    if ($data) {
      $nombres = [];
      foreach ($data as $key => $value) {
        array_push($nombres, $value->razonSocial);
      }

      $result = array('estado' => true, 'data' => $nombres);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado centro de estudios', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->get('/api/centroEstudios/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT codigo,razonSocial FROM centroestudios WHERE codigo = $codigo and vigencia=1")->fetchAll();;
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se ha encontrado el centro de estudios', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->get('/api/centroEstudios-objeto', function () {
  try {
    $data = $this->db->query("SELECT codigo,razonSocial FROM centroestudios ")->fetchAll();;
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se ha encontrado el centro de estudios', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->get('/api/centroEstudios-objeto-disabled', function () {
  try {
    $data = $this->db->query("SELECT codigo,razonSocial, ' ' as descripcion  FROM centroestudios WHERE vigencia=0")->fetchAll();;
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se ha encontrado el centro de estudios', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->post('/api/centroEstudios', function (Request $request) {
  $razonSocial = $request->getParam('razonSocial');
  try {
    $cantidad = $this->db->exec("INSERT INTO centroestudios(razonSocial,vigencia) 
                            Values('$razonSocial',1)");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Centro de estudios agregado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se ha podido registrar centro de estudios'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->put('/api/centroEstudios/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $razonSocial = $request->getParam('razonSocial');
  $vigencia = $request->getParam('vigencia');
  try {
    $cantidad = $this->db->exec("UPDATE centroestudios set
                                razonSocial ='$razonSocial',
                                vigencia = '$vigencia',
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Centro de estudio actualizado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se ha podido actualizar centro de estudios'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->delete('/api/centroEstudios/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $cantidad = $this->db->exec("DELETE FROM centroestudios 
                                WHERE codigo = $codigo");
      if ($cantidad > 0) {
        echo json_encode(array('estado' => true, 'mensaje' => 'Centro de estudio eliminado'));
      } else {
        echo json_encode(array('estado' => false, 'mensaje' => 'No se ha podido eliminar centro de estudios'));
      }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->patch('/api/centroEstudios/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $vigencia = ($request->getParam('vigencia')) ? 0 : 1;
  try {
    $cantidad = $this->db->exec("UPDATE centroestudios set
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
