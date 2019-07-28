<?php

use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/api/distritos/{provincia}', function (Request $request) {
  $provincia =  $request->getAttribute('provincia');
  $data = $this->db->query("SELECT codigo,codigoProvincia,nombre from distrito WHERE vigencia=1 and codigoProvincia = $provincia")->fetchAll();
  if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
  } else {
    echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
  }
});

$app->get('/api/distritos-objeto', function () {
  $data = $this->db->query("SELECT D.codigo,P.nombre as provincia, De.nombre as departamento ,D.nombre from distrito D
                            INNER JOIN provincia P on P.codigo = D.codigoProvincia
                            INNER JOIN departamento De on De.codigo = P.codigoDepartamento ")->fetchAll();
  if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
  } else {
    echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
  }
});

$app->get('/api/distritos-objeto-disabled', function () {
  $data = $this->db->query("SELECT D.codigo, CONCAT(P.nombre,'-', De.nombre) as descripcion ,D.nombre from distrito D
                            INNER JOIN provincia P on P.codigo = D.codigoProvincia
                            INNER JOIN departamento De on De.codigo = P.codigoDepartamento
                            WHERE D.vigencia=0 ")->fetchAll();
  if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
  } else {
    echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
  }
});

$app->put('/api/distritos/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  try {
    $cantidad = $this->db->exec("UPDATE distrito set
                                nombre ='$nombre',
                                vigencia= 1  
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Distrito actualizado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar '));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});