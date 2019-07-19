<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/colegiaturas', function () {
  try {
    $data = $this->db->query("SELECT CONCAT(P.nombres,' ',P.apellidoPaterno,' ',P.apellidoPaterno)as Nombre,C.codigo,codigoEgresado,EP.nombre,fecha 
                            FROM colegiatura C
                            INNER JOIN egresado E on E.codigo = C.codigoEgresado
                            INNER JOIN escuelaprofesional EP on EP.codigo = E.codigoEscuela
                            INNER JOIN persona P on P.codigo = E.codigoPersona
                            WHERE C.vigencia=1")->fetchAll();
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": ' . $e->getMessage() . '}';
  }
});

$app->get('/api/colegiaturas/{codigoEgresado}', function (Request $request) {
  $codigoEgresado = $request->getAttribute('codigoEgresado');
  try {
    $data = $this->db->query("SELECT CONCAT(P.nombres,' ',P.apellidoPaterno,' ',P.apellidoPaterno)as Nombre,C.codigo,codigoEgresado,EP.nombre,fecha 
                              FROM colegiatura C
                              INNER JOIN egresado E on E.codigo = C.codigoEgresado
                              INNER JOIN escuelaprofesional EP on EP.codigo = E.codigoEscuela
                              INNER JOIN persona P on P.codigo = E.codigoPersona
                              WHERE C.codigoEgresado = $codigoEgresado and C.vigencia=1")->fetchAll();
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": ' . $e->getMessage() . '}';
  }
});

$app->post('/api/colegiaturas/add', function (Request $request) {
  $codigoEgresado = $request->getParam('codigoEgresado');
  $fecha = $request->getParam('fecha');
  try {
    $cantidad = $this->db->exec("INSERT INTO colegiatura(codigoEgresado,fecha,vigencia) 
                            Values('$codigoEgresado','$fecha',1)");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true));
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": ' . $e->getMessage() . '}';
  }
});

$app->put('/api/colegiaturas/{codigoEgresado}', function (Request $request) {
  $codigoEgresado = $request->getAttribute('codigoEgresado');
  $fecha = $request->getParam('fecha');
  try {
    $cantidad = $this->db->exec("UPDATE colegiatura set
                                fecha = '$fecha'
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true));
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": ' . $e->getMessage() . '}';
  }
});

$app->delete('/api/colegiaturas/{codigoEgresado}', function (Request $request) {
  $codigoEgresado = $request->getAttribute('codigoEgresado');
  try {
    $cantidad = $this->db->exec("DELETE FROM colegiatura 
                                WHERE codigoEgresado = $codigoEgresado");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true));
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": ' . $e->getMessage() . '}';
  }
});
