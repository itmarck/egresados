<?php

$app->get('/api/provincias', function () {
  $data = $this->db->query("SELECT codigo,codigoDepartamento,nombre FROM provincia WHERE vigencia=1")->fetchAll();
  echo json_encode($data);
});