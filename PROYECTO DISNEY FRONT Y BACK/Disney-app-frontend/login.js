// 1. Simulamos nuestra base de datos SQL de usuarios (Mock Data)
// En un proyecto real, esto se validaría contra la base de datos SQLite a través del servidor
const mockUsers = [
    {
        email: "usuario@disney.com",
        password: "123",
        name: "Mickey Mouse"
    },
    {
        email: "admin@disney.com",
        password: "admin",
        name: "Administrador"
    }
];

// 2. Esperamos a que el DOM esté cargado
document.addEventListener('DOMContentLoaded', () => {
    const loginForm = document.getElementById('loginForm');

    if (loginForm) {
        loginForm.addEventListener('submit', (e) => {
            e.preventDefault(); // Evitamos que la página se recargue automáticamente

            // 3. Capturamos los valores de los inputs
            const emailValue = document.getElementById('email').value.trim();
            const passwordValue = document.getElementById('password').value.trim();

            // 4. Lógica de validación (Simulando: SELECT * FROM users WHERE email = ? AND password = ?)
            const user = mockUsers.find(u => u.email === emailValue && u.password === passwordValue);

            if (user) {
                // Éxito: Guardamos la "sesión" en el almacenamiento local del navegador (LocalStorage)
                // Esto nos servirá para saber si el usuario está logueado en la página principal
                localStorage.setItem('userAuthenticated', 'true');
                localStorage.setItem('userName', user.name);

                console.log("Login exitoso. Redirigiendo...");
                
                // 5. Redirección a la página principal
                window.location.href = 'index.html'; 
            } else {
                // Error: Mostramos una alerta (puedes mejorar esto con un mensaje de error en el HTML)
                alert('Credenciales incorrectas. Prueba con: usuario@disney.com / 123');
            }
        });
    }
});