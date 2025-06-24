<?php
// buscar_producto.php

// CORS headers
header("Access-Control-Allow-Origin: *"); 
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

// Conexión a la base de datos
$conexion = new mysqli("localhost", "root", "", "minimarket");

// Verificar conexión
if ($conexion->connect_error) {
    echo json_encode([
        "success" => false,
        "error" => "Conexión fallida: " . $conexion->connect_error
    ]);
    exit();
}

// Obtener parámetros
$nombre = isset($_GET['nombre']) ? $_GET['nombre'] : '';
$categoria = isset($_GET['categoria']) ? $_GET['categoria'] : '';

// Construir consulta
$query = "SELECT * FROM productos WHERE 1=1";
$params = [];
$types = "";

if (!empty($nombre)) {
    $query .= " AND nombre LIKE ?";
    $params[] = "%" . $nombre . "%";
    $types .= "s";
}

if (!empty($categoria)) {
    $query .= " AND categoria = ?";
    $params[] = $categoria;
    $types .= "s";
}

// Preparar y ejecutar la consulta
$stmt = $conexion->prepare($query);

if (!empty($params)) {
    $stmt->bind_param($types, ...$params);
}

$stmt->execute();
$resultado = $stmt->get_result();

$productos = [];

while ($row = $resultado->fetch_assoc()) {
    $productos[] = $row;
}

// Respuesta JSON
echo json_encode([
    "success" => true,
    "data" => $productos
]);

// Cerrar conexiones
$stmt->close();
$conexion->close();


