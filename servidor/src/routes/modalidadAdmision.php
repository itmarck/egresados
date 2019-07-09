<?php

$app->get('/api/modalidadesAdmision', function () {
  $data = $this->db->query("SELECT codigo,nombre,descripcion FROM modalidadadmision WHERE vigencia=1")->fetchAll();
  echo json_encode($data);
});