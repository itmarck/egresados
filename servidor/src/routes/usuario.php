<?php
use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/usuarios', function () {
 try {
  $data = $this->db->query("SELECT codigo,codigoPersonal,nombre,clave,tipo,codigoPersona FROM usuario WHERE vigencia=1")->fetchAll();
  if ($data) {
      echo json_encode($data);
  }else {
    echo json_encode("No existen Usuarios en la DB");
  }
 } catch (PDOException $e) {
  echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->post('/api/usuarios/tipo',function(Request $request){
  $clave = $request->getParam('clave');
  $nombre = $request->getParam('nombre');
  $result = [];
 try {
  $usuario = $this->db->query("SELECT nombre FROM usuario WHERE nombre = '$nombre' and vigencia=1")->fetchAll();
   if ($usuario) {
            $user = $this->db->query("SELECT codigoPersona FROM usuario WHERE nombre = '$nombre' and clave = '$clave' and vigencia=1")->fetchAll();
            if ($user) {
              $sql =  "SELECT tipo, P.codigo,dni,urlFoto, P.nombres,apellidoPaterno,apellidoMaterno FROM usuario ";
              $codigoPersona = $user[0]->codigoPersona;
              if (!$codigoPersona) {
                $sql = $sql . "INNER JOIN personal P on P.codigo = usuario.codigoPersonal
                WHERE nombre = '$nombre' and clave = '$clave' and usuario.vigencia=1";
                $data = $this->db->query($sql)->fetchAll();
              }else {
                $sql = $sql . "INNER JOIN persona P on P.codigo = usuario.codigoPersona
                WHERE nombre = '$nombre' and clave = '$clave' and usuario.vigencia=1";
                $data = $this->db->query($sql)->fetchAll();
              }
                $result = array('estado' => true);
                array_push($result,$data);
                echo json_encode($result);
            }
         else {
        $result = array('estado' => false);
        array_push($result,"Clave Inconrrecta");
        echo json_encode($result);
      }
   } else {
    $result = array('estado' => false);
    array_push($result,"Usuario incorrecto");
     echo json_encode($result);
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->get('/api/usuarios/{codigo}',function(Request $request){
   $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT codigo,codigoPersonal,nombre,clave,tipo,codigoPersona FROM usuario WHERE codigo = $codigo and vigencia=1")->fetchAll();;
    if ($data) {
     
      echo json_encode($data);
    } else {
      echo json_encode("No existe en la DB");
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->post('/api/usuarios/add',function(Request $request){
  $nombre = $request->getParam('nombre');
  $codigoPersonal = $request->getParam('codigoPersonal');
  $clave = $request->getParam('clave');
  $tipo = $request->getParam('tipo');
  $codigoPersona = $request->getParam('codigoPersona');
 try {
   $cantidad = $this->db->exec("INSERT INTO usuario(nombre,codigoPersonal,clave,tipo,codigoPersona,vigencia) 
                            Values('$nombre','$codigoPersonal',$clave,$tipo,$codigoPersona,1)");
   if ($cantidad > 0) {
     echo json_encode("Usuario Registrada");
   } else {
     echo json_encode("No se ha agregado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->put('/api/usuarios/update/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  $codigoPersonal = $request->getParam('codigoPersonal');
  $clave = $request->getParam('clave');
  $tipo = $request->getParam('tipo');
  $codigoPersona = $request->getParam('codigoPersona');
 try {
   $cantidad = $this->db->exec("UPDATE usuario set
                                nombre ='$nombre',
                                codigoPersonal = '$codigoPersonal',
                                clave = '$clave',
                                codigoPersona = '$codigoPersona',
                                tipo = '$tipo'  
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
     echo json_encode("Usuario Actualizado");
   } else {
     echo json_encode("No se ha actualizado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->delete('/api/usuarios/delete/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
 try {
   $cantidad = $this->db->exec("DELETE FROM usuario 
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
     echo json_encode("Usuario Eliminado");
   } else {
     echo json_encode("No se ha Eliminado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});