<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/centroLaboral', function () {
  try {
    $data = $this->db->query("SELECT C.codigo as codigo ,codigoActividad,A.nombre as Actividad ,codigoDistrito,D.nombre as Distrito,RUC,razonSocial 
                            FROM centrolaboral C
                            INNER JOIN actividadeconomica A on A.codigo=C.codigoActividad 
                            INNER JOIN distrito D on D.codigo = C.codigoDistrito ")->fetchAll();
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

$app->get('/api/centroLaboral/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT codigoActividad,A.nombre as Actividad,codigoDistrito,D.nombre as Distrito,RUC,razonSocial as nombre
                              FROM centrolaboral C
                              INNER JOIN actividadeconomica A on A.codigo=C.codigoActividad 
                              INNER JOIN distrito D on D.codigo = C.codigoDistrito  
                              WHERE C.codigo = $codigo and C.vigencia=1")->fetchAll();
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

$app->get('/api/centroLaboral-objeto-disabled', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT C.codigo , CONCAT(A.nombre,',',D.nombre ) as descripcion,razonSocial as nombre
                              FROM centrolaboral C
                              INNER JOIN actividadeconomica A on A.codigo=C.codigoActividad 
                              INNER JOIN distrito D on D.codigo = C.codigoDistrito  
                              WHERE C.codigo = $codigo and C.vigencia = 0")->fetchAll();
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

$app->post('/api/centroLaboral/add', function (Request $request) {
  $codigoActividad = $request->getParam('codigoActividad');
  $codigoDistrito = $request->getParam('codigoDistrito');
  $RUC = $request->getParam('RUC');
  $razonSocial = $request->getParam('razonSocial');
  try {
    $cantidad = $this->db->exec("INSERT INTO centrolaboral(codigoActividad,codigoDistrito,RUC,razonSocial,vigencia) 
                            Values('$codigoActividad','$codigoDistrito',$RUC,$razonSocial,1)");
      if ($cantidad > 0) {
        echo json_encode(array('estado' => true, 'mensaje' => 'Centro laboral agregado'));
      } else {
        echo json_encode(array('estado' => false, 'mensaje' => 'No se ha podido agregar centro laboral'));
      }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->put('/api/centroLaboral/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $codigoActividad = $request->getParam('codigoActividad');
  $codigoDistrito = $request->getParam('codigoDistrito');
  $RUC = $request->getParam('RUC');
  $razonSocial = $request->getParam('razonSocial');
  try {
    $cantidad = $this->db->exec("UPDATE centrolaboral set
                                codigoActividad ='$codigoActividad',
                                codigoDistrito = '$codigoDistrito',
                                RUC = '$RUC',
                                razonSocial = '$razonSocial'  
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Centro laboral actualizado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han actualizado los datos'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->delete('/api/centroLaboral/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $cantidad = $this->db->exec("DELETE FROM centrolaboral 
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Centro laboral eliminado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se ha podido eliminar centro laboral'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});


$app->patch('/api/centroLaboral/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $vigencia = ($request->getParam('vigencia')) ? 0 : 1;
  $centro = $request->db->getParam('centro');
  try {
    if ($centro != null) {
      $contratos = $request->db->query("SELECT C.codigo from centroLaboral L INNER JOIN contrato C on C.codigoCentroLaboral = L.codigo WHERE L.codigo = $codigo")->fetchAll();
      if ($centro == "0") {
        if ($contratos) {
          echo json_encode(array('estado' => false, 'mensaje' => 'Uy. Parece que tiene datos enlazados, escoge un centro que lo reemplace'));
          exit;
        }
        foreach ($contratos as $key => $C) {
          $this->db->exec("UPDATE contrato SET codigoCentroLaboral = $centro where codigo = $C->codigo");
        }
      }
    }

    $cantidad = $this->db->exec("UPDATE centroLaboral set
                                vigencia = $vigencia
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => (!$vigencia) ? 'Centro laboral eliminado, aun se puede recuperar' : 'Centro laboral recuperado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar la vigencia'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});
