<script setup>
  import { RouterLink, RouterView, useRouter } from 'vue-router'
    import axios from 'axios';
</script>

<template>
 
  <div class="hud" :style="{ top: hudTop, left: hudLeft }" 
       @mousedown="startDrag" @mouseup="stopDrag" @mousemove="onDrag">
     <div class="relative mx-auto bg-gray-800 dark:bg-gray-700 rounded-t-[2.5rem] h-[63px] max-w-[133px]"></div>
<div class="relative mx-auto border-gray-900 dark:bg-gray-800 dark:border-gray-800 border-[10px] rounded-[2.5rem] h-[213px] w-[208px]">
    <div class="h-[41px] w-[6px] bg-gray-800 dark:bg-gray-800 absolute -right-[16px] top-[40px] rounded-r-lg"></div>
    <div class="h-[32px] w-[6px] bg-gray-800 dark:bg-gray-800 absolute -right-[16px] top-[88px] rounded-r-lg"></div>
    <div class="rounded-[2rem] overflow-hidden h-[193px] w-[188px]">
     <RouterView/>
    </div>
</div>
<div class="relative mx-auto bg-gray-800 dark:bg-gray-700 rounded-b-[2.5rem] h-[63px] max-w-[133px]"></div>
  </div>
</template>
<style>
.hud {
  position: fixed;
  top: 0;
  left: 0;
  z-index: 9999;
}
.hud.draggable {
  pointer-events: auto;
}
.hud.not-draggable {
  pointer-events: none;
}
</style>
<script>
export default {
  props: {
    draggable: Boolean
  },
  data() {
    return {
      dragging: false,
      startX: 0,
      startY: 0,
      hudTop: '0px',
      hudLeft: '0px'
    };
  },
  mounted() {
    this.loadPosition();
  },
  methods: {
    startDrag(event) {
      if (!this.draggable) return;
      this.dragging = true;
      this.startX = event.clientX - this.$el.offsetLeft;
      this.startY = event.clientY - this.$el.offsetTop;
    },
    stopDrag() {
      if (!this.dragging) return;
      this.dragging = false;
      localStorage.setItem('hudPosition', JSON.stringify({ top: this.hudTop, left: this.hudLeft }));
    },
    onDrag(event) {
      if (!this.dragging || !this.draggable) return;
      this.hudTop = `${event.clientY - this.startY}px`;
      this.hudLeft = `${event.clientX - this.startX}px`;
    },
    loadPosition() {
      const savedPosition = JSON.parse(localStorage.getItem('hudPosition'));
      if (savedPosition) {
        this.hudTop = savedPosition.top;
        this.hudLeft = savedPosition.left;
      }
    }
  }
}


</script>