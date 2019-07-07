<?php

$app->get('/api/tiposPostgrado', function () {
  $data = $this->db->query("SELECT * FROM tipoestudiopostgrado")->fetchAll();
  echo json_encode($data);
});