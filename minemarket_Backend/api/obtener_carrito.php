<?php
// Encabezados CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Content-Type: application/json; charset=UTF-8");

// Conexión a base de datos
$conexion = new mysqli("localhost", "root", "", "minimarket");

// Verificar conexión
if ($conexion->connect_error) {
    echo json_encode(["success" => 0, "message" => "Error de conexión: " . $conexion->connect_error]);
    exit();
}

// Verificar que se haya enviado el usuario_id
if (!isset($_GET['usuario_id'])) {
    echo json_encode(["success" => 0, "message" => "usuario_id es requerido"]);
    exit();
}

$usuario_id = intval($_GET['usuario_id']);

$sql = "SELECT c.*, p.nombre, p.precio, p.imagen_url 
        FROM carrito c
        JOIN productos p ON c.producto_id = p.id
        WHERE c.usuario_id = ?";

$stmt = $conexion->prepare($sql);
$stmt->bind_param("i", $usuario_id);
$stmt->execute();

$result = $stmt->get_result();
$carrito = [];

while ($row = $result->fetch_assoc()) {
    $carrito[] = $row;
}

echo json_encode($carrito);

$stmt->close();
$conexion->close();
?>
