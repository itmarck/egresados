<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/admisiones', function () {
  try {
    $data = $this->db->query("SELECT A.codigo,codigoEscuela,date_format(fechaAdmision,'%Y/%m/%d') as fechaAdmision,A.nombre as ciclo,codigoModalidad, M.nombre as modalidad 
                            FROM admision A
                            INNER JOIN modalidadadmision M on A.codigoModalidad = M.codigo 
                            WHERE A.vigencia=1
                            ORDER BY fechaAdmision")->fetchAll();
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado admisiones', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos', 'data' => []));
  }
});

$app->get('/api/admisiones-all', function () {
  try {
    $data = $this->db->query("SELECT A.codigo,codigoEscuela as escuela,EP.nombre as nombreEscuela,EP.codigoUniversidad as universidad ,A.nombre as ciclo,fechaAdmision as fecha,CONCAT(A.nombre,' ',M.nombre) as nombre  ,codigoModalidad as modalidad, codigoModalidad as modalidad,A.vigencia
                            FROM admision A
                            INNER JOIN escuelaprofesional EP on EP.codigo = codigoEscuela 
                            INNER JOIN modalidadadmision M on M.codigo = A.codigoModalidad
                            ORDER BY fechaAdmision")->fetchAll();
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado admisiones', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos', 'data' => []));
  }
});

$app->get('/api/admisiones/{nombreEscuela}/{nombreUniversidad}', function (Request $request) {
  $nombreEscuela = $request->getAttribute('nombreEscuela');
  $nombreUniversidad = $request->getAttribute('nombreUniversidad');
  try {
    $data = $this->db->query("SELECT A.codigo,codigoEscuela,date_format(fechaAdmision,'%Y/%m/%d') as fechaAdmision,A.nombre as ciclo,codigoModalidad, M.nombre as modalidad 
                            FROM admision A
                            INNER JOIN modalidadadmision M on A.codigoModalidad = M.codigo  
                            INNER JOIN escuelaprofesional E on E.codigo = A.codigoEscuela
                            INNER JOIN universidad U on E.codigoUniversidad = U.codigo 
                            WHERE A.vigencia=1 and E.nombre = '$nombreEscuela' and U.nombre = '$nombreUniversidad'
                            ORDER BY fechaAdmision")->fetchAll();
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos', 'data' => []));
  }
});

$app->post('/api/admisiones', function (Request $request) {
  $nombre = $request->getParam('nombre');
  $codigoEscuela = $request->getParam('escuela');
  $fechaAdmision = $request->getParam('admision');
  $codigoModalidad = $request->getParam('modalidad');
  try {
    $cantidad = $this->db->exec("INSERT INTO admision(codigoEscuela,fechaAdmision,nombre,codigoModalidad,vigencia) 
                            Values($codigoEscuela,'$fechaAdmision','$nombre',$codigoModalidad,1)");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Admision agregada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'Error al agregar admision'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->put('/api/admisiones/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  $codigoEscuela = $request->getParam('escuela');
  $fechaAdmision = $request->getParam('admision');
  $codigoModalidad = $request->getParam('modalidad');
  try {
    $cantidad = $this->db->exec("UPDATE admision set
                                nombre ='$nombre',
                                codigoEscuela = $codigoEscuela,
                                fechaAdmision = '$fechaAdmision',
                                codigoModalidad = $codigoModalidad
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Admision actualizada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'Error al actualizar admision'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->delete('/api/universidades-objeto-disabled', function (Request $request) {
  $codigo = $request->getParam('codigo');
  try {
    $cantidad = $this->db->exec("DELETE FROM admision 
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true));
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->patch('/api/admision/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $vigencia = ($request->getParam('vigencia')) ? 0 : 1;
  try {
    $carreras = $this->db->query("SELECT E.codigo from admision A INNER JOIN egresado E on E.codigoAdmision = A.codigo WHERE A.codigo = $codigo")->fetchAll();

    if ($carreras) {
      echo json_encode(array('estado' => false, 'mensaje' => 'Uy. Parece que tiene datos enlazados, no se puede eliminar'));
      exit;
    }


    $cantidad = $this->db->exec("UPDATE admision set
                                vigencia = $vigencia
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => (!$vigencia) ? 'Admision eliminada, aun se puede recuperar' : 'Admision recuperada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar la vigencia'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});
