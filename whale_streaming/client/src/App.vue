<template>
  <MainHeader />
  <MainCenter />
</template>

<script>
import MainHeader from './components/main/MainHeader.vue'
import MainCenter from './components/main/MainCenter.vue'

export default {
  components: {
    MainHeader,
    MainCenter,
  },
  methods: {
  },
};
</script>

<style>
  * {margin: 0; padding: 0; box-sizing: 0;}
  body {min-height: 100vh; -ms-overflow-style: none;}
  ::-webkit-scrollbar {display: none;}
</style>