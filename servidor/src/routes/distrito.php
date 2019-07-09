<?php

$app->get('/api/distritos', function () {
  $data = $this->db->query("SELECT codigo,codigoProvincia,nombre FROM distrito WHERE vigencia=1")->fetchAll();
  echo json_encode($data);
});