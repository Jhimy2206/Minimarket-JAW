<?php
header('Access-Control-Allow-Origin: *'); 
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Headers: Content-Type');

$conexion = new mysqli("localhost", "root", "", "minimarket");

if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

// Usamos JOIN para obtener también el nombre de la categoría
$sql = "SELECT 
            productos.id,
            productos.nombre,
            productos.descripcion,
            productos.precio,
            productos.imagen_url,
            productos.creado_en,
            categorias.id AS categoria_id,
            categorias.nombre AS categoria_nombre
        FROM productos
        LEFT JOIN categorias ON productos.categoria_id = categorias.id";

$resultado = $conexion->query($sql);

$productos = [];

while ($fila = $resultado->fetch_assoc()) {
    $productos[] = $fila;
}

header('Content-Type: application/json');
echo json_encode($productos);
?>
