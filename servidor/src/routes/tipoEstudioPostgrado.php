<?php
$app->get('/api/tiposPostgrado', function () {
  $data = $this->db->query("SELECT codigo,nombre,descripcion FROM tipoestudiopostgrado WHERE vigencia=1")->fetchAll();
  echo json_encode($data);
});