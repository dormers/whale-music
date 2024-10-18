<template>
    <div class="main">
        <MainLibrary />
        <MainContent />
        <MainDetail />
    </div>
    <div class="footer"></div>
</template>

<script>
import MainLibrary from './MainLibrary.vue'
import MainContent from './MainContent.vue'
import MainDetail from './MainDetail.vue'

export default {
    components: {
        MainLibrary,
        MainContent,
        MainDetail,
    },
};
</script>

<style scoped>
    .main {display: flex; width: 100%; background-color: #1f1f1f;}
    .footer {width: 100%; height: 10px; background-color: #1f1f1f;}
</style>