<template>
    <div class="main">
        <MainLibrary :libraries="libraries" />
        <div class="mainContentFrame">
            <div class="mainContent">
                <div class="mainContentMargin">
                    <router-view :key="$route.fullPath" :libraries="libraries" @update-library="getUserLibraries"></router-view>
                </div>
            </div>
        </div>
        <div class="mainDetailFrame"></div>
    </div>
    <div class="footer"></div>
</template>

<script>
import MainLibrary from './MainLibrary.vue'

export default {
    components: {
        MainLibrary,
    },
    data() {
        return {
            libraries: null,
        };
    },
    mounted() {
        this.getUserLibraries();
    },
    methods: {
        async getUserLibraries() {
            const result = await fetch('/whale/streaming/getLibraries');
            if (await result.ok) {
                const data = await result.json();
                if (data.items && data.items.length > 0) {
                    this.libraries = data.items;
                } else {
                    console.error('No items found');
                }
            } else {
                console.error('Failed to fetch user top items:', result.statusText);
            }
        },
    },
};
</script>

<style scoped>
    .main {display: flex; width: 100%; background-color: #1f1f1f;}
    #app.light .main {background-color: #f0f0f0;}
    .footer {width: 100%; height: 10px; background-color: #1f1f1f;}
    #app.light .footer {background-color: #eeeeee;}
    .mainContentFrame {display: flex; justify-content: center; align-items: center; min-width: 200px; height: 100%;}
    .mainContent {width: 100%; height: 96%; background-color: #2e2e2e; border-radius: 16px; overflow: auto; -ms-overflow-style: none;}
    #app.light .mainContent {background-color: #fff; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);}
    .mainContentMargin {margin: 0 10px 0 10px; width: 96%; height: 100%;}
    #app.light .mainContentMargin {color: #111;}
    .mainDetailFrame {display: flex; justify-content: center; align-items: center; width: 2%; height: 100%;}
</style>