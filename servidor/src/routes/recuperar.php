<?php

use Psr\Http\Message\ServerRequestInterface as Request;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '../PHPMailer/Exception.php';
require '../PHPMailer/PHPMailer.php';
require '../PHPMailer/SMTP.php';

$app->post('/api/recuperar', function (Request $request) {
    $correo = $request->getParam('correo');
    try {
        $hash = $this->db->query("SELECT clave from usuario where correo = $correo")->fetchAll();
        $clave = str_replace('/', '', $hash);
        $url = "http://unprg.xyz/recuperar/$clave";
        require '../PHPMailer/Plantillas.php';
        $mail = new PHPMailer(true);
        $mail->SMTPDebug = 0;
        $mail->isSMTP();
        $mail->Host       = 'smtp.gmail.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = 'egresados.unprg@gmail.com';
        $mail->Password   = 'EGRESADOS2019';
        $mail->SMTPSecure = 'tls';
        $mail->Port       = 587;
        $mail->setFrom('egresados.unprg@gmail.com', 'Egresados Unprg');
        $mail->addAddress("$correo");
        $mail->isHTML(true);
        $mail->Subject = 'Confirmar recuperacion de contraseña';
        $mail->Body    = "Ingresa aqui para recuperar tu contraseña $url";
        $mail->AltBody = "Ingresa aqui para recuperar tu contraseña $url";
        $mail->send();
    } catch (PDOException $e) {
        echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ', $e->getMessage()));
    }
});

// nombres nombredeusuario tipo 
$app->get('/api/recuperar/{hash}', function (Request $request) {
    $url = $request->getAttribute('hash');
    $codigo = $request->getParam('codigo');
    try {
        $usuario = $this->db->query("SELECT clave,tipo from usuario where codigo = $codigo")->fetchAll();
        if (verifyHass($usuario[0]->clave, $url)) {
            if ($usuario[0]->tipo == "E") {
                $data = $this->db->query("SELECT nombres,U.nombre as usuario,tipo from persona P INNER JOIN usuario U on U.codigoPersona = P.codigo where U.codigo = $codigo")->fetchAll();
            } else {
                $data = $this->db->query("SELECT nombres,U.nombre as usuario,tipo from persona P INNER JOIN usuario U on U.codigoPersonal = P.codigo where U.codigo = $codigo")->fetchAll();
            }
            echo json_encode(array('estado' => true, 'data' => $data[0]));
        } else {
            echo json_encode(array('estado' => false, 'mensaje' => 'Datos no coinciden'));
        }
    } catch (PDOException $e) {
        echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ', $e->getMessage()));
    }
});
// clave codigoP tipo
// mensajito 
$app->patch('/api/recuperar/{codigo}', function (Request $request) {
    $codigoP = $request->getAttribute('codigo');
    $clave = $request->getParam('clave');
    $tipo = $request->getParam('tipo');

    try {
        if ($tipo == "persona") {
            $codigo = $this->db->query("SELECT U.codigo, U.clave FROM usuario U INNER JOIN persona P on P.codigo = U.codigoPersona  WHERE codigoPersona = '$codigoP' ")->fetchAll();
        } else {
            $codigo = $this->db->query("SELECT U.codigo, U.clave FROM usuario U INNER JOIN personal P on P.codigo = U.codigoPersonal  WHERE codigoPersonal = '$codigoP' ")->fetchAll();
        }

        $codigo = $codigo[0]->codigo;
        $hash = password_hash($clave, PASSWORD_DEFAULT);
        $cantidad = $this->db->exec("UPDATE usuario set
                                      clave = '$hash'
                                      WHERE codigo = $codigo");
        if ($cantidad > 0) {
            echo json_encode(array('estado' => true, 'mensaje' => 'Contraseña actualizada'));
        } else {
            echo json_encode(array('estado' => false, 'mensaje' => 'No se pudo actualizar la contraseña'));
        }
    } catch (PDOException $e) {
        echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ', $e->getMessage()));
    }
});

function verifyHass($clave, $url)
{
    $clave = str_replace('/', '', $clave);
    if ($clave == $url) {
        return true;
    } else {
        return false;
    }
}
