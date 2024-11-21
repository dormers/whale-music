<template>
    <div class="header">
        <button class="prvBtn">
            <img src="../../../public/images/main/backIcon.png" alt="Music Whale Search Button" height="20px" @click="goMain()">
        </button>
        <div class="headerItems">
            <button class="homeBtn">
                <img src="../../../public/images/main/homeBtn.png" alt="Music Whale Search Button" height="20px" @click="goMain()">
            </button>
            <div class="headerSearch">
                <button class="searchBtn" @click="goSearch()">
                    <img src="../../../public/images/main/searchBtn.png" alt="Music Whale Search Button" height="14px">
                </button>
                <input class="headerInput" placeholder="어떤 콘텐츠를 감상하고 싶으세요?" onfocus="this.placeholder=''" onblur="this.placeholder='어떤 콘텐츠를 감상하고 싶으세요?'" v-model="this.query">
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            query: null,
        };
    },
    mounted() {
        this.checkEnter();
    },
    methods: {
        goMain() {this.$router.push('/whale/streaming/recommend'); this.changeBackground();},
        // goSearchHome() {this.$router.push(`/whale/streaming/searchHome`); this.changeBackground();},
        goSearch() {this.$router.push(`/whale/streaming/search/${ this.query }`); this.changeBackground();},
        changeBackground() {
            document.querySelector('.mainContent').style.backgroundImage = '';
            if (localStorage.getItem('darkmodeOn') === "1") {document.querySelector('.mainContent').style.backgroundColor = '#2e2e2e';}
            else {document.querySelector('.mainContent').style.backgroundColor = '#fff';}
        },
        // 엔터 키 입력 시 검색 실행
        checkEnter() {
            const headerInput = document.querySelector('.headerInput');

            headerInput.addEventListener("keypress", (event) => {
                if (event.key === "Enter") {  // Enter 키 확인
                    this.goSearch();
                }
            });
        },
        backRouter() {this.$router.go(-1)},
    },
};
</script>

<style scoped>
    .header {position: relative; display: flex; justify-content: center; align-items: center; width: 100%; height: 58px; background-color: #1f1f1f; border-bottom: 1.5px solid #2e2e2e;}
    #app.light .header {background-color: #f0f0f0; border-bottom: 1.5px solid #ccc;}
    .headerItems {display: flex; justify-content: center; align-items: center; width: 300px; height: 100%;}
    #app.light .headerItems {filter: invert(1);}
    .prvBtn {position: absolute; top: 22px; left: 25px; border-radius: 50%; background-color: transparent; border: none; opacity: 0.3;}
    .prvBtn:hover {opacity: 0.2;}
    .prvBtn:active {opacity: 0.1;}
    #app.light .prvBtn {filter: invert(1);}
    .homeBtn {margin-right: 13px; background-color: transparent; border: none; opacity: 0.44;}
    .homeBtn:hover {opacity: 0.3;}
    .homeBtn:active {opacity: 0.1;}
    .headerSearch {display: flex; justify-content: center; align-items: center; width: 100%; height: 60%; border: 1.6px solid #3c3c3c; border-radius: 18px;}
    #app.light .headerSearch {border: 1.6px solid rgba(204,204,204,0.2);}
    .searchBtn {margin-top: 2.5px; background-color: transparent; border: none; opacity: 0.7;}
    .searchBtn:hover {opacity: 0.4;}
    .searchBtn:active {opacity: 0.2;}
    .headerInput {width: 80%; height: 56%; background: transparent; border: none; outline: none; font-size: 13px; color: rgb(164, 164, 164); text-align: center; cursor: grab;}
</style>