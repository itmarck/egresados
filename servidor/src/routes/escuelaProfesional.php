<?php
use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/escuelasProfesionales', function () {
 try {
  $data = $this->db->query("SELECT codigo,codigoFacultad,nombre,siglas,estado,codigoUniversidad FROM escuelaprofesional WHERE vigencia=1")->fetchAll();
  if ($data) {
      echo json_encode($data);
  }else {
    echo json_encode("No existen Escuelas en la DB");
  }
 } catch (PDOException $e) {
  echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});
$app->get('/api/escuelasProfesionales/facultad/{codigofacultad}', function () {
  $codigoFacultad = $request->getAttribute('codigoFacultad');
  try {
   $data = $this->db->query("SELECT codigo,codigoFacultad,nombre,siglas,estado,codigoUniversidad FROM escuelaprofesional WHERE vigencia=1 and codigoFacultad = $codigoFacultad")->fetchAll();
   if ($data) {
       echo json_encode($data);
   }else {
     echo json_encode("No existen Escuelas en la DB");
   }
  } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
   }
 });

$app->get('/api/escuelasProfesionales/{codigo}',function(Request $request){
   $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT codigo,codigoFacultad,nombre,siglas,estado,codigoUniversidad FROM escuelaprofesional WHERE codigo = $codigo and vigencia=1")->fetchAll();;
    if ($data) {
      echo json_encode($data);
    } else {
      echo json_encode("No existe en la DB");
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
   $cantidad = $this->db->exec("INSERT INTO escuelaprofesional(nombre,siglas,estado,codigoFacultad,codigoUniversidad,vigencia) 
                            Values('$nombre','$siglas',$estado,$codigoFacultad,$codigoUniversidad,1)");
   if ($cantidad > 0) {
     echo json_encode("Escuela Registrada");
   } else {
     echo json_encode("No se ha agregado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->put('/api/escuelasProfesionales/update/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  $siglas = $request->getParam('siglas');
  $codigoFacultad = $request->getParam('codigoFacultad');
  $codigoUniversidad = $request->getParam('codigoUniversidad');
  $estado = $request->getParam('estado');
 try {
   $cantidad = $this->db->exec("UPDATE escuelaprofesional set
                                nombre ='$nombre',
                                siglas = '$siglas',
                                estado = '$estado',
                                codigoUniversidad = '$codigoUniversidad',
                                codigoFacultad = '$codigoFacultad'  
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

$app->delete('/api/escuelasProfesionales/delete/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
 try {
   $cantidad = $this->db->exec("DELETE FROM escuelaprofesional 
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