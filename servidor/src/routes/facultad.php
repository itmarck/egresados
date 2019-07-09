<?php
use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/facultades', function () {
 try {
  $data = $this->db->query("SELECT codigo,nombre,siglas,estado  FROM facultad WHERE vigencia=1")->fetchAll();
  if ($data) {
      echo json_encode($data);
  }else {
    echo json_encode("No existen Facultades en la DB");
  }
 } catch (PDOException $e) {
  echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->get('/api/facultades/{codigo}',function(Request $request){
   $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT codigo,nombre,siglas,estado FROM facultad WHERE codigo = $codigo and vigencia = 1 ")->fetchAll();;
    if ($data) {
      echo json_encode($data);
    } else {
      echo json_encode("No existe en la DB");
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->post('/api/facultades/add',function(Request $request){
  $nombre = $request->getParam('nombre');
  $siglas = $request->getParam('siglas');
  $estado = $request->getParam('estado');
 try {
   $cantidad = $this->db->exec("INSERT INTO facultad(nombre,siglas,estado,vigencia) 
                            Values('$nombre','$siglas',$estado,1)");
   if ($cantidad > 0) {
     echo json_encode("Facultad Registrada");
   } else {
     echo json_encode("No se ha agregado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->put('/api/facultades/update/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  $siglas = $request->getParam('siglas');
  $estado = $request->getParam('estado');
 try {
   $cantidad = $this->db->exec("UPDATE facultad set
                                nombre ='$nombre',
                                siglas = '$siglas',
                                estado = '$estado' 
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
     echo json_encode("Facultad Actualizada");
   } else {
     echo json_encode("No se ha actualizado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->delete('/api/facultades/delete/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
 try {
   $cantidad = $this->db->exec("DELETE FROM facultad 
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
     echo json_encode("Facultad Eliminada");
   } else {
     echo json_encode("No se ha Eliminado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});