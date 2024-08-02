<script setup>
import Agenda from '@/components/Agenda.vue'
</script>

<template>
  <nav>
    <RouterLink :to="{ name: 'slots', params: {day: '2024-06-26'} }">Slots</RouterLink>
    <RouterLink :to="{ name: 'members' }">Members</RouterLink>
  </nav>
  <RouterView />
</template>

<style scoped>
</style>
