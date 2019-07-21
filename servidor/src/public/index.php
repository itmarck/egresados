<?php
use Slim\Container;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, PATCH");

require '../../vendor/autoload.php';

$config['displayErrorDetails'] = true;
$config['addContentLengthHeader'] = false;

$config['db']['host']   = 'localhost';
$config['db']['user']   = 'root';
$config['db']['pass']   = '';
$config['db']['dbname'] = 'egresados';

$app = new \Slim\App(['settings' => $config]);

$container = $app->getContainer();

$container['db'] = function ($c) {
    $db = $c['settings']['db'];
    $pdo = new PDO('mysql:host=' . $db['host'] . ';dbname=' . $db['dbname'],
        $db['user'], $db['pass']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_OBJ);
    return $pdo;
};

require '../routes/facultad.php';
require '../routes/departamento.php';
require '../routes/actividadEconomica.php';
require '../routes/admision.php';
require '../routes/centroEstudios.php';
require '../routes/centroLaboral.php';
require '../routes/colegiatura.php';
require '../routes/contrato.php';
require '../routes/distrito.php';
require '../routes/egresado.php';
require '../routes/escuelaProfesional.php';
require '../routes/estudiosPostgrado.php';
require '../routes/modalidadAdmision.php';
require '../routes/modalidadTitulacion.php';
require '../routes/persona.php';
require '../routes/personal.php';
require '../routes/provincia.php';
require '../routes/titulacion.php';
require '../routes/universidad.php';
require '../routes/usuario.php';
require '../routes/tipoEstudioPostgrado.php';

$app->run();
