<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/contratos', function () {
  try {
    $data = $this->db->query("SELECT CONCAT(P.nombres,' ',P.apellidoPaterno,' ',P.apellidoPaterno) as Nombre,C.codigo,codigoEgresado,EP.codigo as codigoCarrera,codigoCentroLaboral,Cen.razonSocial as Centrolaboral,cargo,C.fechaInicio,C.fechaTermino,detalleFunciones 
                            FROM contrato C
                            INNER JOIN egresado E on E.codigo = C.codigoEgresado
                            INNER JOIN persona P on P.codigo = E.codigoPersona
                            INNER JOIN escuelaprofesional EP on EP.codigo = E.codigoEscuela
                            INNER JOIN centrolaboral Cen on Cen.codigo  = C.codigoCentroLaboral
                            WHERE C.vigencia=1")->fetchAll();
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

$app->get('/api/contratos/{dniPersona}', function (Request $request) {
  $codigo = $request->getAttribute('dniPersona');
  try {
    $data = $this->db->query("SELECT C.codigo,codigoEgresado,codigoCentroLaboral,Cen.razonSocial as centroLaboral,cargo, C.fechaInicio , C.fechaTermino ,detalleFunciones 
                            FROM contrato C
                            INNER JOIN egresado E on E.codigo = C.codigoEgresado
                            INNER JOIN persona P on P.codigo = E.codigoPersona
                            INNER JOIN escuelaprofesional EP on EP.codigo = E.codigoEscuela
                            INNER JOIN centrolaboral Cen on Cen.codigo  = C.codigoCentroLaboral
                            WHERE P.dni = $codigo and C.vigencia=1
                            ORDER BY Cen.razonSocial")->fetchAll();
    if ($data) {
      foreach ($data as $key => $contrato) {
        if ($contrato->fechaTermino) {
          $finalizado = true;
          $ftermino = new DateTime($contrato->fechaTermino);
        } else {
          $finalizado = false;
          $ftermino = new DateTime();
        }
        $finicio = new DateTime($contrato->fechaInicio);
        $tiempo = $finicio->diff($ftermino);
        if ($tiempo->y >= 1) {
          $contrato->tiempo = $tiempo->y;
          $contrato->unidad = ($tiempo->y == 1) ? 'año' : 'años';
        } else {
          $contrato->tiempo = $tiempo->y * 12 + $tiempo->m;
          $contrato->unidad = ($contrato->tiempo  == 1) ? 'mes' : 'meses';
        }
        $contrato->select = true;
        $contrato->finalizado = $finalizado;
      }
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ' . $e->getMessage()));
  }
});

$app->post('/api/contratos', function (Request $request) {
  $codigoEgresado = $request->getParam('codigoEgresado');
  $cargo = $request->getParam('cargo');
  $fechaInicio = $request->getParam('inicio');
  $fechaTermino = $request->getParam('termino');
  $detalleFunciones = $request->getParam('descripcion');
  $codigoCentroLaboral = $request->getParam('centro');
  $actividadEconomica = $request->getParam('actividadEconomica');
  $codigoDistrito = $request->getParam('distrito');
  $ruc  = $request->getParam('ruc');
  $razonSocial  = $request->getParam('razonSocial');
  try {

    if (!$codigoCentroLaboral) {
      $codigo = $this->db->query("SELECT codigo FROM actividadeconomica where nombre = '$actividadEconomica'")->fetchall();
      if (!$codigo) {
        $insert = $this->db->exec("INSERT INTO actividadeconomica(nombre,vigencia)
                                  VALUES('$actividadEconomica',1)");
        $codigo = $this->db->query("SELECT last_insert_id() as codigo")->fetchAll();
      }
      $codigoActividad = $codigo[0]->codigo;
      $insert = $this->db->exec("INSERT INTO centrolaboral(codigoActividad,codigoDistrito,RUC,razonSocial,vigencia)
                                  VALUES('$codigoActividad',$codigoDistrito,'$ruc','$razonSocial',1)");
      $codigo = $this->db->query("SELECT last_insert_id() as codigo")->fetchAll();
      $codigoCentroLaboral = $codigo[0]->codigo;
    }
    if ($fechaTermino == null) {
      $cantidad = $this->db->exec("INSERT INTO contrato(codigoEgresado,codigoCentroLaboral,fechaInicio,cargo,fechaTermino,detalleFunciones,vigencia) 
      Values('$codigoEgresado','$codigoCentroLaboral','$fechaInicio','$cargo',null,'$detalleFunciones',1)");
    } else {
      $cantidad = $this->db->exec("INSERT INTO contrato(codigoEgresado,codigoCentroLaboral,fechaInicio,cargo,fechaTermino,detalleFunciones,vigencia) 
    Values('$codigoEgresado','$codigoCentroLaboral','$fechaInicio','$cargo','$fechaTermino','$detalleFunciones',1)");
    }


    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Contrato agregado correctamente'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo agregar el contrato'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ' . $e->getMessage()));
  }
});

$app->put('/api/contratos/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $codigoEgresado = $request->getParam('codigoEgresado');
  $codigoCentroLaboral = $request->getParam('centro');
  $fechaInicio = $request->getParam('inicio');
  $cargo = $request->getParam('cargo');
  $fechaTermino = $request->getParam('termino');
  $detalleFunciones = $request->getParam('descripcion');
  try {
    $sql = "UPDATE contrato set
    codigoEgresado ='$codigoEgresado',
    codigoCentroLaboral = '$codigoCentroLaboral',
    fechaInicio = '$fechaInicio',
    cargo = '$cargo',
    detalleFunciones = '$detalleFunciones',";
    if ($fechaTermino) {
      $sql .= "fechaTermino = '$fechaTermino' ";
    } else {
      $sql .= "fechaTermino = null ";
    }
    $sql .= "WHERE codigo = $codigo";
    $cantidad = $this->db->exec($sql);
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Contrato actualizado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han cambiado los datos'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->delete('/api/contratos/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $cantidad = $this->db->exec("DELETE FROM contrato 
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Contrato eliminado correctamente'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo eliminar el contrato'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->patch('/api/contratos/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $vigencia = ($request->getParam('vigencia')) ? 0 : 1;
  try {
    $cantidad = $this->db->exec("UPDATE contrato set
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
