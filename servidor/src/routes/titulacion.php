<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/titulaciones', function () {
  try {
    $data = $this->db->query("SELECT codigoEgresado,codigoModalidad,fecha FROM titulacion WHERE vigencia=1")->fetchAll();
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos' . $e->getMessage()));
  }
});

$app->get('/api/titulaciones/{codigoEgresado}', function (Request $request) {
  $codigoEgresado = $request->getAttribute('codigoEgresado');
  try {
    $data = $this->db->query("SELECT codigo,codigoEgresado,codigoModalidad,fecha FROM titulacion WHERE codigoEgresado = $codigoEgresado and vigencia=1")->fetchAll();;
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

$app->post('/api/titulaciones', function (Request $request) {
  $codigoEgresado = $request->getParam('codigoEgresado');
  $codigoModalidad = $request->getParam('codigoModalidad');
  $fecha = $request->getParam('fecha');
  $codigoColegiado = $request->getParam('codigoColegiado');
  $fechaColegiatura = $request->getParam('fechaColegiatura');
  try {
    $cantidad = $this->db->exec("INSERT INTO titulacion(codigoEgresado,codigoModalidad,fecha,vigencia) 
                            Values($codigoEgresado,$codigoModalidad,'$fecha',1)");
    if ($cantidad > 0) {
      if ($codigoColegiado) {
        $cantidad = $this->db->exec("INSERT INTO colegiatura(codigoEgresado,codigo,fecha,vigencia) 
        Values($codigoEgresado,'$codigoColegiado','$fechaColegiatura',1)");
        if ($cantidad = 0) {
          echo json_encode(array('estado' => false, 'mensaje' => 'No se pudieron registrar los datos de colegiatura'));
          exit(2);
        }
      }
      echo json_encode(array('estado' => true, 'mensaje' => 'Datos registrados correctamente'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudieron registrar los datos de titulación'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ' . $e->getMessage()));
  }
});

$app->put('/api/titulaciones/{codigoEgresado}', function (Request $request) {
  $codigoEgresado = $request->getAttribute('codigoEgresado');
  $codigoEgresado = $request->getParam('codigoEgresado');
  $codigoModalidad = $request->getParam('codigoModalidad');
  $fecha = $request->getParam('fecha');
  $codigoColegiado = $request->getParam('codigoColegiado');
  $fechaColegiatura = $request->getParam('fechaColegiatura');
  try {
    $cantidad = $this->db->exec("UPDATE titulacion set
                                codigoModalidad = $codigoModalidad,
                                fecha = '$fecha',
                                vigencia = 1
                                WHERE codigoEgresado = $codigoEgresado");
  
    if ($codigoColegiado) {
      $exist = $this->db->query("SELECT codigo FROM colegiatura WHERE codigoEgresado= $codigoEgresado")->fetchAll();
      if ($exist) {
        $cantidad2 = $this->db->exec("UPDATE colegiatura SET codigo = '$codigoColegiado', fecha = '$fechaColegiatura', vigencia = 1 WHERE codigoEgresado = $codigoEgresado");
      } else {
        $cantidad2 = $this->db->exec("INSERT INTO colegiatura(codigoEgresado,codigo,fecha,vigencia) 
        Values($codigoEgresado,'$codigoColegiado','$fechaColegiatura',1)");
      }
      
    }
    if ($cantidad > 0 ||  $cantidad2 > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Datos actualizados correctamente'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han cambiado los datos'));
    }
    
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ' . $e->getMessage()));
  }
});

$app->delete('/api/titulaciones/{codigoEgresado}', function (Request $request) {
  $codigoEgresado = $request->getAttribute('codigoEgresado');
  try {
    $cantidad = $this->db->exec("DELETE FROM titulacion 
                                WHERE codigoEgresado = $codigoEgresado");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Titulación agregada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo eliminar la titulación'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});
