<?php
use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/admisiones', function () {
 try {
  $data = $this->db->query("SELECT A.codigo,codigoEscuela,fechaAdmision,A.nombre as ciclo,codigoModalidad, M.nombre as modalidad 
                            FROM admision A
                            INNER JOIN modalidadAdmision M on A.codigoModalidad = M.codigo  
                            WHERE A.vigencia=1
                            ORDER BY fechaAdmision")->fetchAll();
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

$app->get('/api/admisiones/{codigo}',function(Request $request){
   $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT A.codigo,codigoEscuela,fechaAdmision,A.nombre as ciclo,codigoModalidad, M.nombre as modalidad 
                              FROM admision A
                              INNER JOIN modalidadAdmision M on A.codigoModalidad = M.codigo 
                              WHERE A.codigo = $codigo and A.vigencia=1")->fetchAll();
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

$app->post('/api/admisiones/add',function(Request $request){
  $nombre = $request->getParam('nombre');
  $codigoEscuela = $request->getParam('codigoEscuela');
  $fechaAdmision = $request->getParam('fechaAdmision');
  $codigoModalidad = $request->getParam('codigoModalidad');
 try {
   $cantidad = $this->db->exec("INSERT INTO admision(codigoEscuela,fechaAdmision,nombre,codigoModalidad,vigencia) 
                            Values('$codigoEscuela','$fechaAdmision',$nombre,$codigoModalidad,1)");
   if ($cantidad > 0) {
    echo json_encode(array('estado' => true));
  } else {
    echo json_encode(array('estado' => false));
  }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->put('/api/admisiones/{codigo}',function(Request $request){
    $codigo = $request->getAttribute('codigo');  
    $nombre = $request->getParam('nombre');
    $codigoEscuela = $request->getParam('codigoEscuela');
    $fechaAdmision = $request->getParam('fechaAdmision');
    $codigoModalidad = $request->getParam('codigoModalidad');
 try {
   $cantidad = $this->db->exec("UPDATE admision set
                                nombre ='$nombre',
                                codigoEscuela = '$codigoEscuela',
                                fechaAdmision = '$fechaAdmision',
                                codigoModalidad = '$codigoModalidad'
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

$app->delete('/api/admisiones/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
 try {
   $cantidad = $this->db->exec("DELETE FROM admision 
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