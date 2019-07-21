<?php

use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/api/estudiosPostgrado', function () {
  try {
    $data = $this->db->query("SELECT codigo,codigoEgresado,codigoTipo,codigoUniversidad,codigoCentroEstudios,nombre,fechaInicio,fechaTermino,anioCertificacion 
            FROM estudiospostgrado WHERE vigencia=1")->fetchAll();
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

$app->get('/api/estudiosPostgrado/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');

  try {
    $universidades = $this->db->query("SELECT Es.codigo,Es.codigoEgresado,Es.codigoTipo,T.nombre as tipo,Es.codigoUniversidad,U.nombre as universidad,Es.nombre, Es.fechaInicio,Es.fechaTermino,anioCertificacion 
        FROM estudiospostgrado Es
        INNER JOIN universidad U on U.codigo = Es.codigoUniversidad 
        INNER JOIN egresado E on E.codigo = Es.codigoEgresado
                     INNER JOIN persona P on P.codigo = E.codigoPersona
                     INNER JOIN tipoestudiopostgrado T on T.codigo = Es.codigoTipo 
                     WHERE P.dni = $codigo and P.vigencia = 1")->fetchAll();

    $lugar = "U";
    foreach ($universidades as $key => $value) {
      $value->lugar = $lugar;
      $value->select = true;
    }
    $centros = $this->db->query("SELECT Es.codigo,Es.codigoEgresado,Es.codigoTipo,T.nombre as tipo,Es.codigoCentroEstudios,C.razonSocial,Es.nombre, Es.fechaInicio,Es.fechaTermino,anioCertificacion 
                              FROM estudiospostgrado Es
                              INNER JOIN centroEstudios C on C.codigo= Es.codigoCentroEstudios  
                              INNER JOIN egresado E on E.codigo = Es.codigoEgresado
                              INNER JOIN persona P on P.codigo = E.codigoPersona
                              INNER JOIN tipoestudiopostgrado T on T.codigo = Es.codigoTipo 
                              WHERE P.dni = $codigo and P.vigencia = 1")->fetchAll();
    $lugar = "C";
    foreach ($centros as $key => $value) {
      $value->lugar = $lugar;
      $value->select = true;
    }

    $data = array_merge($universidades, $centros);
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

$app->post('/api/estudiosPostgrado/add', function (Request $request) {
  $codigoEgresado = $request->getParam('codigoEgresado');
  $codigoTipo = $request->getParam('codigoTipo');
  $nombre = $request->getParam('nombre');
  $fechaInicio = $request->getParam('fechaInicio');
  $fechaTermino = $request->getParam('fechaTermino');
  $anioCertificacion = $request->getParam('anioCertificacion');
  $centroEstudios = $request->getParam('centroEstudios');
  try {
    if ($nombre != "") {
      if ($centroEstudios) {
        if ($centroEstudios != "") {
          $codigoCentro = $this->db->query("SELECT codigo from centroestudios WHERE razonSocial = '$centroEstudios'")->fetchAll();
          if (!$codigoCentro) {
            $insert = $this->db->exec("INSERT INTO centroestudios(razonSocial,vigencia) 
          Values('$centroEstudios',1)");
            if ($insert > 0) {
              $codigoCentro = $this->db->query("SELECT codigo from centroestudios WHERE razonSocial = '$centroEstudios'")->fetchAll();
            } else {
              echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar el Centro'));
              exit;
            }
          }
          $codigo = $codigoCentro[0]->codigo;
          $cantidad = $this->db->exec("INSERT INTO estudiospostgrado(codigoEgresado,codigoTipo,nombre,codigoCentroEstudios,fechaInicio,fechaTermino,anioCertificacion,vigencia) 
                                    Values($codigoEgresado,$codigoTipo,'$nombre',$codigo,'$fechaInicio','$fechaTermino','$anioCertificacion',1)");
        }
      } else {
        $universidad = $request->getParam('universidad');

        if ($universidad != "") {
          $codigoUniversidad = $this->db->query("SELECT codigo from universidad WHERE nombre = '$universidad'")->fetchAll();
          if (!$codigoUniversidad) {
            $insert = $this->db->exec("INSERT INTO universidad(nombre,estado,vigencia) 
          Values('$universidad',1,1)");
            if ($insert > 0) {
              $codigoUniversidad = $this->db->query("SELECT codigo from universidad WHERE nombre = '$universidad'")->fetchAll();
            } else {
              echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar la universidad'));
              exit;
            }
          }
          $codigo = $codigoUniversidad[0]->codigo;
          $cantidad = $this->db->exec("INSERT INTO estudiospostgrado(codigoEgresado,codigoTipo,nombre,codigoUniversidad,fechaInicio,fechaTermino,anioCertificacion,vigencia) 
                                    Values($codigoEgresado,$codigoTipo,'$nombre',$codigo,'$fechaInicio','$fechaTermino','$anioCertificacion',1)");
        } else {
          echo json_encode(array('estado' => false, 'mensaje' => 'No se pueden mandar campos vacios'));
          exit;
        }
      }
      if ($cantidad > 0) {
        echo json_encode(array('estado' => true, 'mensaje' => 'Estudio registrado satisfactoriamente'));
      } else {
        echo json_encode(array('estado' => false, 'mensaje' => 'Algo fallo'));
      }
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pueden mandar campos vacios'));
      exit;
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al recepcionar los datos'));
  }
});

$app->put('/api/estudiosPostgrado/{codigo}', function (Request $request) {
  $codigoEstudio = $request->getAttribute('codigo');
  $codigoEgresado = $request->getParam('codigoEgresado');
  $codigoTipo = $request->getParam('codigoTipo');
  $centroEstudios = $request->getParam('centroEstudios');
  $universidad = $request->getParam('universidad');
  $nombre = $request->getParam('nombre');
  $fechaInicio = $request->getParam('fechaInicio');
  $fechaTermino = $request->getParam('fechaTermino');
  $anioCertificacion = $request->getParam('anioCertificacion');
  try {
    if ($nombre != "") {
      $sql = "UPDATE estudiospostgrado set
            codigoEgresado ='$codigoEgresado',
            codigoTipo = '$codigoTipo',
            nombre = '$nombre',
            fechaInicio = '$fechaInicio',
            fechaTermino = '$fechaTermino',
            anioCertificacion = $anioCertificacion, ";
      if ($centroEstudios) {
        if ($centroEstudios != "") {
          $codigoCentro = $this->db->query("SELECT codigo from centroestudios WHERE razonSocial = '$centroEstudios'")->fetchAll();
          if (!$codigoCentro) {
            $insert = $this->db->exec("INSERT INTO centroestudios(razonSocial,vigencia) 
          Values('$centroEstudios',1)");
            if ($insert > 0) {
              $codigoCentro = $this->db->query("SELECT codigo from centroestudios WHERE razonSocial = '$centroEstudios'")->fetchAll();
            } else {
              echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar el Centro'));
              exit;
            }
          }
          $codigo = $codigoCentro[0]->codigo;
          $sql = $sql .  " codigoCentroEstudios = '$codigo' ";
        }
      } else {
        $universidad = $request->getParam('universidad');
        if ($universidad != "") {
          $codigoUniversidad = $this->db->query("SELECT codigo from universidad WHERE nombre = '$universidad'")->fetchAll();
          if (!$codigoUniversidad) {
            $insert = $this->db->exec("INSERT INTO universidad(nombre,estado,vigencia) 
          Values('$universidad',1,1)");
            if ($insert > 0) {
              $codigoUniversidad = $this->db->query("SELECT codigo from universidad WHERE nombre = '$universidad'")->fetchAll();
            } else {
              echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar la universidad'));
              exit;
            }
          }
          $codigo = $codigoUniversidad[0]->codigo;
          $sql = $sql . " codigoUniversidad = '$codigo' ";
        } else {
          echo json_encode(array('estado' => false, 'mensaje' => 'No se pueden mandar campos vacios'));
          exit;
        }
      }

      $sql = $sql . "WHERE codigo = $codigoEstudio";
      $cantidad = $this->db->exec($sql);
      if ($cantidad > 0) {
        echo json_encode(array('estado' => true, 'mensaje' => 'Estudio actualizado satisfactoriamente'));
      } else {
        echo json_encode(array('estado' => false, 'mensaje' => 'Algo fallo'));
      }
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pueden mandar campos vacios'));
      exit;
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos '. $e->getMessage()));
  }
});

$app->delete('/api/estudiosPostgrado/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $cantidad = $this->db->exec("DELETE FROM estudiospostgrado 
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

$app->patch('/api/estudiosPostgrado/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $vigencia = ($request->getParam('vigencia')) ? 0 : 1;
  try {
    $cantidad = $this->db->exec("UPDATE estudiopostgrado set
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
