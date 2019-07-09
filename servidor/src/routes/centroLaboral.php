<?php
use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/centroLaboral', function () {
 try {
  $data = $this->db->query("SELECT codigoActividad,codigoDistrito,RUC,razonSocial FROM centrolaboral WHERE vigencia=1")->fetchAll();
  if ($data) {
      echo json_encode($data);
  }else {
    echo json_encode("No existen Centros laborales registrados");
  }
 } catch (PDOException $e) {
  echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->get('/api/centroLaboral/{codigo}',function(Request $request){
   $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT codigo,codigoActividad,codigoDistrito,RUC,razonSocial FROM centrolaboral WHERE codigo = $codigo and vigencia=1")->fetchAll();;
    if ($data) {
      echo json_encode($data);
    } else {
      echo json_encode("No existe en la DB");
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->post('/api/centroLaboral/add',function(Request $request){
  $codigoActividad = $request->getParam('codigoActividad');
  $codigoDistrito = $request->getParam('codigoDistrito');
  $RUC = $request->getParam('RUC');
  $razonSocial = $request->getParam('razonSocial');
 try {
   $cantidad = $this->db->exec("INSERT INTO centrolaboral(codigoActividad,codigoDistrito,RUC,razonSocial,vigencia) 
                            Values('$codigoActividad','$codigoDistrito',$RUC,$razonSocial,1)");
   if ($cantidad > 0) {
     echo json_encode("Centro laboral Registrada");
   } else {
     echo json_encode("No se ha agregado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->put('/api/centroLaboral/update/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
  $codigoActividad = $request->getParam('codigoActividad');
  $codigoDistrito = $request->getParam('codigoDistrito');
  $RUC = $request->getParam('RUC');
  $razonSocial = $request->getParam('razonSocial');
 try {
   $cantidad = $this->db->exec("UPDATE centrolaboral set
                                codigoActividad ='$codigoActividad',
                                codigoDistrito = '$codigoDistrito',
                                RUC = '$RUC',
                                razonSocial = '$razonSocial'  
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
     echo json_encode("Centro laboral Actualizado");
   } else {
     echo json_encode("No se ha actualizado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->delete('/api/centroLaboral/delete/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
 try {
   $cantidad = $this->db->exec("DELETE FROM centrolaboral 
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
     echo json_encode("Centro laboral Eliminada");
   } else {
     echo json_encode("No se ha actualizado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});