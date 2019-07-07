<?php

$app->get('/api/provincias', function () {
  $data = $this->db->query("SELECT * FROM provincia")->fetchAll();
  echo json_encode($data);
});