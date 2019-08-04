<?php

use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/api/estadisticas/departamentos/{top}', function (Request $request) {
    $top = $request->getAttribute('top');

    try {
        $mayores = $this->db->query("SELECT DE.nombre 
                                    FROM distrito D
                                    INNER JOIN centrolaboral CL on Cl.codigoDistrito = D.codigo
                                    INNER JOIN contrato C on C.codigoCentroLaboral = CL.codigo
                                    INNER JOIN provincia P on P.codigo = D.codigoProvincia
                                    INNER JOIN departamento DE on P.codigoDepartamento = DE.codigo
                                    WHERE DATE_SUB(NOW(),INTERVAL 6 YEAR) < C.fechaInicio
                                    GROUP by DE.codigo 
                                    ORDER By COUNT(C.codigo) DESC
                                    LIMIT $top")->fetchAll();

        if ($mayores) {
            $series = array();
            foreach ($mayores as $key => $Dep) {
                $nombre =  $Dep->nombre;

                $datos = $this->db->query("SELECT TIMESTAMPDIFF(YEAR, C.fechaInicio,NOW()) as anio, COUNT( C.codigo ) as egresados
                                                    FROM distrito D
                                                    INNER JOIN centrolaboral CL on Cl.codigoDistrito = D.codigo
                                                    INNER JOIN contrato C on C.codigoCentroLaboral = CL.codigo
                                                    INNER JOIN provincia P on P.codigo = D.codigoProvincia
                                                    INNER JOIN departamento DE on P.codigoDepartamento = DE.codigo
                                                    WHERE DE.nombre = '$nombre' and DATE_SUB(NOW(),INTERVAL 6 YEAR) < C.fechaInicio
                                                    GROUP by DE.codigo ,TIMESTAMPDIFF(YEAR, C.fechaInicio,NOW())")->fetchAll();
                $data = [0, 0, 0, 0, 0, 0];
                foreach ($datos as $key => $Dato) {
                    $data[$Dato->anio] = intval($Dato->egresados);
                }
                array_push($series, array('name' => $nombre, 'data' => array_reverse($data)));
            }
            $result = array('estado' => true, 'data' => $series);
            echo json_encode($result);
        } else {
            echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
        }
    } catch (PDOException $e) {
        echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
    }
});

$app->get('/api/estadisticas/total', function (Request $request) {

    try {
        $egresados = $this->db->query("SELECT COUNT(codigo) as E
                                    FROM persona")->fetchAll();
        $universidades = $this->db->query("SELECT COUNT(codigo) as U
                                    FROM universidad")->fetchAll();
        $centros = $this->db->query("SELECT COUNT(codigo) as C
        
                                    FROM centroEstudios")->fetchAll();
        $data = [];
        array_push($data, array('texto' => 'Usuarios registrados', 'valor' => $universidades[0]->U), array('texto' => 'Universidades registradas', 'valor' => $egresados[0]->E), array('texto' => 'Centros de estudios registrados', 'valor' => $centros[0]->C));
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

$app->get('/api/estadisticas/universidades', function (Request $request) {

    try {
        $data = $this->db->query("SELECT U.siglas, COUNT( DISTINCT P.codigo ) as cantidad
                                    FROM universidad U
                                    INNER JOIN escuelaprofesional EP on EP.codigoUniversidad = U.codigo
                                    INNER JOIN egresado E on E.codigoEscuela = EP.codigo
                                    INNER JOIN persona P on P.codigo = E.codigoPersona 
                                    GROUP by U.codigo
                                    ORDER BY cantidad DESC")->fetchAll();
        $total = $this->db->query("SELECT COUNT(codigo) as total from persona")->fetchAll();

        if ($data) {
            $porcentajes = [];
            $categorias = [];
            $sw = 1;
            $aux = 0;
            foreach ($data as $key => $cat) {
                if ($sw <= 5) {
                    $p = ($cat->cantidad / $total[0]->total) * 100;
                    array_push($porcentajes, $p);
                    array_push($categorias, $cat->siglas);
                    $sw++;
                } else {
                    $aux = $aux + $cat->cantidad;
                }
            }
            $aux = ($aux / $total[0]->total) * 100;
            array_push($porcentajes, $aux);
            array_push($categorias, 'Otros');

            $result = array('estado' => true, 'data' => array('data' => $porcentajes, 'categories' => $categorias));
            echo json_encode($result);
        } else {
            echo json_encode(array('estado' => false, 'mensaje' => 'No se han encontrado datos', 'data' => []));
        }
    } catch (PDOException $e) {
        echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos'));
    }
});

$app->get('/api/estadisticas/general', function (Request $request) {
    try {
        $mayores = $this->db->query("SELECT U.nombre
                                    FROM universidad U
                                    INNER JOIN escuelaprofesional EP on EP.codigoUniversidad = U.codigo
                                    INNER JOIN egresado E on E.codigoEscuela = EP.codigo
                                    WHERE YEAR(E.fechaTermino) = YEAR(CURRENT_DATE())
                                    GROUP BY U.codigo
                                    ORDER by COUNT( E.codigo ) DESC
                                    LIMIT 5")->fetchAll();

        if ($mayores) {
            $series = array();
            foreach ($mayores as $key => $UNI) {
                $nombre =  $UNI->nombre;

                $datos = $this->db->query("SELECT  MONTH(E.fechaTermino) as mes, COUNT( E.codigo ) as cantidad
                                    FROM universidad U
                                    INNER JOIN escuelaprofesional EP on EP.codigoUniversidad = U.codigo
                                    INNER JOIN egresado E on E.codigoEscuela = EP.codigo
                                    WHERE YEAR(E.fechaTermino) = YEAR(CURRENT_DATE()) and U.nombre = '$nombre'
                                    GROUP BY U.codigo,mes
                                    ORDER BY mes")->fetchAll();
                $data = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                foreach ($datos as $key => $Uni) {
                    $data[$Uni->mes - 1] = intval($Uni->cantidad);
                }
                array_push($series, array('name' => $nombre, 'data' => $data));
            }
            $result = array('estado' => true, 'data' => $series);
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
        $data = $this->db->query("SELECT  A.nombre ,COUNT(c.codigo) as cantidad
                                    from centrolaboral CL
                                    INNER JOIN contrato C on C.codigoCentroLaboral = CL.codigo
                                    INNER JOIN actividadeconomica A on A.codigo = CL.codigoActividad
                                    GROUP by A.codigo
                                    ORDER BY cantidad DESC")->fetchAll();

        if ($data) {
            $cantidades = [];
            $categorias = [];
            $sw = 1;
            $aux = 0;
            foreach ($data as $key => $cat) {
                if ($sw <= $top) {
                    $p = intval($cat->cantidad);
                    array_push($cantidades, $p);
                    array_push($categorias, $cat->nombre);
                    $sw++;
                } else {
                    $aux = $aux + $cat->cantidad;
                }
            }

            array_push($cantidades, $aux);
            array_push($categorias, 'Otros');

            $result = array('estado' => true, 'data' => array('data' => $cantidades, 'categories' => $categorias));
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
