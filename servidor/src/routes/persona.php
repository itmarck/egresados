<?php

use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Http\UploadedFile;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '../PHPMailer/Exception.php';
require '../PHPMailer/PHPMailer.php';
require '../PHPMailer/SMTP.php';

$app->get('/api/personas', function () {
  try {
    $data = $this->db->query("SELECT codigo,CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as nombre, dni, vigencia FROM persona")->fetchAll();
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
    $data = $this->db->query("SELECT codigo,CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as nombre, dni as descripcion, vigencia FROM persona where vigencia = 0")->fetchAll();
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


$app->get('/api/personas-publico', function () {
  try {
    $carreras = $this->db->query("SELECT CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as nombres,U.nombre as lugar,urlFoto, EP.nombre, E.fechaTermino as fecha, 'C' as tipo
                              FROM persona P 
                              INNER JOIN egresado E ON E.codigoPersona = P.codigo
                              INNER JOIN escuelaprofesional EP on EP.codigo = E.codigoEscuela
                              INNER JOIN universidad U on EP.codigoUniversidad = U.codigo
                              WHERE P.privacidad = 0
                              ORDER BY fechaTermino DESC
                              LIMIT 20")->fetchAll();
    $postgrados = $this->db->query("SELECT CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as nombres,IF(CE.razonSocial is null ,U.nombre,CE.razonSocial) as lugar ,urlFoto, EP.fechaTermino as fecha, EP.nombre, 'P' as tipo
                                    FROM persona P 
                                    INNER JOIN egresado E ON E.codigoPersona = P.codigo
                                    INNER JOIN estudiospostgrado EP on EP.codigoEgresado = E.codigo
                                    LEFT JOIN centroestudios CE on  CE.codigo = EP.codigoCentroEstudios
                                    LEFT JOIN universidad U on U.codigo = EP.codigoUniversidad 
                                    WHERE P.privacidad = 0
                                    ORDER BY EP.fechaTermino DESC
                                    LIMIT 20")->fetchAll();
    $experiencia = $this->db->query("SELECT CONCAT(nombres,' ',apellidoPaterno,' ',apellidoMaterno) as nombres, CL.razonsocial as lugar,C.cargo as nombre,C.fechaInicio as fecha, IF(C.fechaTermino,C.fechaTermino,c.fechaInicio) as fecha , urlFoto,'T' as tipo
                                    FROM persona P
                                    INNER JOIN egresado E on E.codigoPersona = P.codigo
                                    INNER JOIN contrato C on C.codigoEgresado = E.codigo
                                    INNER JOIN centrolaboral CL on CL.codigo = C.codigoCentroLaboral
                                    WHERE P.privacidad = 0
                                    ORDER BY fecha DESC
                                    LIMIT 20")->fetchAll();
    $data = array_merge($carreras, $postgrados, $experiencia);
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
        $clave = ($contraseña != null) ? $contraseña : "3P1CI*2019";
        $hash = str_replace('/', '', password_hash($clave, PASSWORD_DEFAULT));
        $nombre = $this->db->query("SELECT nombre FROM usuario WHERE nombre = '$usuario'")->fetchAll();
        if (!$nombre) {
          $cantidad = $this->db->exec("INSERT INTO usuario(nombre,clave,tipo,codigoPersona,vigencia)
                                  VALUES('$usuario','$hash','E',$codigo,1)");
          if ($cantidad > 0) {
            $this->db->commit();
            require '../PHPMailer/Plantillas.php';
            $mail = new PHPMailer(true);
            $mail->SMTPDebug = 0;
            $mail->isSMTP();
            $mail->Host       = 'smtp.gmail.com';
            $mail->SMTPAuth   = true;
            $mail->Username   = 'egresados.unprg@gmail.com';
            $mail->Password   = 'EGRESADOS2019';
            $mail->SMTPSecure = 'tls';
            $mail->Port       = 587;
            $mail->setFrom('egresados.unprg@gmail.com', 'Egresados Unprg');
            $mail->addAddress("$correo");
            $mail->isHTML(true);
            $mail->Subject = 'Invitaci&oacuten al sistema de seguimiento de egresados';
            $mail->Body    = $bienvenida;
            $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
            $mail->send();
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
  return strtotime($b->fecha) - strtotime($a->fecha);
}

$app->post('/api/correo', function (Request $request) {
  require '../PHPMailer/Plantillas.php';
  $mail = new PHPMailer(true);
  $mail->SMTPDebug = 2;
  $mail->isSMTP();
  $mail->Host       = 'smtp.gmail.com';
  $mail->SMTPAuth   = true;
  $mail->Username   = 'egresados.unprg@gmail.com';
  $mail->Password   = 'EGRESADOS2019';
  $mail->SMTPSecure = 'tls';
  $mail->Port       = 587;
  $mail->CharSet = 'UTF-8';
  $mail->setFrom('egresados.unprg@gmail.com', 'Egresados Unprg');
  $mail->addAddress("javier120699lili@gmail.com");
  $mail->addAddress("fabianpacherres@gmail.com");
  $mail->isHTML(true);
  $mail->Subject =  '¡Bienvenido!';
  $mail->Body    = $bienvenida;
  $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
  $mail->send();
});
