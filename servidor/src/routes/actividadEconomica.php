<?php

$app->get('/api/actividadEconomica', function () {
  $data = $this->db->query("SELECT codigo,nombre,descripcion FROM actividadeconomica WHERE vigencia=1")->fetchAll();
  echo json_encode($data);
});