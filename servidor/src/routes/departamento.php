<?php

$app->get('/api/departamentos', function () {
  $data = $this->db->query("SELECT codigo,nombre FROM departamento WHERE vigencia=1")->fetchAll();
  echo json_encode($data);
});