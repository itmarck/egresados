<?php

$app->get('/api/modalidadesTitulacion', function () {
  $data = $this->db->query("SELECT codigo,nombre,descripcion FROM modalidadtitulacion WHERE vigencia=1")->fetchAll();
  echo json_encode($data);
});