<script setup>
import Agenda from '../components/Agenda.vue';
import { useRoute } from 'vue-router';

const {params} = useRoute()
console.log({params})
</script>

<template>
    <Suspense>
        <!-- navigation entre jours -->
        <Agenda :day="$route.params.day" />
    </Suspense>

</template>
