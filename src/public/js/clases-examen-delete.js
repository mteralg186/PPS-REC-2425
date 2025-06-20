document.addEventListener('DOMContentLoaded', function () {
  let eliminarId = null;
  let eliminarTipo = null;

  // Evento para clases
  document.querySelectorAll('.btn-eliminar-clase').forEach(btn => {
    btn.addEventListener('click', function () {
      eliminarId = this.getAttribute('data-id');
      eliminarTipo = 'clase';
      mostrarConfirmacion();
    });
  });

  // Evento para exámenes
  document.querySelectorAll('.btn-eliminar-examen').forEach(btn => {
    btn.addEventListener('click', function () {
      eliminarId = this.getAttribute('data-id');
      eliminarTipo = 'examen';
      mostrarConfirmacion();
    });
  });

  function mostrarConfirmacion() {
    const mensaje = eliminarTipo === 'clase'
      ? '¿Estás seguro de que quieres eliminar esta clase? Se eliminarán también sus exámenes relacionados.'
      : '¿Estás seguro de que quieres eliminar este examen?';

    document.getElementById('confirmModalBody').textContent = mensaje;

    const modalElement = document.getElementById('confirmModal');
    const modal = new bootstrap.Modal(modalElement);

    modal.show();

    const btnConfirmar = document.getElementById('confirmBtn');
    btnConfirmar.onclick = null;

    btnConfirmar.onclick = async () => {
      modal.hide();
      if (eliminarTipo === 'clase') {
        await eliminarClase(eliminarId);
      } else {
        await eliminarExamen(eliminarId);
      }
    };
  }

  async function eliminarClase(idClase) {
    try {
      const res = await fetch(`/profesor/clases/${idClase}`, {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' }
      });
      const data = await res.json();

      if (data.success) {
        alert('Clase eliminada correctamente.');
        document.getElementById(`fila-clase-${idClase}`).remove();
      } else {
        alert('Error al eliminar la clase: ' + (data.error || 'Error desconocido.'));
      }
    } catch {
      alert('No se pudo conectar con el servidor. Por favor, inténtalo más tarde.');
    }
  }

  async function eliminarExamen(idExamen) {
    try {
      const res = await fetch(`/profesor/examenes/${idExamen}`, {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' }
      });
      const data = await res.json();

      if (data.success) {
        alert('Examen eliminado correctamente.');
        document.getElementById(`fila-examen-${idExamen}`).remove();
      } else {
        alert('Error al eliminar el examen: ' + (data.error || 'Error desconocido.'));
      }
    } catch {
      alert('No se pudo conectar con el servidor. Por favor, inténtalo más tarde.');
    }
  }
});