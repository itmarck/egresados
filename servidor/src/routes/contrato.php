<?php
use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/contratos', function () {
 try {
  $data = $this->db->query("SELECT codigo,codigoEgresado,codigoCentroLaboral,cargo,fechaInicio,fechaTermino, detalleFunciones FROM contrato WHERE vigencia=1")->fetchAll();
  if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
 }else {
   echo json_encode( array('estado' => false ));
 }
 } catch (PDOException $e) {
  echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->get('/api/contratos/{codigo}',function(Request $request){
   $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT codigo,codigoEgresado,codigoCentroLaboral,cargo,fechaInicio,fechaTermino, detalleFunciones FROM contrato WHERE codigo = $codigo and vigencia=1")->fetchAll();;
    if ($data) {
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
   }else {
     echo json_encode( array('estado' => false ));
   }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->post('/api/contratos/add',function(Request $request){
  $codigoEgresado = $request->getParam('codigoEgresado');
  $codigoCentroLaboral = $request->getParam('codigoCentroLaboral');
  $cargo = $request->getParam('cargo');
  $fechaInicio = $request->getParam('fechaInicio');
  $fechaTermino = $request->getParam('fechaTermino');  
  $detalleFunciones = $request->getParam('detalleFunciones');  
 try {
   $cantidad = $this->db->exec("INSERT INTO contrato(codigoEgresado,codigoCentroLaboral,fechaInicio,cargo,fechaTermino,detalleFunciones,vigencia) 
                            Values('$codigoEgresado','$codigoCentroLaboral',$fechaInicio,'$cargo',$fechaTermino,'$detalleFunciones',1)");
   if ($cantidad > 0) {
    echo json_encode(array('estado' => true));
  } else {
    echo json_encode(array('estado' => false));
  }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->put('/api/contratos/update/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
  $codigoEgresado = $request->getParam('codigoEgresado');
  $codigoCentroLaboral = $request->getParam('codigoCentroLaboral');
  $fechaInicio = $request->getParam('fechaInicio');
  $cargo = $request->getParam('cargo');
  $fechaTermino = $request->getParam('fechaTermino');  
  $detalleFunciones = $request->getParam('detalleFunciones');  
 try {
   $cantidad = $this->db->exec("UPDATE contrato set
                                codigoEgresado ='$codigoEgresado',
                                codigoCentroLaboral = '$codigoCentroLaboral',
                                fechaInicio = '$fechaInicio',
                                cargo = '$cargo',
                                fechaTermino = '$fechaTermino',
                                detalleFunciones = '$detalleFunciones'
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
    echo json_encode(array('estado' => true));
  } else {
    echo json_encode(array('estado' => false));
  }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->delete('/api/contratos/delete/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
 try {
   $cantidad = $this->db->exec("DELETE FROM contrato 
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
    echo json_encode(array('estado' => true));
  } else {
    echo json_encode(array('estado' => false));
  }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});