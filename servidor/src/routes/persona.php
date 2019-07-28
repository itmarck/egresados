<?php

use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Http\UploadedFile;

const contraseña = "3P1CI*2019";

$app->get('/api/personas', function () {
  try {
    $data = $this->db->query("SELECT codigo,CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as nombre, dni FROM persona")->fetchAll();
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

$app->get('/api/personas-objeto-disabled', function () {
  try {
    $data = $this->db->query("SELECT codigo,CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as nombre, dni as descripcion FROM persona where vigencia = 0")->fetchAll();
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

$app->get('/api/personas/{DNI}', function (Request $request) {
  $DNI = $request->getAttribute('DNI');
  try {
    $data = $this->db->query("SELECT codigo,dni,nombres,apellidoPaterno,apellidoMaterno, genero,fechaNacimiento,celular,correo,estadoCivil,vigencia,privacidad,urlFoto FROM persona WHERE DNI = $DNI ")->fetchAll();;
    if ($data) {
      $result = array('estado' => true, 'data' => $data[0]);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
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
      echo json_encode(array('estado' => true, 'data' => $data));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->get('/api/personas-publico', function () {
  try {
    $carreras = $this->db->query("SELECT CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as nombres,urlFoto, EP.nombre, E.fechaTermino
                              FROM persona P 
                              INNER JOIN egresado E ON E.codigoPersona = P.codigo
                              INNER JOIN escuelaprofesional EP on EP.codigo = E.codigoEscuela
                              WHERE P.privacidad = 0
                              ORDER BY fechaTermino DESC
                              LIMIT 25")->fetchAll();
    $postgrados = $this->db->query("SELECT CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as nombres,urlFoto, EP.fechaTermino, EP.nombre
                                    FROM persona P 
                                    INNER JOIN egresado E ON E.codigoPersona = P.codigo
                                    INNER JOIN estudiospostgrado EP on EP.codigoEgresado = E.codigo
                                    WHERE P.privacidad = 0
                                    ORDER BY fechaTermino DESC
                                    LIMIT 25")->fetchAll();
    $data = array_merge($carreras, $postgrados);
    usort($data, 'ordenar');
    $data = array_slice($data, 0, 20);
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

$app->post('/api/personas', function (Request $request) {
  $nombres = $request->getParam('nombres');
  $DNI = $request->getParam('dni');
  $apellidoPaterno = $request->getParam('paterno');
  $apellidoMaterno = $request->getParam('materno');
  $genero = $request->getParam('genero');
  $fechaNacimiento = $request->getParam('fecha');
  $celular = $request->getParam('celular');
  $correo = $request->getParam('correo');
  $estadoCivil = $request->getParam('estado');
  $usuario = $request->getParam('usuario');
  $contraseña = $request->getParam('clave');
  try {
    $dni = $this->db->query("SELECT dni FROM persona WHERE dni = '$DNI'")->fetchAll();
    if (!$dni) {
      $this->db->beginTransaction();
      $cantidad = $this->db->exec("INSERT INTO persona(nombres,DNI,apellidoPaterno,apellidoMaterno,genero,fechaNacimiento,celular,correo,estadoCivil,urlfoto,vigencia) 
                            Values('$nombres','$DNI','$apellidoPaterno','$apellidoMaterno',$genero,'$fechaNacimiento','$celular','$correo','$estadoCivil','default.jpg',1)");
      if ($cantidad > 0) {
        $persona = $this->db->query("SELECT last_insert_id() as codigo")->fetchAll();
        $codigo = $persona[0]->codigo;
        $hash = password_hash(($contraseña) ? $contraseña : contraseña, PASSWORD_DEFAULT);
        $nombre = $this->db->query("SELECT nombre FROM usuario WHERE nombre = '$usuario'")->fetchAll();
        if (!$nombre) {
          $cantidad = $this->db->exec("INSERT INTO usuario(nombre,clave,tipo,codigoPersona,vigencia)
                                  VALUES('$usuario','$hash','E',$codigo,1)");
          if ($cantidad > 0) {
            $this->db->commit();
            echo json_encode(array('estado' => true, 'mensaje' => 'Persona registrada correctamente'));
          } else {
            $this->db->rollback();
            echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar el usuario'));
          }
        } else {
          echo json_encode(array('estado' => false, 'mensaje' => 'Uy. Al parecer el nombre de usuario ya existe'));
        }
      } else {
        echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo registrar la persona'));
      }
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'Uy. Al parecer el DNI ya esta registrado'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ' . $e->getMessage()));
  }
});

$app->put('/api/personas/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $DNI = $request->getParam('dni');
  $nombres = $request->getParam('nombres');
  $apellidoPaterno = $request->getParam('paterno');
  $apellidoMaterno = $request->getParam('materno');
  $genero = $request->getParam('genero');
  $fechaNacimiento = $request->getParam('fecha');
  $celular = $request->getParam('celular');
  $correo = $request->getParam('correo');
  $estadoCivil = $request->getParam('estado');
  try {
    $cantidad = $this->db->exec("UPDATE persona set
                                nombres ='$nombres',
                                apellidoPaterno = '$apellidoPaterno',
                                apellidoMaterno = '$apellidoMaterno',
                                genero = '$genero',
                                fechaNacimiento = '$fechaNacimiento',
                                celular = '$celular',
                                correo = '$correo',
                                estadoCivil = '$estadoCivil',
                                dni = '$DNI'  
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Datos de persona actualizados.'));
    } else {
      echo json_encode(array('estado' => true, 'mensaje' => 'No se han cambiado los datos personales.'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->delete('/api/personas-objeto-disabled', function (Request $request) {
  $codigo = $request->getParam('codigo');
  try {
    $cantidad = $this->db->exec("DELETE FROM persona 
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Persona Eliminada, siempre estará en nuestra memoria'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar la vigencia'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->patch('/api/personas/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $vigencia = ($request->getParam('vigencia')) ? 0 : 1;
  try {
    $cantidad = $this->db->exec("UPDATE persona set
                                vigencia = $vigencia
                                WHERE codigo = $codigo");
    $cantidad = $this->db->exec(" UPDATE usuario set 
                                vigencia = $vigencia
                                WHERE codigoPersona = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => (!$vigencia) ? 'Persona eliminada, siempre estará en nuestra memoria' : 'Persona rescatada del inframundo'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar la vigencia'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ' . $e->getMessage()));
  }
});
$app->patch('/api/personas/privacidad/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $privacidad = ($request->getParam('privacidad')) ? 0 : 1;
  try {
    $cantidad = $this->db->exec("UPDATE persona set
                                privacidad = $privacidad
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => (!$privacidad) ?  'Ahora tu perfil es publico' : 'Ahora tu perfil es privado'));
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar la privacidad'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ' . $e->getMessage()));
  }
});

$app->post('/api/personas/images/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $directory = $this->get('upload_directory');

  $archivo = $request->getUploadedFiles();

  $imagen = $archivo['profile'];
  if ($imagen->getError() === UPLOAD_ERR_OK) {
    $filename = moveUploadedFile($directory, $imagen);
    echo json_encode(array('estado' => true, 'mensaje' => 'Foto agregada'));
    $file = $this->db->query("SELECT urlFoto FROM persona WHERE codigo = $codigo")->fetchAll();
    $file = $file[0]->urlFoto;
    unlink("../public/images/" . $file);
    $this->db->exec("UPDATE persona SET urlfoto = '$filename' where codigo = $codigo");
  } else {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al subir la imagen'));
  }
});

function moveUploadedFile($directory, UploadedFile $imagen)
{
  $extension = pathinfo($imagen->getClientFilename(), PATHINFO_EXTENSION);
  $basename = bin2hex(random_bytes(10));
  $filename = sprintf('%s.%0.8s', $basename, $extension);

  $imagen->moveTo($directory . DIRECTORY_SEPARATOR . $filename);

  return $filename;
}

function ordenar($a, $b)
{
  return strtotime($b->fechaTermino) - strtotime($a->fechaTermino);
}
