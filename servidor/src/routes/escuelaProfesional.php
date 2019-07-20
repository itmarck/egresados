<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/escuelasProfesionales', function () {
  try {
    $data = $this->db->query("SELECT E.codigo,F.nombre as facultad,E.nombre,E.siglas,E.estado,U.nombre as universidad, E.vigencia 
                              FROM escuelaprofesional E
                              LEFT JOIN facultad F on F.codigo = codigoFacultad
                              INNER JOIN universidad U on U.codigo = E.codigoUniversidad")->fetchAll();
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

$app->get('/api/escuelasProfesionales/uni/{Nombre}', function (Request $request) {
  $codigo = $request->getAttribute('Nombre');
  try {
    $data = $this->db->query("SELECT E.nombre FROM escuelaprofesional E
                            INNER JOIN universidad U on U.codigo =  E.codigoUniversidad
                            WHERE U.nombre = '$codigo' and E.vigencia=1")->fetchAll();
    if ($data) {
      $nombres = [];
      foreach ($data as $key => $value) {
        array_push($nombres, $value->nombre);
      }
      $result = array('estado' => true, 'data' => $nombres);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->get('/api/escuelasProfesionales/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT nombre FROM escuelaprofesional WHERE codigo = $codigo and vigencia=1")->fetchAll();;
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

$app->post('/api/escuelasProfesionales/add', function (Request $request) {
  $nombre = $request->getParam('nombre');
  $siglas = $request->getParam('siglas');
  $codigoFacultad = $request->getParam('codigoFacultad');
  $codigoUniversidad = $request->getParam('codigoUniversidad');
  $estado = $request->getParam('estado');
  try {
    if ($codigoFacultad) {
      $cantidad = $this->db->exec("INSERT INTO escuelaprofesional(nombre,siglas,estado,codigoFacultad,codigoUniversidad,vigencia) 
                            Values('$nombre','$siglas',$estado,$codigoFacultad,$codigoUniversidad,1)");
    } else {
      $cantidad = $this->db->exec("INSERT INTO escuelaprofesional(nombre,siglas,estado,codigoUniversidad,vigencia) 
                            Values('$nombre','$siglas',$estado,$codigoUniversidad,1)");
    }
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true));
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->put('/api/escuelasProfesionales/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  $siglas = $request->getParam('siglas');
  $codigoFacultad = $request->getParam('codigoFacultad');
  $codigoUniversidad = $request->getParam('codigoUniversidad');
  $estado = $request->getParam('estado');
  try {
    if ($codigoFacultad) {
      $cantidad = $this->db->exec("UPDATE escuelaprofesional set
                                nombre ='$nombre',
                                siglas = '$siglas',
                                estado = '$estado',
                                codigoUniversidad = '$codigoUniversidad',
                                codigoFacultad = '$codigoFacultad'  
                                WHERE codigo = $codigo");
    } else {
      $cantidad = $this->db->exec("UPDATE escuelaprofesional set
                                nombre ='$nombre',
                                siglas = '$siglas',
                                estado = '$estado',
                                codigoUniversidad = '$codigoUniversidad'
                                WHERE codigo = $codigo");
    }


    if ($cantidad > 0) {
      echo json_encode(array('estado' => true));
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->delete('/api/escuelasProfesionales/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $cantidad = $this->db->exec("DELETE FROM escuelaprofesional 
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

$app->patch('/api/escuelasProfesionales/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $vigencia = ($request->getParam('vigencia')) ? 0 : 1;
  try {
    $cantidad = $this->db->exec("UPDATE escuelaprofesional set
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
