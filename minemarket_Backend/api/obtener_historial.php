<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

$conexion = new mysqli("localhost", "root", "", "minimarket");

if ($conexion->connect_error) {
    echo json_encode(["success" => false, "error" => "Conexión fallida: " . $conexion->connect_error]);
    exit();
}

$usuario_id = isset($_GET['usuario_id']) ? intval($_GET['usuario_id']) : 0;

if ($usuario_id <= 0) {
    echo json_encode(["success" => false, "error" => "ID de usuario inválido"]);
    exit();
}

// Obtener historial de compras
$result = $conexion->query("
    SELECT h.id, h.fecha_pedido, h.total, h.metodo_pago, h.metodo_envio
    FROM historial_compras h
    WHERE h.usuario_id = $usuario_id
    ORDER BY h.fecha_pedido DESC
");

$historial = [];
while ($row = $result->fetch_assoc()) {
    // Obtener detalles del pedido
    $detalle_result = $conexion->query("
        SELECT d.producto_id, d.nombre, d.precio, d.cantidad, d.subtotal
        FROM detalle_historial d
        WHERE d.historial_id = {$row['id']}
    ");
    $detalles = [];
    while ($detalle = $detalle_result->fetch_assoc()) {
        $detalles[] = $detalle;
    }
    $row['detalles'] = $detalles;
    $historial[] = $row;
}

echo json_encode(["success" => true, "data" => $historial]);

$conexion->close();
?>