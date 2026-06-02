document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('registroForm');
    if (form) {
        form.addEventListener('submit', function (event) {
            const clave = document.getElementById('clave');
            if (clave && clave.value.length < 8) {
                event.preventDefault();
                alert('La clave debe tener minimo 8 caracteres.');
                clave.focus();
            }
        });
    }
});
