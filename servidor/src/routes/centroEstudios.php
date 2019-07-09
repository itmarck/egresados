<?php
use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/centroEstudios', function () {
 try {
  $data = $this->db->query("SELECT codigo,razonSocial FROM centroestudios WHERE vigencia=1")->fetchAll();
  if ($data) {
      echo json_encode($data);
  }else {
    echo json_encode("No existen centros de estudios en la DB");
  }
 } catch (PDOException $e) {
  echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->get('/api/centroEstudios/{codigo}',function(Request $request){
   $codigo = $request->getAttribute('codigo');
  try {
    $data = $this->db->query("SELECT codigo,razonSocial FROM centroestudios WHERE codigo = $codigo and vigencia=1")->fetchAll();;
    if ($data) {
      echo json_encode($data);
    } else {
      echo json_encode("No existe en la DB");
    }
  } catch (PDOException $e) {
    echo '{"Error": { "mensaje": '. $e->getMessage().'}';
  }
});

$app->post('/api/centroEstudios/add',function(Request $request){
  $razonSocial = $request->getParam('razonSocial');
 try {
   $cantidad = $this->db->exec("INSERT INTO centroestudios(razonSocial,vigencia) 
                            Values('$razonSocial',1)");
   if ($cantidad > 0) {
     echo json_encode("Centro Registrado");
   } else {
     echo json_encode("No se ha agregado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->put('/api/centroEstudios/update/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
  $razonSocial = $request->getParam('razonSocial');
 try {
   $cantidad = $this->db->exec("UPDATE centroestudios set
                                razonSocial ='$razonSocial'
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
     echo json_encode("Centro de estudios Actualizado");
   } else {
     echo json_encode("No se ha actualizado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->delete('/api/centroEstudios/delete/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
 try {
   $cantidad = $this->db->exec("DELETE FROM centroestudios 
                                WHERE codigo = $codigo");
   if ($cantidad > 0) {
     echo json_encode("Centro de estudios Eliminado");
   } else {
     echo json_encode("No se ha actualizado");
   }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});