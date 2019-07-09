<?php
use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/estudiosPostgrado', function () {
 try {
  $data = $this->db->query("SELECT codigo,codigoEgresado,codigoTipo,codigoUniversidad,codigoCentroEstudios,nombre,fechaInicio,fechaTermino FROM estudiospostgrado WHERE vigencia=1")->fetchAll();
  if ($data) {
      echo json_encode($data);
  }else {
    echo json_encode("No existen Estudios Postgrado registrados");
  }
 } catch (PDOException $e) {
  echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->get('/api/estudiosPostgrado/{codigo}',function(Request $request){
   $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT codigo,codigoEgresado,codigoTipo,codigoUniversidad,codigoCentroEstudios,nombre,fechaInicio,fechaTermino FROM estudiospostgrado WHERE codigo = $codigo and vigencia=1")->fetchAll();;
    if ($data) {
      echo json_encode($data);
    } else {
      echo json_encode("No existe en la DB");
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->post('/api/estudiosPostgrado/add',function(Request $request){
  $codigoEgresado = $request->getParam('codigoEgresado');
  $codigoTipo = $request->getParam('codigoTipo');
  $codigoCentroEstudios = $request->getParam('codigoCentroEstudios');
  $codigoUniversidad = $request->getParam('codigoUniversidad');
  $nombre = $request->getParam('nombre');
  $fechaInicio = $request->getParam('fechaInicio');
  $fechaTermino = $request->getParam('fechaTermino');
 try {
   $cantidad = $this->db->exec("INSERT INTO estudiospostgrado(codigoEgresado,codigoTipo,nombre,codigoCentroEstudios,codigoUniversidad,fechaInicio,fechaTermino,vigencia) 
                            Values('$codigoEgresado','$codigoTipo',$nombre,$codigoCentroEstudios,$codigoUniversidad,$fechaInicio,$fechaTermino,1)");
   if ($cantidad > 0) {
     echo json_encode("Escuela Registrada");
   } else {
     echo json_encode("No se ha agregado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->put('/api/estudiosPostgrado/update/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
  $codigoEgresado = $request->getParam('codigoEgresado');
  $codigoTipo = $request->getParam('codigoTipo');
  $codigoCentroEstudios = $request->getParam('codigoCentroEstudios');
  $codigoUniversidad = $request->getParam('codigoUniversidad');
  $nombre = $request->getParam('nombre');
  $fechaInicio = $request->getParam('fechaInicio');
  $fechaTermino = $request->getParam('fechaTermino');
 try {
   $cantidad = $this->db->exec("UPDATE estudiospostgrado set
                                codigoEgresado ='$codigoEgresado',
                                codigoTipo = '$codigoTipo',
                                nombre = '$nombre',
                                codigoUniversidad = '$codigoUniversidad',
                                codigoCentroEstudios = '$codigoCentroEstudios',
                                fechaInicio = '$fechaInicio',
                                fechaTermino = '$fechaTermino'  
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
     echo json_encode("Escuela Actualizada");
   } else {
     echo json_encode("No se ha actualizado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->delete('/api/estudiosPostgrado/delete/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
 try {
   $cantidad = $this->db->exec("DELETE FROM estudiospostgrado 
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
     echo json_encode("Escuela Eliminada");
   } else {
     echo json_encode("No se ha actualizado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});