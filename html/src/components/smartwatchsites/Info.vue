
<script setup>
import { Icon } from '@iconify/vue';
window.addEventListener('message', (event) => {

    if (event.data.type === "update") {
        handleData(event.data)
    }
});
function handleData(data){
   if (data.job != NULL) {
        
    }

    if (data.grade != NULL) {
        
    }

    if (data.money != NULL) {
      
    }

    if (data.bank != NULL) {

    }

   



}
</script>
<template>
    <div class="background">
        <Icon icon="mdi:briefcase"  class = "icons" style="color: #fffafa" /> <p class = "text"> job</p>
        <Icon icon="mdi:star"  class = "icons" style="color: #fffafa" /> <p class = "text"> grade</p>
        <Icon icon="mdi:cash"  class = "icons" style="color: #fffafa" /> <p class = "text"> money</p>
        <Icon icon="mdi:bank"  class = "icons" style="color: #fffafa" /> <p class = "text"> bank</p>
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

.text {
    margin-left: 1rem;
    font-size: 1.5rem;
}

.icons {
    display: flex;
    align-items: center;
    margin: 0 0.5rem;


}


</style>



