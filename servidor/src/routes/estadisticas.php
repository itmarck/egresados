<?php

use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/api/estadisticas/distritos', function () {
    try {
        $data = $this->db->query("SELECT D.nombre, COUNT(E.codigoPersona) as egresados
                                    FROM distrito D
                                    INNER JOIN centrolaboral CL on Cl.codigoDistrito = D.codigo
                                    INNER JOIN contrato C on C.codigoCentroLaboral = CL.codigo
                                    INNER JOIN egresado E on E.codigo = C.codigoEgresado
                                    GROUP by D.codigo
                                    ORDER BY egresados DESC
                                    LIMIT 10")->fetchAll();
        if ($data) {
            $result = array('estado' => true, 'data' => $data);
            echo json_encode($result);
        } else {
            echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
        }
    } catch (PDOException $e) {
        echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
    }
});

$app->get('/api/estadisticas/actividades', function () {
    try {
        $data = $this->db->query("SELECT A.nombre, COUNT(C.codigo) as contratos 
                                FROM actividadeconomica A
                                INNER JOIN centrolaboral CL on Cl.codigoDistrito = A.codigo
                                INNER JOIN contrato C on C.codigoCentroLaboral = CL.codigo
                                INNER JOIN egresado E on E.codigo = C.codigoEgresado
                                GROUP by A.codigo
                                ORDER BY contratos DESC
                                LIMIT 10")->fetchAll();
        if ($data) {
            $result = array('estado' => true, 'data' => $data);
            echo json_encode($result);
        } else {
            echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
        }
    } catch (PDOException $e) {
        echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
    }
});

$app->get('/api/estadisticas/centros', function () {
    try {
        $data = $this->db->query("SELECT CE.razonSocial, COUNT(EP.codigo) as egresados
                                FROM centroestudios CE
                                INNER JOIN estudiospostgrado EP on EP.codigoCentroEstudios = CE.codigo
                                GROUP by CE.codigo
                                ORDER BY egresados DESC
                                LIMIT 10")->fetchAll();
        if ($data) {
            $result = array('estado' => true, 'data' => $data);
            echo json_encode($result);
        } else {
            echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
        }
    } catch (PDOException $e) {
        echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
    }
});
