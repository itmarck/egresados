<?php

$app->get('/api/modalidadesTitulacion', function () {
  $data = $this->db->query("SELECT * FROM modalidadtitulacion")->fetchAll();
  echo json_encode($data);
});