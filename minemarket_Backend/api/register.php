<?php
// Cabeceras CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header("Content-Type: application/json; charset=UTF-8");

// Manejo de preflight (OPTIONS)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Conexión a base de datos local
$servidor = "localhost";
$usuario = "root";
$contrasenia = ""; // Cambiar si tienes contraseña en tu MySQL
$nombreBaseDatos = "Minimarket";

$conexionBD = new mysqli($servidor, $usuario, $contrasenia, $nombreBaseDatos);

// Verificar conexión
if ($conexionBD->connect_error) {
    die(json_encode(["success" => 0, "message" => "Error de conexión: " . $conexionBD->connect_error]));
}

// Solo aceptar solicitudes POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);

    if (!isset($data['username']) || !isset($data['email']) || !isset($data['password'])) {
        echo json_encode(["success" => 0, "message" => "Faltan campos obligatorios"]);
        exit();
    }

    $username = $data['username'];
    $email = $data['email'];
    $password = password_hash($data['password'], PASSWORD_DEFAULT);

    // Verificar si ya existe el usuario o correo
    $stmt = $conexionBD->prepare("SELECT id FROM users WHERE username = ? OR email = ?");
    $stmt->bind_param("ss", $username, $email);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        echo json_encode(["success" => 0, "message" => "Usuario o correo ya registrados"]);
        $stmt->close();
        exit();
    }
    $stmt->close();

    // Insertar nuevo usuario
    $stmt = $conexionBD->prepare("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
    $stmt->bind_param("sss", $username, $email, $password);

    if ($stmt->execute()) {
        echo json_encode(["success" => 1, "message" => "Registro exitoso"]);
    } else {
        echo json_encode(["success" => 0, "message" => "Error al registrar usuario"]);
    }

    $stmt->close();
} else {
    echo json_encode(["success" => 0, "message" => "Método no permitido"]);
}

$conexionBD->close();
?>
