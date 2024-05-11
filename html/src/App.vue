<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import Hud from './components/Hud.vue';

const sites = ['/', 'Info'];
let currentIndex = 0;
const displayUI = {
  settings: ref(false),
  hud: ref(false)
};

const router = useRouter(); // Define the router instance correctly

// Use onMounted to ensure the Vue instance is fully mounted before pushing
onMounted(() => {
  router.push('/'); // Navigate to the home page initially
  window.addEventListener('message', (event) => {
    if (event.data.type === 'switch') {
      currentIndex = currentIndex + 1;

      if (currentIndex > sites.length - 1) {
        currentIndex = 0;
      }
     
      router.push(sites[currentIndex]);
    } else if (event.data.type === 'data') {
      weather = event.data.settings.weather
      console.log("Weather: ", weather);
      time = event.data.settings.time
      console.log("Time: ", time);
    } else if (event.data.type != "update") {
       displayUI[event.data.type].value = !displayUI[event.data.type].value;
    }
  });
});
</script>

<template>
  <Hud v-if="displayUI.hud.value" :draggable="displayUI.settings.value"></Hud>
</template>
