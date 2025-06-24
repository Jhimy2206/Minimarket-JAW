<?php
// Encabezados para permitir CORS
header('Access-Control-Allow-Origin: *'); 
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

// Conexión a la base de datos
$conexion = new mysqli("localhost", "root", "", "minimarket");

// Verificar conexión
if ($conexion->connect_error) {
    http_response_code(500);
    echo json_encode(['error' => 'Error en la conexión a la base de datos']);
    exit;
}

// Obtener ID del producto desde GET
$product_id = isset($_GET['product_id']) ? intval($_GET['product_id']) : 0;

if ($product_id <= 0) {
    http_response_code(400);
    echo json_encode(['error' => 'ID de producto inválido']);
    exit;
}

// Consulta preparada para obtener el producto
$stmt = $conexion->prepare("
    SELECT p.id, p.nombre, p.descripcion, p.precio, p.imagen_url, c.nombre AS categoria_nombre
    FROM productos p
    JOIN categorias c ON p.categoria_id = c.id
    WHERE p.id = ?
");

$stmt->bind_param('i', $product_id);
$stmt->execute();
$resultado = $stmt->get_result();
$producto = $resultado->fetch_assoc();

// Enviar respuesta
if ($producto) {
    echo json_encode($producto);
} else {
    echo json_encode(['error' => 'Producto no encontrado']);
}

$stmt->close();
$conexion->close();
?>
