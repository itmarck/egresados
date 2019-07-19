<?php

use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/api/modalidadesAdmision', function () {
  $data = $this->db->query("SELECT codigo,nombre,descripcion FROM modalidadadmision WHERE vigencia=1")->fetchAll();
  if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
  } else {
    echo json_encode(array('estado' => false));
  }
});

$app->put('/api/modalidadesAdmision/{codigo}', function (Request $request) {
  $codigo = $request->getAttribute('codigo');
  $nombre = $request->getParam('nombre');
  $nombre = $request->getParam('descripcion');
});
