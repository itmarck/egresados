<?php

$app->get('/api/facultades', function () {
  $data = $this->db->query("SELECT * FROM facultad")->fetchAll();
  echo json_encode($data);
});
