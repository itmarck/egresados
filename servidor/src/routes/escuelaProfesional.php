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
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos'));
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
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos'));
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
  $nombreFacultad = $request->getParam('facultad');
  $nombreUniversidad = $request->getParam('universidad');
  $estado = $request->getParam('estado');
  $siglasFacultad = $request->getParam('siglasFacultad');
  try {
    if ($nombreUniversidad != "") {
      $codigo = $this->db->query("SELECT codigo FROM universidad WHERE nombre = '$nombreUniversidad'")->fetchAll();
      if (!$codigo) {
        $insert = $this->db->exec("INSERT INTO universidad(nombre,estado,vigencia) 
        Values('$nombreUniversidad',1,1)");
        if ($insert > 0) {
          $codigo = $this->db->query("SELECT last_insert_id() as codigo")->fetchAll();
        } else {
          echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar la universidad'));
          exit;
        }
      }
      $codigoUniversidad = $codigo[0]->codigo;
      if ($nombreFacultad) {
        if ($nombreFacultad != "") {
          $codigo =  $this->db->query("SELECT codigo FROM facultad WHERE nombre = '$nombreFacultad'")->fetchAll();
          if (!$codigo) {
            $insert = $this->db->exec("INSERT INTO facultad(nombre,siglas,estado,vigencia)
                                           VALUES ('$nombreFacultad','$siglasFacultad',1,1)");
            if ($insert > 0) {
              $codigo = $this->db->query("SELECT last_insert_id() as codigo")->fetchAll();
              $codigoFacultad = $codigo[0]->codigo;
            } else {
              echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar la escuela'));
              exit;
            }
          }
          $cantidad = $this->db->exec("INSERT INTO escuelaprofesional(nombre,siglas,estado,codigoFacultad,codigoUniversidad,vigencia) 
                                  Values('$nombre','$siglas',$estado,$codigoFacultad,$codigoUniversidad,1)");
        }
      } else {
        $cantidad = $this->db->exec("INSERT INTO escuelaprofesional(nombre,siglas,estado,codigoUniversidad,vigencia) 
                                  Values('$nombre','$siglas',$estado,$codigoUniversidad,1)");
      }
      if ($cantidad > 0) {
        echo json_encode(array('estado' => true, 'mensaje' => 'Escuela registrada satisfactoriamente'));
      } else {
        echo json_encode(array('estado' => false, 'mensaje' => 'Algo fallo'));
      }
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pueden mandar campos vacios'));
      exit;
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->put('/api/escuelasProfesionales/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  $siglas = $request->getParam('siglas');
  $nombreFacultad = $request->getParam('facultad');
  $nombreUniversidad = $request->getParam('universidad');
  $estado = $request->getParam('estado');
  $siglasFacultad = $request->getParam('siglasFacultad');
  try {


    if ($nombreUniversidad != "") {
      $codigo = $this->db->query("SELECT codigo FROM universidad WHERE nombre = '$nombreUniversidad'")->fetchAll();
      if (!$codigo) {
        $insert = $this->db->exec("INSERT INTO universidad(nombre,estado,vigencia) 
        Values('$nombreUniversidad',1,1)");
        if ($insert > 0) {
          $codigo = $this->db->query("SELECT last_insert_id() as codigo")->fetchAll();
        } else {
          echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar la universidad'));
          exit;
        }
      }
      $codigoUniversidad = $codigo[0]->codigo;
      if ($nombreFacultad) {
        if ($nombreFacultad != "") {
          $codigo =  $this->db->query("SELECT codigo FROM facultad WHERE nombre = '$nombreFacultad'")->fetchAll();
          if (!$codigo) {
            $insert = $this->db->exec("INSERT INTO facultad(nombre,siglas,estado,vigencia)
                                           VALUES ('$nombreFacultad','$siglasFacultad',1,1)");
            if ($insert > 0) {
              $codigo = $this->db->query("SELECT last_insert_id() as codigo")->fetchAll();
              $codigoFacultad = $codigo[0]->codigo;
            } else {
              echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar la escuela'));
              exit;
            }
          }
          $cantidad = $this->db->exec("UPDATE escuelaprofesional set
                                      nombre ='$nombre',
                                      siglas = '$siglas',
                                      estado = '$estado',
                                      codigoUniversidad = '$codigoUniversidad',
                                      codigoFacultad = '$codigoFacultad'  
                                      WHERE codigo = $codigo");
        }
      } else {
        $cantidad = $this->db->exec("UPDATE escuelaprofesional set
                                    nombre ='$nombre',
                                    siglas = '$siglas',
                                    estado = '$estado',
                                    codigoUniversidad = '$codigoUniversidad'
                                    WHERE codigo = $codigo");
      }
      if ($cantidad > 0) {
        echo json_encode(array('estado' => true, 'mensaje' => 'Escuela actualizada satisfactoriamente'));
      } else {
        echo json_encode(array('estado' => false, 'mensaje' => 'Algo fallo'));
      }
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pueden mandar campos vacios'));
      exit;
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
      echo json_encode(array('estado' => false, 'mensaje' => 'Algo fallo'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->patch('/api/escuelasProfesionales/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $vigencia = ($request->getParam('vigencia')) ? 0 : 1;
  $escuela = $request->db->getParam('escuela');
  try {
    if ($escuela != null) {
      $carreras = $request->db->query("SELECT E.codigo from escuelaProfesional C INNER JOIN egresado E on E.codigoEscuela = C.codigo WHERE C.codigo = $codigo")->fetchAll();
      if ($escuela == "0") {
        if ($carreras) {
          echo json_encode(array('estado' => false, 'mensaje' => 'Uy. Parece que tiene datos enlazados, escoge una escuela que la reemplace'));
          exit;
        }
      } else {
        foreach ($carreras as $key => $C) {
          $this->db->exec("UPDATE egresado SET codigoEscuela = $escuela where codigo = $C->codigo");
        }
      }
    }

    $cantidad = $this->db->exec("UPDATE escuelaprofesional set
                                vigencia = $vigencia
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => (!$vigencia) ? 'Escuela eliminada, aun se puede recuperar' : 'Escuela recuperada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar la vigencia'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});
