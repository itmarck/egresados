<?php

use Psr\Http\Message\ServerRequestInterface as Request;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;


$app->post('/api/recuperar', function (Request $request) {
    $correo = $request->getParam('correo');
    try {
        $hash = $this->db->query("SELECT clave,nombres from usuario U INNER JOIN persona P on  P.codigo = U.codigoPersona where correo = '$correo'")->fetchAll();
        if ($hash) {
            $clave = str_replace('/', '', $hash[0]->clave);
            $url = "http://localhost:8080/recuperar/$clave";
            $nombre = $hash[0]->nombres;
            require '../PHPMailer/Plantillas/restore.php';
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
            $mail->Subject = 'Solicitud de cambio de clave';
            $mail->Body    = $recuperar;
            $mail->AltBody = "Ingresa aqui para recuperar tu contraseña $url";
            $mail->send();
            echo json_encode(array('estado' => true, 'mensaje' => 'Enlace de recuperacion enviado a ' . $correo));
        } else {
            echo json_encode(array('estado' => false, 'mensaje' => 'Este correo no se encuentra registrado'));
        }
    } catch (PDOException $e) {
        echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ' . $e->getMessage()));
    }
});

// nombres nombredeusuario tipo 
$app->get('/api/recuperar/{hash}', function (Request $request) {
    $url = $request->getAttribute('hash');
    try {
        $usuario = $this->db->query("SELECT clave,tipo,codigo from usuario")->fetchAll();
        foreach ($usuario as $key => $user) {
            if (verifyHass($user->clave, $url)) {
                if ($user->tipo == "E") {
                    $data = $this->db->query("SELECT nombres,U.codigo,correo,U.nombre as usuario,tipo from persona P INNER JOIN usuario U on U.codigoPersona = P.codigo where U.codigo = $user->codigo")->fetchAll();
                } else {
                    $data = $this->db->query("SELECT nombres,U.codigo,correo, U.nombre as usuario,tipo from persona P INNER JOIN usuario U on U.codigoPersonal = P.codigo where U.codigo = $user->codigo")->fetchAll();
                }
                echo json_encode(array('estado' => true, 'data' => $data[0]));
                exit;
            }
        }
        echo json_encode(array('estado' => false, 'mensaje' => 'Datos no coinciden', 'data' => []));
    } catch (PDOException $e) {
        echo json_encode(array('estado' => false, 'mensaje' => 'Error al conectar con la base de datos ', $e->getMessage()));
    }
});
// clave codigoP tipo
// mensajito 
$app->patch('/api/recuperar/{codigo}', function (Request $request) {
    $codigo = $request->getAttribute('codigo');
    $clave = $request->getParam('clave');
    $correo = $request->getParam('correo');
    $nombre = $request->getParam('nombres');

    try {

        $hash = password_hash($clave, PASSWORD_DEFAULT);
        $cantidad = $this->db->exec("UPDATE usuario set
                                      clave = '$hash'
                                      WHERE codigo = $codigo");
        if ($cantidad > 0) {
            echo json_encode(array('estado' => true, 'mensaje' => 'Contraseña actualizada'));
            $datos = $this->db->query("UPDATE usuario set
                                            clave = '$hash'
                                            WHERE codigo = $codigo");
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
            $mail->Subject = 'Solicitud de cambio de clave';
            $nombre = $nombre;
            require '../PHPMailer/Plantillas/change.php';
            $mail->Body    = $cambio;
            $mail->AltBody = "Tu clave ha sido cambiada";
            $mail->send();
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
