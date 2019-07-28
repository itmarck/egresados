<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/reporte/admision/{admision}', function (Request $request) {
  $codigoAdmision = $request->getAttribute('admision');
  try {
    $data = $this->db->query("SELECT nombres, YEAR(fechaTermino) as Termino, T.codigoEgresado as Titulacion, C.codigoEgresado as Colegiatura
                              FROM egresado E 
                              INNER JOIN persona on persona.codigo = codigoPersona
                              INNER JOIN titulacion T on E.codigo= T.codigoEgresado
                              INNER JOIN colegiatura C on E.codigo = C.codigoEgresado
                              INNER JOIN admision A on A.codigoEscuela = E.codigoEscuela
                              WHERE E.codigoAdmision = $codigoAdmision")->fetchAll();
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos', 'data' => []));
  }
});


$app->get('/api/reporte/dni/{dni}', function (Request $request) {
    $codigo = $request->getAttribute('dni');
    try {
      $egresado = $this->db->query("SELECT codigo,CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as Nombre,celular,correo
    FROM persona WHERE (DNI = $codigo or codigo = $codigo) and vigencia=1")->fetchAll();
      $carreras = $this->db->query("SELECT E.nombre, A.nombre as admision, YEAR(Eg.fechaTermino) as FechaEgreso, C.codigo as colegiatura 
              FROM egresado Eg INNER JOIN escuelaProfesional E ON Eg.codigoEscuela = E.codigo
              INNER JOIN admision A ON Eg.codigoAdmision = A.codigo 
              INNER JOIN colegiatura C ON C.codigoEgresado = Eg.codigo
              INNER JOIN persona P on Eg.codigoPersona = P.codigo
              WHERE (DNI = $codigo or P.codigo = $codigo) ")->fetchAll();
      $estudiosPost = $this->db->query("SELECT Pt.nombre, Pt.fechaTermino
                                      FROM estudiosPostgrado Pt
                                      INNER JOIN egresado E on E.codigo =  Pt.codigoEgresado
                                      INNER JOIN persona P on E.codigoPersona = P.codigo
                                      WHERE (DNI = $codigo or P.codigo = $codigo)")->fetchAll();
      if ($egresado || $carreras || $estudiosPost) {
        $data = array('egresado' => $egresado, 'carreras' => $carreras, 'estudiosPost' => $estudiosPost);
        echo json_encode(array('estado' => true, 'data' => $data));
      } else {
        echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
      }
    } catch (PDOException $e) {
      echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
    }
  });

  $app->get('/api/reporte/distrito/{distrito}', function (Request $request) {
    $codigo = $request->getAttribute('distrito');
    try {
     
      if ($codigo) {
        echo json_encode(array('estado' => true, 'data' => $data));
      } else {
        echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
      }
    } catch (PDOException $e) {
      echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
    }
  });

  $app->get('/api/reporte/actividad/{actividad}', function (Request $request) {
    $codigo = $request->getAttribute('actividad');
    try {
     
      if ($codigo) {
        echo json_encode(array('estado' => true, 'data' => $data));
      } else {
        echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
      }
    } catch (PDOException $e) {
      echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
    }
  });