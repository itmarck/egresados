<?php
use Psr\Http\Message\ServerRequestInterface as Request;


$app->get('/api/estudiosPostgrado', function () {
 try {
  $data = $this->db->query("SELECT codigo,codigoEgresado,codigoTipo,codigoUniversidad,codigoCentroEstudios,nombre,fechaInicio,fechaTermino,anioCertificacion 
            FROM estudiospostgrado WHERE vigencia=1")->fetchAll();
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

$app->get('/api/estudiosPostgrado/{codigo}',function(Request $request){
   $codigo = $request->getAttribute('codigo');
   
   try {
    $uni = $this->db->query("SELECT codigoUniversidad FROM estudiospostgrado Es
                            INNER JOIN egresado E on E.codigo = Es.codigoEgresado
                            INNER JOIN persona P on P.codigo = E.codigoPersona
                            WHERE P.dni = $codigo and P.vigencia = 1")->fetchAll();
      if($uni[0]->codigoUniversidad) {
        $sql = "SELECT Es.codigo,Es.codigoEgresado,Es.codigoTipo,T.nombre as tipo,Es.codigoUniversidad,U.nombre as universidad,Es.nombre, Es.fechaInicio,Es.fechaTermino,anioCertificacion 
        FROM estudiospostgrado Es
        INNER JOIN universidad U on U.codigo = Es.codigoUniversidad ";
       $lugar = "U";
      }else{
        $sql = "SELECT Es.codigo,Es.codigoEgresado,Es.codigoTipo,T.nombre as tipo,Es.codigoCentroEstudios,C.razonSocial,Es.nombre, Es.fechaInicio,Es.fechaTermino,anioCertificacion 
        FROM estudiospostgrado Es
        INNER JOIN centroEstudios C on C.codigo= Es.codigoCentroEstudios  ";
       $lugar = "C";
      }
      $sql = $sql . " INNER JOIN egresado E on E.codigo = Es.codigoEgresado
                     INNER JOIN persona P on P.codigo = E.codigoPersona
                     INNER JOIN tipoestudiopostgrado T on T.codigo = Es.codigoTipo 
                     WHERE P.dni = $codigo and P.vigencia = 1";
    $data = $this->db->query($sql)->fetchAll();;
  if ($data) {
     foreach ($data as $key => $value) {
       $value->lugar = $lugar;
     }
      $result = array('estado' => true, 'data' => $data);
      echo json_encode($result);
   }else {
     echo json_encode( array('estado' => false ));
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
  $anioCertificacion = $request->getParam('anioCertificacion');
 try {
   if ($codigoCentroEstudios) {
    $cantidad = $this->db->exec("INSERT INTO estudiospostgrado(codigoEgresado,codigoTipo,nombre,codigoCentroEstudios,fechaInicio,fechaTermino,anioCertificacion,vigencia) 
                                  Values('$codigoEgresado','$codigoTipo',$nombre,$codigoCentroEstudios,$fechaInicio,$fechaTermino,1)");
   } else { 
     $cantidad = $this->db->exec("INSERT INTO estudiospostgrado(codigoEgresado,codigoTipo,nombre,codigoUniversidad,fechaInicio,fechaTermino,anioCertificacion,vigencia) 
                                  Values('$codigoEgresado','$codigoTipo',$nombre,$codigoUniversidad,$fechaInicio,$fechaTermino,$anioCertificacion,1)");
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

$app->put('/api/estudiosPostgrado/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
  $codigoEgresado = $request->getParam('codigoEgresado');
  $codigoTipo = $request->getParam('codigoTipo');
  $codigoCentroEstudios = $request->getParam('codigoCentroEstudios');
  $codigoUniversidad = $request->getParam('codigoUniversidad');
  $nombre = $request->getParam('nombre');
  $fechaInicio = $request->getParam('fechaInicio');
  $fechaTermino = $request->getParam('fechaTermino');
  $anioCertificacion = $request->getParam('anioCertificacion');
 try {
   $sql = "UPDATE estudiospostgrado set
            codigoEgresado ='$codigoEgresado',
            codigoTipo = '$codigoTipo',
            nombre = '$nombre',
            fechaInicio = '$fechaInicio',
            fechaTermino = '$fechaTermino',
            anioCertificacion = $anioCertificacion ";
   if ($codigoCentroEstudios) {
    $sql = $sql .  "codigoCentroEstudios = '$codigoCentroEstudios' ";
   } else {
    $sql = $sql . " codigoUniversidad = '$codigoUniversidad' ";
   }
   $sql = $sql . "WHERE codigo = $codigo";
   $cantidad = $this->db->exec($sql);
  if ($cantidad > 0) {
    echo json_encode(array('estado' => true));
  } else {
    echo json_encode(array('estado' => false));
  }
 } catch (PDOException $e) {
   echo '{"Error": { "mensaje": '. $e->getMessage().'}';
 }
});

$app->delete('/api/estudiosPostgrado/{codigo}',function(Request $request){
  $codigo = $request->getAttribute('codigo');
 try {
   $cantidad = $this->db->exec("DELETE FROM estudiospostgrado 
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