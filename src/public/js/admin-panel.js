document.addEventListener('DOMContentLoaded', function () {
    function mostrarTabla(id) {
        document.querySelectorAll('.tabla').forEach(t => t.classList.remove('activa'));
        var tabla = document.getElementById(id);
        if (tabla) tabla.classList.add('activa');
    }

    // Asigna el evento a los botones
    document.querySelectorAll('nav button[data-tabla]').forEach(btn => {
        btn.addEventListener('click', function () {
            mostrarTabla(this.getAttribute('data-tabla'));
        });
    });

    // Mostrar la tabla de usuarios por defecto
    mostrarTabla('usuarios');
});