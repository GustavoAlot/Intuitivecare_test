<template>
  <div style="padding: 2rem; font-family: sans-serif">
    <h1>🔍 Buscar Operadoras</h1>

    <input
      v-model="busca"
      @input="buscarOperadoras"
      placeholder="Digite o nome ou CNPJ..."
      style="padding: 0.5rem; width: 300px; margin-bottom: 1rem"
    />

    <ul v-if="resultados.length">
      <li
        v-for="(op, i) in resultados"
        :key="i"
        style="margin-bottom: 0.5rem"
      >
        <strong>{{ op.Razao_Social || '[Sem razão social]' }}</strong> —
        CNPJ: {{ op.CNPJ }} —
        Registro ANS: {{ op.Registro_ANS }}

      </li>
    </ul>

    <p v-else-if="busca.length >= 3">Nenhum resultado encontrado.</p>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const busca = ref('')
const resultados = ref([])

async function buscarOperadoras() {
  if (busca.value.length < 3) {
    resultados.value = []
    return
  }

  try {
    const res = await fetch(`http://127.0.0.1:8000/buscar?q=${encodeURIComponent(busca.value)}`)
    if (res.ok) {
      resultados.value = await res.json()
    } else {
      console.error('Erro na requisição:', res.status)
    }
  } catch (error) {
    console.error('Erro ao buscar:', error)
  }
}
</script>
