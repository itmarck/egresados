<?php
use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/personas', function () {
 try {
  $data = $this->db->query("SELECT * FROM persona")->fetchAll();
  if ($data) {
      echo json_encode($data);
  }else {
    echo json_encode("No existen Personas en la DB");
  }
 } catch (PDOException $e) {
  echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->get('/api/personas/{codigo}',function(Request $request){
   $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT * FROM persona WHERE codigo = $codigo")->fetchAll();;
    if ($data) {
      echo json_encode($data);
    } else {
      echo json_encode("No existe en la DB");
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->post('/api/personas/add',function(Request $request){
  $nombres = $request->getParam('nombres');
  $apellidoPaterno = $request->getParam('apellidoPaterno');
  $apellidoMaterno = $request->getParam('apellidoMaterno');
  $genero = $request->getParam('genero');
  $fechaNacimiento = $request->getParam('fechaNacimiento');
  $celular = $request->getParam('celular');
  $correo = $request->getParam('correo');
  $estadoCivil = $request->getParam('estadoCivil');
 try {
   $cantidad = $this->db->exec("INSERT INTO persona(nombres,apellidoPaterno,apellidoMaterno,genero,fechaNacimiento,celular,correo,estadoCivil,vigencia) 
                            Values('$nombres','$apellidoPaterno',$apellidoMaterno,$genero,$fechaNacimiento,$celular,$correo,$estadoCivil,1)");
   if ($cantidad > 0) {
     echo json_encode("Persona Registrada");
   } else {
     echo json_encode("No se ha agregado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->put('/api/personas/update/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
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
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
     echo json_encode("Persona Actualizada");
   } else {
     echo json_encode("No se ha actualizado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->delete('/api/personas/delete/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
 try {
   $cantidad = $this->db->exec("DELETE FROM persona 
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
     echo json_encode("Persona Eliminada");
   } else {
     echo json_encode("No se ha Eliminado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});