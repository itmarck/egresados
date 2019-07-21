<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/universidades', function () {
  try {
    $data = $this->db->query("SELECT nombre FROM universidad WHERE vigencia=1")->fetchAll();
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

$app->get('/api/universidades-objeto', function () {
  try {
    $data = $this->db->query("SELECT codigo, nombre, siglas, estado,vigencia FROM universidad")->fetchAll();
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

$app->get('/api/universidades/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT codigo,nombre,siglas,estado FROM universidad WHERE codigo = $codigo and vigencia=1")->fetchAll();;
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

$app->post('/api/universidades/{nombre}', function (Request $request) {
  $nombre = $request->getAttribute('nombre');
  try {
    $cantidad = $this->db->exec("INSERT INTO universidad(nombre,vigencia) 
                            Values('$nombre',1)");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true));
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->post('/api/universidades', function (Request $request) {
  $nombre = $request->getParam('nombre');
  $siglas = $request->getParam('siglas');
  $estado = $request->getParam('estado');
  try {
    $cantidad = $this->db->exec("INSERT INTO universidad(nombre,siglas,estado,vigencia) 
                            Values('$nombre','$siglas',$estado,1)");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Universidad agregada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar la universidad'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->put('/api/universidades/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  $siglas = $request->getParam('siglas');
  $estado = $request->getParam('estado');
  try {
    $cantidad = $this->db->exec("UPDATE universidad set
                                nombre ='$nombre',
                                siglas = '$siglas',
                                estado = '$estado' 
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Universidad actualizada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar la universidad'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->delete('/api/universidades/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $cantidad = $this->db->exec("DELETE FROM universidad 
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
$app->patch('/api/universidades/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $vigencia = ($request->getParam('vigencia')) ? 0 : 1;
  $universidad = $request->getParam('universidad');
  try {
    if ($universidad != null) {
      $estudios = $this->db->query("SELECT  E.codigo FROM universidad U INNER JOIN estudiosPostgrado E on E.codigoUniversidad = U.codigo WHERE U.codigo = $codigo")->fetchAll();
      $escuela  = $this->db->query("SELECT  E.codigo FROM universidad U INNER JOIN escuelaProfesional E on E.codigoUniversidad = U.codigo WHERE U.codigo = $codigo")->fetchAll();
      if ($universidad  == 0) {
          if ($estudios || $escuela) {
            echo json_encode(array('estado' => false, 'mensaje' => 'Uy. Parece que tiene datos enlazados, escoge una universidad que la reemplace'));
            exit;
          }
      } else {
        foreach ($estudios as $key => $E) {
          $this->db->exec("UPDATE estudiosPostgrado   SET codigoUniversidad = $universidad where codigo = $E->codigo ");
        }
        foreach ($escuela as $key => $E) {
          $this->db->exec("UPDATE escuelaProfesional  SET codigoUniversidad = $universidad where codigo = $E->codigo ");
        }
      }
    }

    $cantidad = $this->db->exec("UPDATE universidad set
      vigencia = $vigencia
      WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => (!$vigencia) ? 'Universidad eliminada, aun se puede recuperar' : 'Universidad recuperada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se ha cambiado la vigencia'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});
