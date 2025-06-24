<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

$conexion = new mysqli("localhost", "root", "", "minimarket");

if ($conexion->connect_error) {
    echo json_encode(["success" => false, "error" => "Conexión fallida: " . $conexion->connect_error]);
    exit();
}

$input = file_get_contents("php://input");
$data = json_decode($input, true);

if (!$data || !isset($data['usuario_id']) || !isset($data['items'])) {
    echo json_encode(["success" => false, "error" => "Datos inválidos"]);
    exit();
}

// Iniciar transacción
$conexion->begin_transaction();

try {
    // Insertar en historial_compras
    $stmt = $conexion->prepare("
        INSERT INTO historial_compras (
            usuario_id, nombre, apellidos, direccion, telefono, email,
            metodo_pago, metodo_envio, costo_envio, notas, subtotal, total
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ");
    $stmt->bind_param(
        "isssssssdsdd",
        $data['usuario_id'],
        $data['nombre'],
        $data['apellidos'],
        $data['direccion'],
        $data['telefono'],
        $data['email'],
        $data['metodo_pago'],
        $data['metodo_envio'],
        $data['costo_envio'],
        $data['notas'],
        $data['subtotal'],
        $data['total']
    );
    $stmt->execute();
    $historial_id = $conexion->insert_id;
    $stmt->close();

    // Insertar detalles del pedido
    $stmt = $conexion->prepare("
        INSERT INTO detalle_historial (
            historial_id, producto_id, nombre, precio, cantidad, subtotal
        ) VALUES (?, ?, ?, ?, ?, ?)
    ");
    foreach ($data['items'] as $item) {
        $stmt->bind_param(
            "iisdid",
            $historial_id,
            $item['producto_id'],
            $item['nombre'],
            $item['precio'],
            $item['cantidad'],
            $item['subtotal']
        );
        $stmt->execute();
    }
    $stmt->close();

    // Limpiar el carrito
    $stmt = $conexion->prepare("DELETE FROM carrito WHERE usuario_id = ?");
    $stmt->bind_param("i", $data['usuario_id']);
    $stmt->execute();
    $stmt->close();

    // Confirmar transacción
    $conexion->commit();
    echo json_encode(["success" => true, "message" => "Pedido realizado exitosamente"]);
} catch (Exception $e) {
    // Revertir transacción en caso de error
    $conexion->rollback();
    echo json_encode(["success" => false, "error" => "Error al procesar el pedido: " . $e->getMessage()]);
}

$conexion->close();
?>
