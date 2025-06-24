<?php
// Permitir CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

// Conexión a la base de datos
$conn = new mysqli("localhost", "root", "", "minimarket");

// Verificar conexión
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["error" => "Error de conexión"]);
    exit();
}

// Consulta de categorías
$sql = "SELECT id, nombre FROM categorias";
$result = $conn->query($sql);

// Verificar resultados
$categorias = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $categorias[] = $row;
    }
}

// Enviar respuesta JSON
echo json_encode($categorias);
$conn->close();
?>
