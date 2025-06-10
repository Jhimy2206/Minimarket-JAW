// Guardar nuevo usuario
function saveUser(username, email, password) {
    let users = JSON.parse(localStorage.getItem('users')) || [];
    users.push({ username, email, password });
    localStorage.setItem('users', JSON.stringify(users));
}

// Registrar usuario
function registerUser() {
    const username = document.querySelector('#register input[name="username"]').value;
    const email = document.querySelector('#register input[name="email"]').value;
    const password = document.querySelector('#register input[name="password"]').value;

    if (username && email && password) {
        saveUser(username, email, password);
        alert("Registro exitoso. Ahora puedes iniciar sesión.");
        switchToLogin(); // Cambia a pantalla de login
    } else {
        alert("Por favor completa todos los campos.");
    }

    return false;
}

// Login usuario
function loginUser() {
    const username = document.querySelector('.login-container input[name="username"]').value;
    const password = document.querySelector('.login-container input[name="password"]').value;

    const users = JSON.parse(localStorage.getItem('users')) || [];

    const validUser = users.find(user => user.username === username && user.password === password);

    if (validUser) {
        alert("Inicio de sesión exitoso. Bienvenido!");
        window.location.href = "index.html"; // Redirigir a index
    } else {
        alert("Usuario o contraseña incorrectos.");
    }

    return false;
}

// Cambiar entre login y registro
function switchToRegister() {
    document.querySelector('.login-container').style.display = 'none';
    document.querySelector('.register-container').style.display = 'block';
}

function switchToLogin() {
    document.querySelector('.register-container').style.display = 'none';
    document.querySelector('.login-container').style.display = 'block';
}
