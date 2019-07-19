<?php

$app->get('/api/departamentos', function () {
  $data = $this->db->query("SELECT codigo,nombre FROM departamento WHERE vigencia=1")->fetchAll();
  if ($data) {
    $result = array('estado' => true, 'data' => $data);
    echo json_encode($result);
  } else {
    echo json_encode(array('estado' => false));
  }
});
