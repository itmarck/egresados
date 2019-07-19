<?php

$app->get('/api/provincias', function () {
  $data = $this->db->query("SELECT codigo,codigoDepartamento,nombre FROM provincia WHERE vigencia=1")->fetchAll();
  if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
  } else {
    echo json_encode(array('estado' => false));
  }
});
