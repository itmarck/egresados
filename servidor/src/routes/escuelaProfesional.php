<?php
use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/escuelasProfesionales', function () {
 try {
  $data = $this->db->query("SELECT codigo,codigoFacultad,nombre,siglas,estado,codigoUniversidad FROM escuelaprofesional WHERE vigencia=1")->fetchAll();
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
$app->get('/api/escuelasProfesionales/uni/{codigoUniversidad}', function (Request $request) {
  $codigo = $request->getAttribute('codigoUniversidad');
  try {
   $data = $this->db->query("SELECT nombre FROM escuelaprofesional WHERE codigoUniversidad = $codigo and vigencia=1")->fetchAll();
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

$app->get('/api/escuelasProfesionales/{codigo}',function(Request $request){
   $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT nombre FROM escuelaprofesional WHERE codigo = $codigo and vigencia=1")->fetchAll();;
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

$app->post('/api/escuelasProfesionales/add',function(Request $request){
  $nombre = $request->getParam('nombre');
  $siglas = $request->getParam('siglas');
  $codigoFacultad = $request->getParam('codigoFacultad');
  $codigoUniversidad = $request->getParam('codigoUniversidad');
  $estado = $request->getParam('estado');
 try {
  if ($codigoFacultad) {
    $cantidad = $this->db->exec("INSERT INTO escuelaprofesional(nombre,siglas,estado,codigoFacultad,codigoUniversidad,vigencia) 
                            Values('$nombre','$siglas',$estado,$codigoFacultad,$codigoUniversidad,1)");
  } else {
    $cantidad = $this->db->exec("INSERT INTO escuelaprofesional(nombre,siglas,estado,codigoUniversidad,vigencia) 
                            Values('$nombre','$siglas',$estado,$codigoUniversidad,1)");
  }
   if ($cantidad > 0) {
     echo json_encode(array('estado' => true));
   } else {
     echo json_encode(array('estado' => false));
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->put('/api/escuelasProfesionales/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  $siglas = $request->getParam('siglas');
  $codigoFacultad = $request->getParam('codigoFacultad');
  $codigoUniversidad = $request->getParam('codigoUniversidad');
  $estado = $request->getParam('estado');
 try {
   if ($codigoFacultad) {
    $cantidad = $this->db->exec("UPDATE escuelaprofesional set
                                nombre ='$nombre',
                                siglas = '$siglas',
                                estado = '$estado',
                                codigoUniversidad = '$codigoUniversidad',
                                codigoFacultad = '$codigoFacultad'  
                                WHERE codigo = $codigo");
   } else {
    $cantidad = $this->db->exec("UPDATE escuelaprofesional set
                                nombre ='$nombre',
                                siglas = '$siglas',
                                estado = '$estado',
                                codigoUniversidad = '$codigoUniversidad'
                                WHERE codigo = $codigo");
   }
   
  
   if ($cantidad > 0) {
    echo json_encode(array('estado' => true));
  } else {
    echo json_encode(array('estado' => false));
  }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->delete('/api/escuelasProfesionales/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
 try {
   $cantidad = $this->db->exec("DELETE FROM escuelaprofesional 
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