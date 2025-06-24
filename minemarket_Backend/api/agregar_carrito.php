<?php
// Cabeceras CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");

// Conexión
$servidor = "localhost";
$usuario = "root";
$contrasenia = "";
$nombreBaseDatos = "Minimarket";

$conn = new mysqli($servidor, $usuario, $contrasenia, $nombreBaseDatos);

if ($conn->connect_error) {
    die(json_encode(["success" => false, "error" => "Conexión fallida: " . $conn->connect_error]));
}

// Leer JSON del frontend
$data = json_decode(file_get_contents("php://input"), true);

// Verificar que se recibieron datos válidos
if (!isset($data["usuario_id"], $data["producto_id"], $data["cantidad"])) {
    echo json_encode(["success" => false, "error" => "Datos incompletos"]);
    exit;
}

$usuario_id = $data["usuario_id"];
$producto_id = $data["producto_id"];
$cantidad = $data["cantidad"];

// VERIFICAR si el producto ya está en el carrito para ese usuario
$check_sql = "SELECT id FROM carrito WHERE usuario_id = ? AND producto_id = ?";
$check_stmt = $conn->prepare($check_sql);
$check_stmt->bind_param("ii", $usuario_id, $producto_id);
$check_stmt->execute();
$check_stmt->store_result();

if ($check_stmt->num_rows > 0) {
    echo json_encode(["success" => false, "error" => "Producto ya en el carrito"]);
    $check_stmt->close();
    $conn->close();
    exit;
}
$check_stmt->close();

// Insertar en tabla carrito
$sql = "INSERT INTO carrito (usuario_id, producto_id, cantidad, agregado_en) VALUES (?, ?, ?, NOW())";
$stmt = $conn->prepare($sql);
$stmt->bind_param("iii", $usuario_id, $producto_id, $cantidad);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "error" => $stmt->error]);
}

$stmt->close();
$conn->close();
?>
