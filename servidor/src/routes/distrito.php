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

$app->delete('/api/distritos-objeto-disabled', function (Request $request) {
  $codigo = $request->getParam('codigo');
  try {
    $cantidad = $this->db->exec("DELETE FROM distrito
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Distrito eliminado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se ha podido eliminar distrito'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
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