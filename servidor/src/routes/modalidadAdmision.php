<?php

$app->get('/api/modalidadesAdmision', function () {
  $data = $this->db->query("SELECT * FROM modalidadadmision")->fetchAll();
  echo json_encode($data);
});