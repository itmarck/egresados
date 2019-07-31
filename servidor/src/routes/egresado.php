<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/carreras', function () {
  try {
    $data = $this->db->query("SELECT codigo,codigoEscuela,codigoPersona,codigoAdmision,fechaInicio,fechaTermino FROM egresado WHERE vigencia=1")->fetchAll();
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

$app->get('/api/carreras/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT E.codigo,E.codigoEscuela,EP.nombre as nombreEscuela,U.codigo as CodigoUni,U.nombre as universidad,codigoPersona,A.codigoModalidad,codigoAdmision,A.nombre as Admision,A.fechaAdmision as fechaAdmision,fechaInicio,fechaTermino, T.codigoModalidad as modalidadTitulacion, T.fecha as fechaTitulacion, C.codigo as codigoColegiatura, C.fecha as fechaColegiatura
                                FROM  egresado E 
                                INNER JOIN persona P on P.codigo = codigoPersona 
                                INNER JOIN escuelaProfesional EP on E.codigoEscuela = EP.codigo 
                                INNER JOIN universidad U on EP.codigoUniversidad = U.codigo 
                                INNER JOIN admision A on A.codigo = E.codigoAdmision 
                                LEFT  JOIN titulacion T on E.codigo = T.codigoEgresado
                                LEFT  JOIN colegiatura C on C.codigoEgresado = E.codigo
                                WHERE P.dni = $codigo and E.vigencia=1")->fetchAll();
    if ($data) {

      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos '. $e->getMessage()));
  }
});

$app->post('/api/carreras/add', function (Request $request) {
  $nombreUniversidad = $request->getParam('nombreUniversidad');
  $nombreEscuela = $request->getParam('nombreEscuela');
  $codigoPersona = $request->getParam('codigoPersona');
  $codigoAdmision = $request->getParam('codigoAdmision');
  $fechaInicio = $request->getParam('fechaInicio');
  $fechaTermino = $request->getParam('fechaTermino');
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
      if ($nombreEscuela != "") {
        $exist = false;

        $codigo =  $this->db->query("SELECT codigo FROM escuelaprofesional WHERE nombre = '$nombreEscuela'")->fetchAll();
        if ($codigo) {
          $codigoEscuela = $codigo[0]->codigo;
          $exist = $this->db->query("SELECT codigo FROM egresado 
          WHERE codigoEscuela = $codigoEscuela and codigoPersona = $codigoPersona")->fetchAll();
        } else {
          $insert = $this->db->exec("INSERT INTO escuelaprofesional(nombre,codigoUniversidad,estado,vigencia)
                                     VALUES ('$nombreEscuela',$codigoUniversidad,1,1)");
          if ($insert > 0) {
            $codigo = $this->db->query("SELECT last_insert_id() as codigo")->fetchAll();
            $codigoEscuela = $codigo[0]->codigo;
          } else {
            echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar la escuela'));
            exit;
          }
        }
        if ($exist) {
          echo json_encode(array('estado' => false, 'mensaje' => 'Ya tiene esa carrera registrada'));
        } else {
          if (!$codigoAdmision) {
            $fechaAdmision = $request->getParam('fechaAdmision');
            $nombreAdmision = $request->getParam('nombreAdmision');
            $codigoModalidad = $request->getParam('codigoModalidad');
            $insert = $this->db->exec("INSERT INTO admision(codigoEscuela,fechaAdmision,nombre,codigoModalidad,vigencia)
                                      VALUES($codigoEscuela,'$fechaAdmision','$nombreAdmision',$codigoModalidad,1)");
            if ($insert > 0) {
              $codigo = $this->db->query("SELECT last_insert_id() as codigo")->fetchAll();
              $codigoAdmision = $codigo[0]->codigo;
            } else {
              echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar la admision'));
              exit;
            }
          }
          $cantidad = $this->db->exec("INSERT INTO egresado(codigoEscuela,codigoPersona,codigoAdmision,fechaInicio,fechaTermino,vigencia)
                                      VALUES($codigoEscuela,$codigoPersona,$codigoAdmision,'$fechaInicio','$fechaTermino',1)");
          if ($cantidad > 0) {
            echo json_encode(array('estado' => true, 'mensaje' => 'Carrera registrada satisfactoriamente'));
          } else {
            echo json_encode(array('estado' => false, 'mensaje' => 'Algo fallo'));
          }
        }
      } else {
        echo json_encode(array('estado' => false, 'mensaje' => 'No se pueden mandar campos vacios'));
        exit;
      }
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pueden mandar campos vacios'));
      exit;
    }
  } catch (PDOException $e) {
    echo  json_encode(array('estado' => false, 'mensaje' => 'Error al recepcionar los datos ' . $e->getMessage()));
  }
});

$app->put('/api/carreras/{codigo}', function (Request $request) {
  $codigoEgresado = $request->getAttribute('codigo');
  $nombreUniversidad = $request->getParam('nombreUniversidad');
  $nombreEscuela = $request->getParam('nombreEscuela');
  $codigoPersona = $request->getParam('codigoPersona');
  $codigoAdmision = $request->getParam('codigoAdmision');
  $fechaInicio = $request->getParam('fechaInicio');
  $fechaTermino = $request->getParam('fechaTermino');
  try {
    if ($nombreUniversidad != "") {
      $codigo = $this->db->query("SELECT codigo FROM universidad WHERE nombre = '$nombreUniversidad'")->fetchAll();
      if (!$codigo) {
        $insert = $this->db->exec("INSERT INTO universidad(nombre,estado,vigencia) 
        Values('$nombreUniversidad',1,1)");
        if ($insert > 0) {
          $codigo = $this->db->query("SELECT codigo from universidad WHERE nombre = '$nombreUniversidad'")->fetchAll();
        } else {
          echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar la universidad'));
          exit;
        }
      }
      $codigoUniversidad = $codigo[0]->codigo;
      if ($nombreEscuela != "") {
        $exist = false;
        $codigo =  $this->db->query("SELECT codigo FROM escuelaprofesional WHERE nombre = '$nombreEscuela'")->fetchAll();
        if ($codigo) {
          $codigoEscuela = $codigo[0]->codigo;
          $exist = $this->db->query("SELECT codigo FROM egresado 
          WHERE codigoEscuela = $codigoEscuela and codigo != $codigoEgresado and codigoPersona = $codigoPersona")->fetchAll();
        } else {
          $insert = $this->db->exec("INSERT INTO escuelaprofesional(nombre,codigoUniversidad,estado,vigencia)
                                     VALUES ('$nombreEscuela',$codigoUniversidad,1,1)");
          if ($insert > 0) {
            $codigo = $this->db->query("SELECT last_insert_id() as codigo")->fetchAll();
            $codigoEscuela = $codigo[0]->codigo;
          } else {
            echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar la escuela'));
            exit;
          }
        }
        if ($exist) {
          echo json_encode(array('estado' => false, 'mensaje' => 'Ya tiene esa carrera registrada'));
        } else {
          if (!$codigoAdmision) {
            $fechaAdmision = $request->getParam('fechaAdmision');
            $nombreAdmision = $request->getParam('nombreAdmision');
            $codigoModalidad = $request->getParam('codigoModalidad');
            $insert = $this->db->exec("INSERT INTO admision(codigoEscuela,fechaAdmision,nombre,codigoModalidad,vigencia)
                                      VALUES($codigoEscuela,'$fechaAdmision','$nombreAdmision',$codigoModalidad,1)");
            if ($insert > 0) {
              $codigo = $this->db->query("SELECT last_insert_id() as codigo")->fetchAll();
              $codigoAdmision = $codigo[0]->codigo;
            } else {
              echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar la admision'));
              exit;
            }
          }
          $cantidad = $this->db->exec("UPDATE egresado set
                                      codigoEscuela ='$codigoEscuela',
                                      codigoPersona = '$codigoPersona',
                                      codigoAdmision = '$codigoAdmision',
                                      fechaInicio = '$fechaInicio',
                                      fechaTermino = '$fechaTermino',
                                      vigencia = 1  
                                      WHERE codigo = $codigoEgresado");
          if ($cantidad > 0) {
            echo json_encode(array('estado' => true, 'mensaje' => 'Carrera actualizada satisfactoriamente'));
          } else {
            echo json_encode(array('estado' => false, 'mensaje' => 'No se han cambiado los datos'));
          }
        }
      } else {
        echo json_encode(array('estado' => false, 'mensaje' => 'No se pueden mandar campos vacios'));
        exit;
      }
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pueden mandar campos vacios'));
      exit;
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ' . $e->getMessage()));
  }
});

$app->delete('/api/carreras/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $cantidad = $this->db->exec("DELETE FROM egresado 
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Carrera eliminada'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se ha eliminado la carrera'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});




$app->get('/api/carreras/actividadEconomica/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT nombres,celular,correo, Centro.razonSocial, C.cargo,C.detalleFunciones, A.nombre
                              FROM egresado INNER JOIN persona on persona.codigo = codigoPersona
                              INNER JOIN contrato C on egresado.codigo= C.codigoEgresado
                              INNER JOIN centroLaboral Centro on C.codigoCentroLaboral = Centro.codigo
                              INNER JOIN actividadEconomica A on Centro.codigoActividad = A.codigo
                              WHERE actividadEconomica.codigo = $codigo")->fetchAll();
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

$app->patch('/api/carreras/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $vigencia = ($request->getParam('vigencia')) ? 0 : 1;
  try {
    $cantidad = $this->db->exec("UPDATE egresado set
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

//Funciones
// function validarCarrera($codigoEscuela,$codigoPersona){
//   $data = $this->db->query("SELECT codigo FROM egresado 
//           WHERE codigoEscuela = $codigoEscuela and codigoPersona = $codigoPersona")->fetchAll();
//       if ($data) {
//         return false;
//       }else {
//         return true;
//       }
// }
