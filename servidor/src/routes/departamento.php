<?php

$app->get('/api/departamentos', function () {
  $data = $this->db->query("SELECT * FROM departamento")->fetchAll();
  echo json_encode($data);
});