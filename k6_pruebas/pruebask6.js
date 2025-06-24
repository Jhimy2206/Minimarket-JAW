import http from 'k6/http';
import { check, sleep } from 'k6';
import { htmlReport } from "https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js";

// Configuración de la prueba
/*export let options = {
  stages: [
    { duration: '10s', target: 5 },
    { duration: '30s', target: 5 },
    { duration: '10s', target: 0 },
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'],
    http_req_failed: ['rate<0.15'], // Ajuste temporal
  },
};*/

// Función para realizar login y obtener usuario_id
function login() {
  const loginUrl = 'http://localhost/minemarket/api/login.php';
  const loginPayload = {
    username: 'Ander',
    password: 'ander123',
  };
  const loginParams = {
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
  };

  const loginRes = http.post(loginUrl, loginPayload, loginParams);
  check(loginRes, {
    'login status es 200': (r) => r.status === 200,
    'respuesta no vacía': (r) => r.body.length > 0,
  });

  const usuarioId = '4';
  return usuarioId;
}

// Función principal para el flujo completo
export default function () {
  const usuarioId = login();

  const storeUrl = 'http://127.0.0.1:5500/shop.html';
  const storeRes = http.get(storeUrl);
  check(storeRes, {
    'tienda status es 200 o 304': (r) => r.status === 200 || r.status === 304,
  });

  const cartUrl = 'http://localhost/minemarket/api/agregar_carrito.php';
  const cartPayload = {
    usuario_id: usuarioId,
    producto_id: Math.floor(Math.random() * 10) + 1,
    cantidad: 1,
  };
  const cartParams = {
    headers: { 'Content-Type': 'application/json' },
  };
  const cartRes = http.post(cartUrl, JSON.stringify(cartPayload), cartParams);
  check(cartRes, {
    'cart status es 200': (r) => r.status === 200,
    'producto agregado': (r) => r.status === 200 || JSON.parse(r.body).success === true,
  });

  const cartViewUrl = 'http://127.0.0.1:5500/cart.html';
  const cartViewRes = http.get(cartViewUrl);
  check(cartViewRes, {
    'carrito status es 200 o 304': (r) => r.status === 200 || r.status === 304,
  });

  const checkoutUrl = 'http://127.0.0.1:5500/chackout.html';
  const checkoutParams = {
    headers: {
      'Cache-Control': 'no-cache',
      'Pragma': 'no-cache',
      'If-Modified-Since': 'Wed, 11 Jun 2025 00:00:00 GMT',
    },
  };
  const checkoutRes = http.get(checkoutUrl, checkoutParams);
  check(checkoutRes, {
    'checkout status es 200 o 304': (r) => r.status === 200 || r.status === 304,
  });

  const placeOrderUrl = 'http://localhost/minemarket/api/realizar_pedido.php';
  const placeOrderPayload = {
    usuario_id: usuarioId,
    nombre: 'Anderson',
    apellidos: 'Escalante',
    empresa: 'UPN',
    pais: 'Perú',
    direccion: 'Jr. Manuel Cacho Gálvez',
    ciudad: 'Sucre',
    codigo_postal: '03001',
    telefono: '959149950',
    email: 'anderescalante.0507@gmail.com',
    metodo_pago: 'Pago con cheque',
    metodo_envio: 'Envío gratis',
    costo_envio: 0,
    notas: null,
    subtotal: 2.3,
    total: 2.3,
    items: [{ producto_id: 4, nombre: 'Uvas', precio: 2.3, cantidad: 1, subtotal: 2.3 }],
  };
  const placeOrderParams = {
    headers: { 'Content-Type': 'application/json' },
  };
  const placeOrderRes = http.post(placeOrderUrl, JSON.stringify(placeOrderPayload), placeOrderParams);
  check(placeOrderRes, {
    'order status es 200': (r) => r.status === 200,
    'compra exitosa': (r) => r.body.includes('success'),
  });

  const historyUrl = 'http://localhost/minemarket/api/obtener_historial.php?usuario_id=' + usuarioId;
  const historyRes = http.get(historyUrl);
  check(historyRes, {
    'historial status es 200': (r) => r.status === 200,
    'historial exitoso': (r) => JSON.parse(r.body).success === true,
  });

  sleep(1);
}

// Generación del informe HTML
export function handleSummary(data) {
  return {
    "summary.html": htmlReport(data),
  };
}