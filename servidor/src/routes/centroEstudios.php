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
    $data = $this->db->query("SELECT codigo,razonSocial, vigencia FROM centroestudios ")->fetchAll();;
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se ha encontrado datos', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->get('/api/centroEstudios-objeto-disabled', function () {
  try {
    $data = $this->db->query("SELECT codigo,razonSocial as nombre, ' ' as descripcion, vigencia  FROM centroestudios WHERE vigencia=0")->fetchAll();;
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se ha encontrado datos', 'data' => []));
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
  try {
    $cantidad = $this->db->exec("UPDATE centroestudios set
                                razonSocial ='$razonSocial'
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

$app->delete('/api/centroEstudios-objeto-disabled', function (Request $request) {
  $codigo = $request->getParam('codigo');
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
  $centro = $request->getParam('centroEstudios');
  try {
    if ($centro != null) {
      $estudios = $this->db->query("SELECT E.codigo from centroestudios C
                                    INNER JOIN estudiospostgrado E on E.codigoCentroEstudios = C.codigo 
                                    WHERE C.codigo = $codigo ")->fetchAll();
      if ($centro == "0") {
        if ($estudios) {
          echo json_encode(array('estado' => false, 'mensaje' => 'Uy. Parece que tiene datos enlazados, escoge un centro que lo reemplace'));
          exit;
        }
      } else {
        foreach ($estudios as $key => $C) {
          $this->db->exec("UPDATE estudiospostgrado SET codigoCentroEstudios = $centro where codigo = $C->codigo");
        }
      }
    }


    $cantidad = $this->db->exec("UPDATE centroestudios set
                                vigencia = $vigencia
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => (!$vigencia) ? 'Centro eliminado, aun se puede recuperar' : 'Centro recuperado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar la vigencia'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});
