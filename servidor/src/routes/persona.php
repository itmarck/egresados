<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/personas', function () {
  try {
    $data = $this->db->query("SELECT codigo,CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as nombre, dni FROM persona WHERE vigencia=1")->fetchAll();
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": ' . $e->getMessage() . '}';
  }
});

$app->get('/api/personas/{DNI}', function (Request $request) {
  $DNI = $request->getAttribute('DNI');
  try {
    $data = $this->db->query("SELECT codigo,nombres,apellidoPaterno,apellidoMaterno, genero,fechaNacimiento,celular,correo,estadoCivil FROM persona WHERE DNI = $DNI and vigencia=1")->fetchAll();;
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": ' . $e->getMessage() . '}';
  }
});

$app->get('/api/personas/codigo/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
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
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false,'mensaje'=>'Error al conectar con la base de datos'));
  }
});

$app->post('/api/personas/add', function (Request $request) {
  $nombres = $request->getParam('nombres');
  $DNI = $request->getParam('DNI');
  $apellidoPaterno = $request->getParam('apellidoPaterno');
  $apellidoMaterno = $request->getParam('apellidoMaterno');
  $genero = $request->getParam('genero');
  $fechaNacimiento = $request->getParam('fechaNacimiento');
  $celular = $request->getParam('celular');
  $correo = $request->getParam('correo');
  $estadoCivil = $request->getParam('estadoCivil');
  try {
    $cantidad = $this->db->exec("INSERT INTO persona(nombres,DNI,apellidoPaterno,apellidoMaterno,genero,fechaNacimiento,celular,correo,estadoCivil,vigencia) 
                            Values('$nombres','$DNI','$apellidoPaterno','$apellidoMaterno',$genero,$fechaNacimiento,'$celular','$correo',$estadoCivil,1)");
    if ($cantidad > 0) {
      echo json_encode("Persona Registrada");
    } else {
      echo json_encode("No se ha agregado");
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false,'mensaje'=>'Error al conectar con la base de datos'));
  }
});

$app->put('/api/personas/{DNI}', function (Request $request) {
  $DNI = $request->getAttribute('DNI');
  $nombres = $request->getParam('nombres');
  $apellidoPaterno = $request->getParam('apellidoPaterno');
  $apellidoMaterno = $request->getParam('apellidoMaterno');
  $genero = $request->getParam('genero');
  $fechaNacimiento = $request->getParam('fechaNacimiento');
  $celular = $request->getParam('celular');
  $correo = $request->getParam('correo');
  $estadoCivil = $request->getParam('estadoCivil');
  try {
    $cantidad = $this->db->exec("UPDATE persona set
                                nombres ='$nombres',
                                apellidoPaterno = '$apellidoPaterno',
                                apellidoMaterno = '$apellidoMaterno',
                                genero = '$genero',
                                fechaNacimiento = '$fechaNacimiento',
                                celular = '$celular',
                                correo = '$correo',
                                estadoCivil = '$estadoCivil'  
                                WHERE DNI = $DNI");
    if ($cantidad > 0) {
      echo json_encode("Persona Actualizada");
    } else {
      echo json_encode("No se ha actualizado");
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false,'mensaje'=>'Error al conectar con la base de datos'));
  }
});

$app->delete('/api/personas/{DNI}', function (Request $request) {
  $DNI = $request->getAttribute('DNI');
  try {
    $cantidad = $this->db->exec("DELETE FROM persona 
                                WHERE dni = '$DNI'");
    if ($cantidad > 0) {
      echo json_encode("Persona Eliminada");
    } else {
      echo json_encode("No se ha Eliminado");
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false,'mensaje'=>'Error al conectar con la base de datos'));
  }
});

$app->patch('/api/personas/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $vigencia = ($request->getParam('vigencia')) ? 0 : 1;
  try {
    $cantidad = $this->db->exec("UPDATE persona set
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