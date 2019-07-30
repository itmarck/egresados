<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/reporte/admision/{admision}', function (Request $request) {
  $codigoAdmision = $request->getAttribute('admision');
  try {
    $data = $this->db->query("SELECT CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as nombre, YEAR(fechaTermino) as termino, T.fecha as titulacion,MT.nombre as modalidadTitulacion, C.codigo as colegiatura,C.fecha as fechaColegiatura 
                              FROM egresado E 
                              INNER JOIN persona on persona.codigo = codigoPersona
                              INNER JOIN titulacion T on E.codigo= T.codigoEgresado
                              INNER JOIN modalidadTitulacion MT on MT.codigo = T.codigoModalidad
                              INNER JOIN colegiatura C on E.codigo = C.codigoEgresado
                              INNER JOIN admision A on A.codigoEscuela = E.codigoEscuela
                              WHERE E.codigoAdmision = $codigoAdmision")->fetchAll();
    if ($data) {
      $result = array('estado' => true, 'data' => $data, 'mensaje' => 'Se han encontrado ' . count($data) . ' egresado(s)');
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
    $egresado = $this->db->query("SELECT codigo,CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as nombre,celular,correo,urlFoto
    FROM persona WHERE (DNI = $codigo or codigo = $codigo) and vigencia=1")->fetchAll();
    $carreras = $this->db->query("SELECT E.nombre, A.nombre as admision, CONCAT(YEAR(Eg.fechaInicio),' - ',YEAR(Eg.fechaTermino)) as fecha, C.codigo as colegiatura, C.fecha as fechaColegiatura,MA.nombre  as modalidad
                                  FROM egresado Eg INNER JOIN escuelaProfesional E ON Eg.codigoEscuela = E.codigo
                                  INNER JOIN admision A ON Eg.codigoAdmision = A.codigo 
                                  INNER JOIN modalidadAdmision MA on MA.codigo= A.codigoModalidad
                                  LEFT JOIN colegiatura C ON C.codigoEgresado = Eg.codigo
                                  INNER JOIN persona P on Eg.codigoPersona = P.codigo
                                  WHERE (DNI = $codigo or P.codigo = $codigo) ")->fetchAll();
    $estudiosPost = $this->db->query("SELECT Pt.nombre, CONCAT(YEAR(Pt.fechaInicio),' - ',YEAR(Pt.fechaTermino)) as fecha, IF(CE.razonSocial is null ,U.nombre,CE.razonSocial) as lugar
                                      FROM estudiosPostgrado Pt
                                      INNER JOIN egresado E on E.codigo =  Pt.codigoEgresado
                                      INNER JOIN persona P on E.codigoPersona = P.codigo
                                      LEFT JOIN centroEstudios CE on  CE.codigo = Pt.codigoCentroEstudios
                                      LEFT JOIN universidad U on U.codigo = Pt.codigoUniversidad 
                                      WHERE (DNI = $codigo or P.codigo = $codigo)")->fetchAll();
    $laboral = $this->db->query("SELECT A.nombre as actividad , D.nombre  as distrito, cargo, razonSocial as nombre, YEAR(C.fechainicio) as fechaInicio
                                FROM persona P
                                INNER JOIN egresado E on E.codigoPersona = P.codigo
                                INNER JOIN contrato C on C.codigoEgresado = E.codigo
                                INNER JOIN centroLaboral CL on CL.codigo = C.codigoCentroLaboral
                                INNER JOIN actividadeconomica A on A.codigo=CL.codigoActividad 
                                INNER JOIN distrito D on D.codigo = CL.codigoDistrito  
                                WHERE (DNI = $codigo or P.codigo = $codigo) and C.fechatermino is null ")->fetchAll();
    if ($egresado || $carreras || $estudiosPost) {
      $data = array('egresado' => $egresado[0], 'carreras' => $carreras, 'estudiosPost' => $estudiosPost, 'laboral' => $laboral);
      echo json_encode(array('estado' => true, 'data' => $data, 'mensaje' => 'Se han encontrado ' . count($carreras) . ' carrera(s) y ' . count($estudiosPost) . ' postgrado(s)'));
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
    $egresado = $this->db->query("SELECT CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as Nombre,celular,correo, dni, urlFoto
                                  FROM persona P
                                  INNER JOIN egresado E on E.codigoPersona = P.codigo
                                  INNER JOIN contrato C on C.codigoEgresado = E.codigo
                                  INNER JOIN centroLaboral CL on CL.codigo = C.codigoCentroLaboral
                                  WHERE CL.codigoDistrito = $codigo and C.fechatermino is null")->fetchAll();
    if ($egresado) {
      echo json_encode(array('estado' => true, 'data' => $egresado, 'mensaje' => 'Se han encontrado ' . count($egresado) . ' egresado(s)'));
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
    $egresado = $this->db->query("SELECT CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as Nombre,
                                  celular,correo,CL.razonsocial,C.cargo,C.detalleFunciones, 0 as toggle
                                  FROM persona P
                                  INNER JOIN egresado E on E.codigoPersona = P.codigo
                                  INNER JOIN contrato C on C.codigoEgresado = E.codigo
                                  INNER JOIN centroLaboral CL on CL.codigo = C.codigoCentroLaboral
                                  WHERE CL.codigoActividad = $codigo and C.fechatermino is null")->fetchAll();
    if ($codigo) {
      echo json_encode(array('estado' => true, 'data' => $egresado, 'mensaje' => 'Se han encontrado ' . count($egresado) . ' egresado(s)'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});
