<?php
use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/personal', function () {
 try {
  $data = $this->db->query("SELECT codigo,nombres,apellidoPaterno,apellidoMaterno,dni,genero,correo,celular FROM personal WHERE vigencia=1")->fetchAll();
  if ($data) {
      echo json_encode($data);
  }else {
    echo json_encode("No existe Personal en la DB");
  }
 } catch (PDOException $e) {
  echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->get('/api/personal/{codigo}',function(Request $request){
   $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT codigo,nombres,apellidoPaterno,apellidoMaterno,dni,genero,correo,celular FROM personal WHERE codigo = $codigo and vigencia=1")->fetchAll();;
    if ($data) {
      echo json_encode($data);
    } else {
      echo json_encode("No existe en la DB");
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->post('/api/personal/add',function(Request $request){
  $nombres = $request->getParam('nombres');
  $apellidoPaterno = $request->getParam('apellidoPaterno');
  $apellidoMaterno = $request->getParam('apellidoMaterno');
  $genero = $request->getParam('genero');
  
  $celular = $request->getParam('celular');
  $correo = $request->getParam('correo');
 
 try {
   $cantidad = $this->db->exec("INSERT INTO personal(nombres,apellidoPaterno,apellidoMaterno,genero,celular,correo,vigencia) 
                            Values('$nombres','$apellidoPaterno',$apellidoMaterno,$genero,$celular,$correo,1)");
   if ($cantidad > 0) {
     echo json_encode("Personal Registrado");
   } else {
     echo json_encode("No se ha agregado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->put('/api/personal/update/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
  $nombres = $request->getParam('nombres');
  $apellidoPaterno = $request->getParam('apellidoPaterno');
  $apellidoMaterno = $request->getParam('apellidoMaterno');
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
     echo json_encode("Personal Actualizado");
   } else {
     echo json_encode("No se ha actualizado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->delete('/api/personal/delete/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
 try {
   $cantidad = $this->db->exec("DELETE FROM personal 
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
     echo json_encode("Personal Eliminado");
   } else {
     echo json_encode("No se ha Eliminado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});