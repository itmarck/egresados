<?php

$app->get('/api/actividadEconomica', function () {
  $data = $this->db->query("SELECT * FROM actividadeconomica")->fetchAll();
  echo json_encode($data);
});