<?php

$app->get('/api/distritos', function () {
  $data = $this->db->query("SELECT * FROM distrito")->fetchAll();
  echo json_encode($data);
});