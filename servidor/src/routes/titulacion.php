<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/titulaciones', function () {
  try {
    $data = $this->db->query("SELECT codigo,codigoEgresado,codigoModalidad,fecha FROM titulacion WHERE vigencia=1")->fetchAll();
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false,'mensaje'=>'Error al conectar con la base de datos'));
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
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false,'mensaje'=>'Error al conectar con la base de datos'));
  }
});

$app->post('/api/titulaciones/add', function (Request $request) {
  $codigoEgresado = $request->getParam('codigoEgresado');
  $codigoModalidad = $request->getParam('codigoModalidad');
  $fecha = $request->getParam('fecha');
  try {
    $cantidad = $this->db->exec("INSERT INTO titulacion(codigoEgresado,codigoModalidad,fecha,vigencia) 
                            Values('$codigoEgresado','$codigoModalidad',$fecha,1)");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true));
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false,'mensaje'=>'Error al conectar con la base de datos'));
  }
});

$app->put('/api/titulaciones/{codigoEgresado}', function (Request $request) {
  $codigoEgresado = $request->getAttribute('codigoEgresado');
  $codigoEgresado = $request->getParam('codigoEgresado');
  $codigoModalidad = $request->getParam('codigoModalidad');
  $fecha = $request->getParam('fecha');
  try {
    $cantidad = $this->db->exec("UPDATE titulacion set
                                codigoEgresado ='$codigoEgresado',
                                codigoModalidad = '$codigoModalidad',
                                fecha = '$fecha' 
                                WHERE codigoEgresado = $codigoEgresado");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true));
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false,'mensaje'=>'Error al conectar con la base de datos'));
  }
});

$app->delete('/api/titulaciones/{codigoEgresado}', function (Request $request) {
  $codigoEgresado = $request->getAttribute('codigoEgresado');
  try {
    $cantidad = $this->db->exec("DELETE FROM titulacion 
                                WHERE codigoEgresado = $codigoEgresado");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true));
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false,'mensaje'=>'Error al conectar con la base de datos'));
  }
});
