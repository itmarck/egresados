<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/personal', function () {
  try {
    $data = $this->db->query("SELECT codigo,CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as nombre, dni, correo, vigencia FROM personal ")->fetchAll();
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

$app->get('/api/personal/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT codigo,nombres,apellidoPaterno,apellidoMaterno,dni,genero,correo,celular,urlFoto FROM personal WHERE codigo = $codigo and vigencia=1")->fetchAll();;
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

$app->post('/api/personal', function (Request $request) {
  $nombres = $request->getParam('nombres');
  $DNI = $request->getParam('dni');
  $apellidoPaterno = $request->getParam('paterno');
  $apellidoMaterno = $request->getParam('materno');
  $genero = $request->getParam('genero');
  $celular = $request->getParam('celular');
  $correo = $request->getParam('correo');
  $usuario = $request->getParam('usuario');
  $contraseña = $request->getParam('clave');
  try {
    $dni = $this->db->query("SELECT dni FROM persona WHERE dni = '$DNI'")->fetchAll();
    if (!$dni) {
      $this->db->beginTransaction();
      $cantidad = $this->db->exec("INSERT INTO personal(nombres,DNI,apellidoPaterno,apellidoMaterno,genero,celular,correo,urlfoto,vigencia) 
                            Values('$nombres','$DNI','$apellidoPaterno','$apellidoMaterno',$genero,'$celular','$correo','default.jpg',1)");
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
            echo json_encode(array('estado' => true, 'mensaje' => 'Personal registrado correctamente'));
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

$app->put('/api/personal/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $nombres = $request->getParam('nombres');
  $apellidoPaterno = $request->getParam('paterno');
  $apellidoMaterno = $request->getParam('materno');
  $genero = $request->getParam('genero');

  $celular = $request->getParam('celular');
  $correo = $request->getParam('correo');

  try {
    $cantidad = $this->db->exec("UPDATE personal set
                                nombres ='$nombres',
                                apellidoPaterno = '$apellidoPaterno',
                                apellidoMaterno = '$apellidoMaterno',
                                genero = '$genero',
                                celular = '$celular',
                                correo = '$correo'
                                WHERE codigo = $codigo");
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true, 'mensaje' => 'Personal actualizado correctamente'));
    } else {
      echo json_encode(array('estado' => true, 'mensaje' => 'No se han cambiado los datos personales'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->delete('/api/personal/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $cantidad = $this->db->exec("DELETE FROM personal 
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

$app->patch('/api/personal/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $vigencia = ($request->getParam('vigencia')) ? 0 : 1;
  try {
    $cantidad = $this->db->exec("UPDATE personal set
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

$app->post('/api/personal/images/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $directory = $this->get('upload_directory');

  $archivo = $request->getUploadedFiles();

  $imagen = $archivo['profile'];
  if ($imagen->getError() === UPLOAD_ERR_OK) {
    $filename = moveUploadedFile($directory, $imagen);
    echo json_encode(array('estado' => true, 'mensaje' => 'Foto agregada'));
    $this->db->exec("UPDATE personal SET urlfoto = '$filename' where codigo = $codigo");
  } else {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al subir la imagen'));
  }
});
