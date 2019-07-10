<?php
use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/egresados', function () {
 try {
  $data = $this->db->query("SELECT codigo,codigoEscuela,codigoPersona,codigoAdmision,fechaInicio,fechaTermino FROM egresado WHERE vigencia=1")->fetchAll();
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

$app->get('/api/egresados/{codigo}',function(Request $request){
   $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT codigo,codigoEscuela,codigoPersona,codigoAdmision,fechaInicio,fechaTermino FROM egresado WHERE codigo = $codigo and vigencia=1")->fetchAll();;
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

$app->post('/api/egresados/add',function(Request $request){
  $codigoEscuela = $request->getParam('codigoEscuela');
  $codigoPersona = $request->getParam('codigoPersona');
  $codigoAdmision = $request->getParam('codigoAdmision');
  $fechaInicio = $request->getParam('fechaInicio');
  $fechaTermino = $request->getParam('fechaTermino');
 try {
   $cantidad = $this->db->exec("INSERT INTO egresado(codigoEscuela,codigoPersona,codigoAdmision,fechaInicio,fechaTermino,vigencia) 
                            Values('$codigoEscuela','$codigoPersona',$codigoAdmision,$fechaInicio,$fechaTermino,1)");
   if ($cantidad > 0) {
    echo json_encode(array('estado' => true));
  } else {
    echo json_encode(array('estado' => false));
  }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->put('/api/egresados/update/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
  $codigoEscuela = $request->getParam('codigoEscuela');
  $codigoPersona = $request->getParam('codigoPersona');
  $codigoAdmision = $request->getParam('codigoAdmision');
  $fechaInicio = $request->getParam('fechaInicio');
  $fechaTermino = $request->getParam('fechaTermino');
 try {
   $cantidad = $this->db->exec("UPDATE egresado set
                                codigoEscuela ='$codigoEscuela',
                                codigoPersona = '$codigoPersona',
                                codigoAdmision = '$codigoAdmision',
                                fechaInicio = '$fechaInicio',
                                fechaTermino = '$fechaTermino'  
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

$app->delete('/api/egresados/delete/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
 try {
   $cantidad = $this->db->exec("DELETE FROM egresado 
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