
<script setup>
window.addEventListener('message', (event) => {

    if (event.data.type === "update") {
        handleData(event)
    }
});
function handleData(){

}
</script>
<template>
    <div class="background">

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
</style>

<!-- hello how are you -->

