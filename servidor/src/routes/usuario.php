<?php

use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/usuarios', function () {
  try {
    $data = $this->db->query("SELECT codigo,codigoPersonal,nombre,clave,tipo,codigoPersona FROM usuario WHERE vigencia=1")->fetchAll();
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

$app->post('/api/usuarios/ingresar', function (Request $request) {
  $clave = $request->getParam('clave');
  $nombre = $request->getParam('nombre');
  $result = [];
  try {
    $usuario = $this->db->query("SELECT nombre , clave,vigencia FROM usuario WHERE nombre = '$nombre'")->fetchAll();
    if ($usuario) {
      if ($usuario[0]->vigencia == 1) {
        if (password_verify($clave, $usuario[0]->clave)) {
          $user = $this->db->query("SELECT codigoPersona FROM usuario WHERE nombre = '$nombre'  and vigencia=1")->fetchAll();
          $sql =  "SELECT tipo, P.codigo,dni,urlFoto, P.nombres,apellidoPaterno,apellidoMaterno, CONCAT(P.nombres,' ',apellidoPaterno,' ',apellidoMaterno) as nombre FROM usuario ";
          $codigoPersona = $user[0]->codigoPersona;
          if (!$codigoPersona) {
            $sql = $sql . "INNER JOIN personal P on P.codigo = usuario.codigoPersonal
                  WHERE nombre = '$nombre'  and usuario.vigencia=1";
          } else {
            $sql = $sql . "INNER JOIN persona P on P.codigo = usuario.codigoPersona
                  WHERE nombre = '$nombre'  and usuario.vigencia=1";
          }
          $data = $this->db->query($sql)->fetchAll();
          $result = array('estado' => true, 'mensaje' => 'Ingresando...', 'data' => $data[0]);
          echo json_encode($result);
        } else {
          $result = array('estado' => false, 'mensaje' => 'Contraseña Incorrecta');
          echo json_encode($result);
        }
      } else {
        $result = array('estado' => false, 'mensaje' => 'Usuario inhabilitado');
        echo json_encode($result);
      }
      
    } else {
      $result = array('estado' => false, 'mensaje' => 'Usuario no existe');
      echo json_encode($result);
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->get('/api/usuarios/{dni}', function (Request $request) {
  $dni = $request->getAttribute('dni');
  try {
    $tipo= $this->db->query("SELECT codigoPersona FROM usuario U INNER JOIN persona P on P.codigo = codigoPersona 
                            WHERE dni = $dni")->fetchAll();
    if ($tipo) {
      $data = $this->db->query("SELECT dni, P.codigo,tipo,nombres,apellidoPaterno,apellidoMaterno,urlFoto 
      FROM usuario INNER JOIN persona P on P.codigo= codigoPersona  WHERE dni = $dni ")->fetchAll();
    } else {
      $data = $this->db->query("SELECT dni,P.codigo,nombres,apellidoPaterno,apellidoMaterno,urlFoto FROM usuario INNER JOIN personal P on P.codigo = codigoPersonal WHERE dni = $dni")->fetchAll();
    }
      if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ', $e->getMessage()));
  }
});

$app->post('/api/usuarios/add', function (Request $request) {
  $nombre = $request->getParam('nombre');
  $codigoPersonal = $request->getParam('codigoPersonal');
  $clave = $request->getParam('clave');
  $tipo = $request->getParam('tipo');
  $codigoPersona = $request->getParam('codigoPersona');
  try {
    $hash = password_hash($clave, PASSWORD_DEFAULT);
    $nombre = $this->db->query("SELECT nombre FROM usuario WHERE nombre = '$nombre'")->fetchAll();
    if (!$nombre) {
      if ($codigoPersona) {
        $cantidad = $this->db->exec("INSERT INTO usuario(nombre,clave,tipo,codigoPersona,vigencia) 
      Values('$nombre','$hash','$tipo',$codigoPersona,1)");
      } else {
        $cantidad = $this->db->exec("INSERT INTO usuario(nombre,codigoPersonal,clave,tipo,vigencia) 
      Values('$nombre','$codigoPersonal','$hash','$tipo',1)");
      }
      if ($cantidad > 0) {
        echo json_encode(array('estado' => true));
      } else {
        echo json_encode(array('estado' => false));
      }
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'Nombre de usuario ya existe'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->put('/api/usuarios/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  $codigoPersonal = $request->getParam('codigoPersonal');
  $clave = $request->getParam('clave');
  $tipo = $request->getParam('tipo');
  $codigoPersona = $request->getParam('codigoPersona');
  try {
    $user = $this->db->query("SELECT codigoPersona FROM usuario WHERE codigo = '$codigo' and vigencia=1")->fetchAll();
    $hash = password_hash($clave, PASSWORD_DEFAULT);
    $Persona = $user[0]->codigoPersona;
    $sql = "UPDATE usuario set
            nombre ='$nombre',
            clave = '$hash',
            tipo = '$tipo',  ";
    if (!$Persona) {
      $sql = $sql . "codigoPersonal = '$codigoPersonal', codigoPersona = null ";
    } else {
      $sql = $sql . "codigoPersonal = null, codigoPersona = '$codigoPersona' ";
    }
    $sql = $sql . "WHERE codigo=$codigo";
    $cantidad = $this->db->exec($sql);
    if ($cantidad > 0) {
      echo json_encode(array('estado' => true));
    } else {
      echo json_encode(array('estado' => false));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
  }
});

$app->delete('/api/usuarios/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  try {
    $cantidad = $this->db->exec("DELETE FROM usuario 
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

$app->patch('/api/usuarios/{codigo}', function (Request $request) {
  $codigoP = $request->getAttribute('codigo');
  $pass = $request->getParam('nueva');
  $old = $request->getParam('actual');
  $tipo = $request->getParam('tipo');
  try {
    if ($tipo == "persona") {
      $codigo = $this->db->query("SELECT U.codigo, U.clave FROM usuario U INNER JOIN persona P on P.codigo = U.codigoPersona  WHERE codigoPersona = '$codigoP' ")->fetchAll();
    } else {
      $codigo = $this->db->query("SELECT U.codigo, U.clave FROM usuario U INNER JOIN personal P on P.codigo = U.codigoPersonal  WHERE codigoPersonal = '$codigoP' ")->fetchAll();
    }
    if (password_verify($old, $codigo[0]->clave)) {

      $codigo = $codigo[0]->codigo;
      $hash = password_hash($pass, PASSWORD_DEFAULT);
      $cantidad = $this->db->exec("UPDATE usuario set
                                clave = '$hash'
                                WHERE codigo = $codigo");
      if ($cantidad > 0) {
        echo json_encode(array('estado' => true, 'mensaje' => 'Contraseña actualizada'));
      } else {
        echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar la contraseña'));
      }
    } else {
      echo json_encode(array('estado' => false, 'mensaje' => 'La contraseña actual no coincide'));
    }
  } catch (PDOException $e) {
    echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ' . $e->getMessage()));
  }
});
