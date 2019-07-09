<?php
use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/colegiaturas', function () {
 try {
  $data = $this->db->query("SELECT codigo,codigoEgresado,codigo,fecha FROM colegiatura WHERE vigencia=1")->fetchAll();
  if ($data) {
      echo json_encode($data);
  }else {
    echo json_encode("No existen Colegiaturas registradas");
  }
 } catch (PDOException $e) {
  echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->get('/api/colegiaturas/{codigoEgresado}',function(Request $request){
   $codigoEgresado = $request->getAttribute('codigoEgresado');
  try {
    $data = $this->db->query("SELECT codigo,codigoEgresado,codigo,fecha FROM colegiatura WHERE codigoEgresado = $codigoEgresado and vigencia=1")->fetchAll();;
    if ($data) {
      echo json_encode($data);
    } else {
      echo json_encode("No existe en la DB");
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->post('/api/colegiaturas/add',function(Request $request){
  $codigoEgresado = $request->getParam('codigoEgresado');
  $fecha = $request->getParam('fecha');
 try {
   $cantidad = $this->db->exec("INSERT INTO colegiatura(codigoEgresado,fecha,vigencia) 
                            Values('$codigoEgresado','$fecha',1)");
   if ($cantidad > 0) {
     echo json_encode("Colegiatura Registrada");
   } else {
     echo json_encode("No se ha agregado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->put('/api/colegiaturas/update/{codigoEgresado}',function(Request $request){
  $codigoEgresado = $request->getAttribute('codigoEgresado');
  $fecha = $request->getParam('fecha');
 try {
   $cantidad = $this->db->exec("UPDATE colegiatura set
                                fecha = '$fecha'
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
     echo json_encode("Colegiatura Actualizada");
   } else {
     echo json_encode("No se ha actualizado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->delete('/api/colegiaturas/delete/{codigoEgresado}',function(Request $request){
  $codigoEgresado = $request->getAttribute('codigoEgresado');
 try {
   $cantidad = $this->db->exec("DELETE FROM colegiatura 
                                WHERE codigoEgresado = $codigoEgresado");
   if ($cantidad > 0) {
     echo json_encode("Colegiatura Eliminada");
   } else {
     echo json_encode("No se ha Eliminado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});