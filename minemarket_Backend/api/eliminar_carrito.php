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

// Verificar que se haya enviado id
if (!isset($_GET['id'])) {
    echo json_encode(["success" => 0, "message" => "El id del carrito es requerido"]);
    exit();
}

$id = intval($_GET['id']);

// Consulta para eliminar el producto del carrito
$sql = "DELETE FROM carrito WHERE id = ?";

$stmt = $conexion->prepare($sql);
$stmt->bind_param("i", $id);
$stmt->execute();

// Verificar si la eliminación fue exitosa
if ($stmt->affected_rows > 0) {
    echo json_encode(["success" => 1, "message" => "Producto eliminado correctamente del carrito"]);
} else {
    echo json_encode(["success" => 0, "message" => "No se encontró el producto en el carrito o error al eliminar"]);
}

$stmt->close();
$conexion->close();
?>