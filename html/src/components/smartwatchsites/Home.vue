<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios';
import { Icon } from '@iconify/vue';


const time = ref('00:00:00'); 
const hunger = ref(0);
const thirst = ref(0);
const health = ref(0);
const streetName = ref('');
const oxygen = ref(0); 
const armor = ref(0); 
const idd = ref(0);
function incrementTime() {
  let hours = Number(time.value.split(':')[0]);
  let minutes = Number(time.value.split(':')[1]);
  let seconds = Number(time.value.split(':')[2]);

  seconds += 1;

  if (seconds >= 60) { 
    seconds = 0;
    minutes += 1; 
  }

  if (minutes >= 60) { 
    minutes = 0;
    hours += 1; 
  }

  if (hours >= 24) {
    hours = 0;
  }


  time.value = [
    hours.toString().padStart(2, '0'),
    minutes.toString().padStart(2, '0'),
    seconds.toString().padStart(2, '0')
  ].join(':');
}

function getCurrentTime() {
  let now = new Date();

  let hours = now.getHours();
  let minutes = now.getMinutes();
  let seconds = now.getSeconds();

  // Format the time value
  let formattedTime = [
    hours.toString().padStart(2, '0'),
    minutes.toString().padStart(2, '0'),
    seconds.toString().padStart(2, '0')
  ].join(':');

  return formattedTime;
}

function incrementRealTime() {
  let hours = Number(time.value.split(':')[0]);
  let minutes = Number(time.value.split(':')[1]);
  let seconds = Number(time.value.split(':')[2]);

  seconds += 1;

  if (seconds >= 60) {
    seconds = 0;
    minutes += 1;
  }

  if (minutes >= 60) {
    minutes = 0;
    hours += 1;
  }

  if (hours >= 24) {
    hours = 0;
  }


  time.value = [
    hours.toString().padStart(2, '0'),
    minutes.toString().padStart(2, '0'),
    seconds.toString().padStart(2, '0')
  ].join(':');
}


function makenumbertocolor(number) {
  if (number >= 50) {
    return "lightgreen";
  } else if (number > 20 && number < 50) {
    return "orange";
  } else if (number <= 20) {
    return "red";
  }
}



function handleData(response) {
    hunger.value = response.data.hunger ?? 0;   
    thirst.value = response.data.thirst ?? 0;
    
    health.value = response.data.health ?? 0;
   
    oxygen.value = response.data.oxygen ?? 0;
 
    armor.value = response.data.armor ?? 0;

    idd.value = response.data.idd ?? 0;
 
    streetName.value = (response.data.streetname ?? 'Your Street Name').substring(0, 13);
   
}



window.addEventListener('message', (event) => {

  if(event.data.type === "update"){
    handleData(event)
    
  }
});
function fetchTimeAndStartTimer() {  // proper fivem time ol
  axios.get(`https://${GetParentResourceName()}/onReady`)
    .then((response) => {
      if ( response.data && response.data.time && response.data.realtime != true ) {
        time.value = response.data.time;  
        setInterval(incrementTime, 25.5,);  
      }else{
      time.value = getCurrentTime();
      setInterval(incrementRealTime, 1000);
      }
     handleData(response)
    })
    .catch((error) => {
      console.error('Error:', error);
    });
}

onMounted(fetchTimeAndStartTimer);

</script>
<template>
  <div class="background">
    <p class="idd">{{ idd }}</p>
    <p class="time">{{ time }}</p>
    <div class="icons">
      <div class="top-icons">
        <div class="icon-container">
          <Icon class="hunger-icon" icon="material-symbols:fastfood" :style="{ color: makenumbertocolor(hunger) }"
            width="1.5rem" height="1.5rem" />
          <p class="icontext hunger-text">{{ hunger }}</p>
        </div>

        <div class="icon-container">
          <Icon class="health-icon" icon="material-symbols-light:ecg-heart-sharp"
            :style="{ color: makenumbertocolor(health) }" width=" 1.5rem" height="1.5rem" />
          <p class="icontext health-text">{{ health }}</p>
        </div>

        <div class="icon-container">
          <Icon class="thirst-icon" icon="material-symbols:water-drop" :style="{ color: makenumbertocolor(thirst) }"
            width="1.5rem" height="1.5rem" />
          <p class="icontext thirst-text">{{ thirst }}</p>
        </div>
      </div>

      <div class="streetnamediv">
        <p class="street-name">{{ streetName }}</p>
      </div>

      <div class="bottom-row" v-if="oxygen > 0 || armor > 0">
        <div class="kevlardiv" v-if="armor > 0">
          <Icon class="kevlaricon" icon="game-icons:kevlar-vest" :style="{ color: makenumbertocolor(armor) }"
            width="1rem" height="1rem" />
          <p class="icontextbottomright kevlartext">{{ armor }}</p>
        </div>
        <div class="oxygendiv" v-if="oxygen > 0">
          <Icon class="oxygenicon" icon="healthicons:oxygen-tank-outline" :style="{ color: makenumbertocolor(oxygen) }"
            width="1rem" height="1rem" />
          <p class="icontextbottomleft oxygentext">{{ oxygen }}</p>
        </div>
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

.bottom-row {
  position: relative;
  display: flex;
  justify-content: center;
  /* Center the items horizontally */
  align-items: flex-end;
  /* Align items to the bottom */
  margin-bottom: 5%;
}

.oxygendiv,
.kevlardiv {
  display: flex;
  align-items: center;
  position: relative;
}

.oxygendiv {
  left: 50%;
  /* Initially place oxygen in the middle */
}

.kevlardiv {
  right: 50%;
  /* Initially place kevlar in the middle */
}

.icontextbottomleft,
.icontextbottomright {
  margin: 0 0.5rem;
  /* Adjust the margin between the icon and text */
}
.idd {
  position: absolute;
  top: 5px;
  right: 15px;
  font-size: 13px;
}

.icontext {
  width: 100%;
  text-align: center;
  color: #fffafa;
}

.icons {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.top-icons {
  display: flex;
  justify-content: space-around;
  align-items: flex-start;
}


.streetnamediv {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
}

.icon-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin: 10px;
}

.street-name {
  font-size: 18px;
  color: #fffafa;
}

.time {
  font-size: 30px;
  font-weight: bold;
  text-align: center;
}
</style>