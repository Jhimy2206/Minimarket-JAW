<?php
// Cabeceras CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header("Content-Type: application/json; charset=UTF-8");

// Manejar preflight OPTIONS
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Conexión a base de datos local
$servidor = "localhost";
$usuario = "root";
$contrasenia = ""; // Cambia esto si tu MySQL local tiene contraseña
$nombreBaseDatos = "Minimarket";

$conexionBD = new mysqli($servidor, $usuario, $contrasenia, $nombreBaseDatos);

// Verificar conexión
if ($conexionBD->connect_error) {
    die(json_encode(["success" => 0, "message" => "Error de conexión: " . $conexionBD->connect_error]));
}

// Validar que sea POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);

    if (!isset($data['username']) || !isset($data['password'])) {
        echo json_encode(["success" => 0, "message" => "Faltan campos obligatorios"]);
        exit();
    }

    $username = $data['username'];
    $password = $data['password'];

    $stmt = $conexionBD->prepare("SELECT id, username, email, password FROM users WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();

        if (password_verify($password, $user['password'])) {
            echo json_encode([
                "success" => 1,
                "message" => "Inicio de sesión exitoso",
                "data" => [
                    "id" => $user['id'],
                    "username" => $user['username'],
                    "email" => $user['email']
                ]
            ]);
        } else {
            http_response_code(401); 
            echo json_encode(["success" => 0, "message" => "Contraseña incorrecta"]);
        }
    } else {
        echo json_encode(["success" => 0, "message" => "Usuario no encontrado"]);
    }

    $stmt->close();
} else {
    echo json_encode(["success" => 0, "message" => "Método no permitido"]);
}

$conexionBD->close();
?>
