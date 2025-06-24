<?php
include('../db.php');
header('Content-Type: application/json');

// Obtener el ID del usuario (puede ser por token, sesión o parámetro)
$usuario_id = $_GET['usuario_id'] ?? null;

if (!$usuario_id) {
    echo json_encode(["error" => "Falta el ID de usuario"]);
    exit;
}

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Obtener pedidos del usuario
    $stmt = $pdo->prepare("SELECT * FROM pedidos WHERE usuario_id = ? ORDER BY fecha DESC");
    $stmt->execute([$usuario_id]);
    $pedidos = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $historial = [];

    foreach ($pedidos as $pedido) {
        $stmt = $pdo->prepare("
            SELECT p.nombre, dp.cantidad, dp.subtotal
            FROM detalle_pedido dp
            JOIN productos p ON p.id = dp.producto_id
            WHERE dp.pedido_id = ?
        ");
        $stmt->execute([$pedido['id']]);
        $productos = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $historial[] = [
            "fecha" => $pedido['fecha'],
            "total" => $pedido['total'],
            "productos" => $productos
        ];
    }

    echo json_encode($historial);

} catch (PDOException $e) {
    echo json_encode(["error" => $e->getMessage()]);
}
?>

