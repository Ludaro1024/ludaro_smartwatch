
<script setup>
import { Icon } from '@iconify/vue';
import { ref, onMounted } from 'vue'
import axios from 'axios';

window.addEventListener('message', (event) => {

    if (event.data.type === "update") {
        handleData(event.data)
    }
});
axios.get(`https://${GetParentResourceName()}/onReady`)
    .then((response) => {
      handleData(response.data)
})

const cash = ref(0);
const bank = ref(0);
const job = ref("none");


function handleData(data){
   if (data.job != null) {
        job.value = data.job;
    }

    if (data.money != null) {
        cash.value = data.money;
    }

    if (data.bank != null) {
        bank.value = data.bank
    }

   


}
</script>
<template>
<div class="background">
    <div class="top-left">
        <div class="icon">
            <Icon icon="ph:money-wavy-fill" width="1rem" height="1rem" /> 
        </div>
        <div class="info">
            <p class="label">Cash:</p>
            <p class="value">${{ cash }}</p>
        </div>
    </div>
    <div class="top-right">
        <div class="icon">
            <Icon icon="ph:bank-fill" width="1rem" height="1rem" /> 
        </div>
        <div class="info">
            <p class="label">Bank:</p>
            <p class="value">${{ bank }}</p>
        </div>
    </div>
    <div class="middle">
        <div class="icon">
            <Icon icon="ph:briefcase-fill" width="1rem" height="1rem" /> 
        </div>
        <div class="info">
            <p class="label">Job:</p>
            <p class="value">{{ job }}</p>
        </div>
    </div>
</div>




</template>

<style>
.background {
  background-color: #1b1b1b;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  color: white;
  width: 100%;
  height: 100%;
}

.top-left, .top-right, .middle {
    display: flex;
    align-items: center;
    margin-bottom: 0.2rem;
}

.icon {
    background-color: #333;
    padding: 8px;
    border-radius: 50%;
    margin-right: 0px;
}

.info {
    display: flex;
    flex-direction: column;
    margin-bottom: 0.2rem;
    margin-left: 0.2rem;
}

.label {
    margin: 0;
    font-size: 0.7rem;
}

.value {
    margin: 0;
    font-size: 0.9rem;
    font-weight: bold;
}




</style>

