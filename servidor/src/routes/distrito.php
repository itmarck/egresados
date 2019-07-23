<?php

use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/api/distritos/{provincia}', function (Request $request) {
  $provincia =  $request->getAttribute('provincia');
  $data = $this->db->query("SELECT codigo,codigoProvincia,nombre from distrito WHERE vigencia=1 and codigoProvincia = $provincia")->fetchAll();
  if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
  } else {
    echo json_encode(array('estado' => false));
  }
});
