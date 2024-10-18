<template>
    <div class="mainContentFrame">
        <div class="mainContent">
            <div class="mainContentMargin">
                <router-view></router-view>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    components: {
    },
    mounted() {
        this.$router.replace('/whale/streaming/recommend');
    },
    methods: {
    },
};
</script>

<style scoped>
    .mainContentFrame {display: flex; justify-content: center; align-items: center; height: 100%;}
    .mainContent {width: 100%; height: 96%; background-color: #2e2e2e; border-radius: 16px;}
    .mainContentMargin {margin: 0 10px 0 10px; width: 96%; height: 100%;}
</style>