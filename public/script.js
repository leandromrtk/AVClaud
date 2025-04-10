const baseURL = '/resumo';

document.addEventListener('DOMContentLoaded', async () => {
  const path = window.location.pathname;

  // Página de reservas
  if (path.includes('reservas')) {
    const form = document.getElementById('reservaForm');
    const lista = document.getElementById('listaReservas');

    form.addEventListener('submit', async e => {
      e.preventDefault();
      const data = Object.fromEntries(new FormData(form));
      await fetch('/reserva', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      });
      form.reset();
      location.reload();
    });

    const resumo = await (await fetch(baseURL)).json();
    resumo.reservas.forEach(res => {
      const li = document.createElement('li');
      li.textContent = `Nome: ${res.nome} | Telefone: ${res.telefone} | Data: ${res.data}`;
      lista.appendChild(li);
    });
  }

  // Página de pedidos
  if (path.includes('pedidos')) {
    const form = document.getElementById('pedidoForm');
    const lista = document.getElementById('listaPedidos');

    form.addEventListener('submit', async e => {
      e.preventDefault();
      const data = Object.fromEntries(new FormData(form));
      await fetch('/pedido', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      });
      form.reset();
      location.reload();
    });

    const resumo = await (await fetch(baseURL)).json();
    resumo.pedidos.forEach(p => {
      const li = document.createElement('li');
      li.textContent = `Cliente: ${p.cliente} | Itens: ${p.itens}`;
      lista.appendChild(li);
    });
  }
});
