<?php

$app->get('/api/distritos', function () {
  $data = $this->db->query("SELECT codigo,codigoProvincia,nombre FROM distrito WHERE vigencia=1")->fetchAll();
  if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
 }else {
   echo json_encode( array('estado' => false ));
 }
});