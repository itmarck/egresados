<?php

use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/api/estadisticas/departamentos/{top}', function (Request $request) {
    $top = $request->getAttribute('top');

    try {
        $data = $this->db->query("SELECT DE.nombre, COUNT( C.codigo ) as egresados
                                    FROM distrito D
                                    INNER JOIN centrolaboral CL on Cl.codigoDistrito = D.codigo
                                    INNER JOIN contrato C on C.codigoCentroLaboral = CL.codigo
                                    INNER JOIN provincia P on P.codigo = D.codigoProvincia
                                    INNER JOIN departamento DE on P.codigoDepartamento = DE.codigo
                                    GROUP by DE.codigo
                                    ORDER BY egresados DESC
                                    LIMIT $top")->fetchAll();
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

$app->get('/api/estadisticas/actividades/{top}', function (Request $request) {
    $top = $request->getAttribute('top');
    try {
        $data = $this->db->query("SELECT A.nombre, COUNT(C.codigo) as contratos 
                                FROM actividadeconomica A
                                INNER JOIN centrolaboral CL on Cl.codigoDistrito = A.codigo
                                INNER JOIN contrato C on C.codigoCentroLaboral = CL.codigo
                                INNER JOIN egresado E on E.codigo = C.codigoEgresado
                                GROUP by A.codigo
                                ORDER BY contratos DESC
                                LIMIT $top")->fetchAll();
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

$app->get('/api/estadisticas/centros/{top}', function (Request $request) {
    $top = $request->getAttribute('top');
    try {
        $data = $this->db->query("SELECT CE.razonSocial, COUNT(EP.codigo) as egresados
                                FROM centroestudios CE
                                INNER JOIN estudiospostgrado EP on EP.codigoCentroEstudios = CE.codigo
                                GROUP by CE.codigo
                                ORDER BY egresados DESC
                                LIMIT $top")->fetchAll();
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

$app->get('/api/estadisticas/carreras/{carrera}', function (Request $request) {
    $carrera = $request->getAttribute('carrera');
    try {
        $data = $this->db->query("SELECT CE.razonSocial, COUNT(EP.codigo) as egresados
                                FROM centroestudios CE
                                INNER JOIN estudiospostgrado EP on EP.codigoCentroEstudios = CE.codigo
                                GROUP by CE.codigo
                                ORDER BY egresados DESC
                                LIMIT $top")->fetchAll();
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
