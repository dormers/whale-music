(function(){"use strict";var e={87:function(e,t,a){var n=a(5130),r=a(6768);function s(e,t,a,n,s,i){const o=(0,r.g2)("MainHeader"),c=(0,r.g2)("MainCenter");return(0,r.uX)(),(0,r.CE)(r.FK,null,[(0,r.bF)(o),(0,r.bF)(c)],64)}var i=a.p+"img/homeBtn.1ab163d5.png",o=a.p+"img/searchBtn.9e724fd8.png";const c={class:"header"},l={class:"headerItems"},d={class:"homeBtn"},u={class:"headerSearch"};function h(e,t,a,s,h,m){return(0,r.uX)(),(0,r.CE)("div",c,[(0,r.Lk)("div",l,[(0,r.Lk)("button",d,[(0,r.Lk)("img",{src:i,alt:"Music Whale Search Button",height:"20px",onClick:t[0]||(t[0]=e=>m.goMain())})]),(0,r.Lk)("div",u,[(0,r.Lk)("button",{class:"searchBtn",onClick:t[1]||(t[1]=e=>m.goSearch())},t[4]||(t[4]=[(0,r.Lk)("img",{src:o,alt:"Music Whale Search Button",height:"14px"},null,-1)])),(0,r.bo)((0,r.Lk)("input",{class:"headerInput",placeholder:"어떤 콘텐츠를 감상하고 싶으세요?",onfocus:"this.placeholder=''",onblur:"this.placeholder='어떤 콘텐츠를 감상하고 싶으세요?'","onUpdate:modelValue":t[2]||(t[2]=e=>this.query=e),onClick:t[3]||(t[3]=e=>m.goSearchHome())},null,512),[[n.Jo,this.query]])])])])}var m={data(){return{query:null}},methods:{goMain(){this.$router.replace("/whale/streaming/recommend"),this.changeBackground()},goSearchHome(){this.$router.replace("/whale/streaming/searchHome"),this.changeBackground()},goSearch(){this.$router.replace(`/whale/streaming/search/${this.query}`),this.changeBackground()},changeBackground(){document.querySelector(".mainContent").style.backgroundImage="",document.querySelector(".mainContent").style.backgroundColor="#2e2e2e"}}},p=a(1241);const g=(0,p.A)(m,[["render",h],["__scopeId","data-v-75bf407d"]]);var v=g;const y={class:"main"};function k(e,t,a,n,s,i){const o=(0,r.g2)("MainLibrary"),c=(0,r.g2)("MainContent"),l=(0,r.g2)("MainDetail");return(0,r.uX)(),(0,r.CE)(r.FK,null,[(0,r.Lk)("div",y,[(0,r.bF)(o),(0,r.bF)(c),(0,r.bF)(l)]),t[0]||(t[0]=(0,r.Lk)("div",{class:"footer"},null,-1))],64)}var f=a(4232);const L={class:"mainLibrary"},C={class:"playlist-container"},b=["onClick"],w={class:"playlistCover"},E=["src","alt"];function S(e,t,a,n,s,i){return(0,r.uX)(),(0,r.CE)("div",{class:(0,f.C4)(["mainLibraryFrame",{expanded:s.isExpanded}])},[(0,r.Lk)("div",L,[s.isExpanded?(0,r.Q3)("",!0):((0,r.uX)(),(0,r.CE)("svg",{key:0,"data-encore-id":"icon",role:"img","aria-hidden":"true",viewBox:"0 0 24 24",class:"libraryBtn",onClick:t[0]||(t[0]=e=>i.expandLibrary())},t[2]||(t[2]=[(0,r.Lk)("path",{d:"M14.5 2.134a1 1 0 0 1 1 0l6 3.464a1 1 0 0 1 .5.866V21a1 1 0 0 1-1 1h-6a1 1 0 0 1-1-1V3a1 1 0 0 1 .5-.866zM16 4.732V20h4V7.041l-4-2.309zM3 22a1 1 0 0 1-1-1V3a1 1 0 0 1 2 0v18a1 1 0 0 1-1 1zm6 0a1 1 0 0 1-1-1V3a1 1 0 0 1 2 0v18a1 1 0 0 1-1 1z"},null,-1)]))),s.isExpanded?((0,r.uX)(),(0,r.CE)("svg",{key:1,"data-encore-id":"icon",role:"img","aria-hidden":"true",viewBox:"0 0 24 24",class:"libraryBtn",onClick:t[1]||(t[1]=e=>i.expandLibrary())},t[3]||(t[3]=[(0,r.Lk)("path",{d:"M3 22a1 1 0 0 1-1-1V3a1 1 0 0 1 2 0v18a1 1 0 0 1-1 1zM15.5 2.134A1 1 0 0 0 14 3v18a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V6.464a1 1 0 0 0-.5-.866l-6-3.464zM9 2a1 1 0 0 0-1 1v18a1 1 0 1 0 2 0V3a1 1 0 0 0-1-1z"},null,-1)]))):(0,r.Q3)("",!0),(0,r.Lk)("div",C,[((0,r.uX)(!0),(0,r.CE)(r.FK,null,(0,r.pI)(s.libraries,((e,t)=>((0,r.uX)(),(0,r.CE)("div",{class:"playlist-content",key:t,onClick:t=>i.redirectPlaylist(e.id)},[(0,r.Lk)("div",w,[(0,r.Lk)("img",{src:e.images[0].url,alt:e.name,width:"45",height:"45",style:{"border-radius":"2px",opacity:"0.8"}},null,8,E)])],8,b)))),128))])])],2)}var x={data(){return{isExpanded:!1,libraries:null,isShow:[]}},mounted(){this.getUserLibraries()},methods:{expandLibrary(){this.isExpanded=!this.isExpanded},async getUserLibraries(){const e=await fetch("/whale/streaming/getLibraries");if(await e.ok){const t=await e.json();t.items&&t.items.length>0?this.libraries=t.items:console.error("No items found")}else console.error("Failed to fetch user top items:",e.statusText)},redirectPlaylist(e){this.$router.replace(`/whale/streaming/playlist/${e}`)}}};const T=(0,p.A)(x,[["render",S],["__scopeId","data-v-20437102"]]);var M=T;const A={class:"mainContentFrame"},$={class:"mainContent"},_={class:"mainContentMargin"};function I(e,t,a,n,s,i){const o=(0,r.g2)("router-view");return(0,r.uX)(),(0,r.CE)("div",A,[(0,r.Lk)("div",$,[(0,r.Lk)("div",_,[((0,r.uX)(),(0,r.Wv)(o,{key:e.$route.fullPath}))])])])}var F={components:{},mounted(){},methods:{}};const P=(0,p.A)(F,[["render",I],["__scopeId","data-v-308ef4f9"]]);var B=P;const X={class:"mainDetailFrame"};function j(e,t,a,n,s,i){return(0,r.uX)(),(0,r.CE)("div",X)}var D={};const O=(0,p.A)(D,[["render",j],["__scopeId","data-v-7b2ebe09"]]);var q=O,z={components:{MainLibrary:M,MainContent:B,MainDetail:q}};const H=(0,p.A)(z,[["render",k],["__scopeId","data-v-83476546"]]);var N=H,V={components:{MainHeader:v,MainCenter:N},data(){return{}},mounted(){this.executeResize(),this.receiveMessageMain(),this.checktype()},methods:{executeResize(){document.addEventListener("DOMContentLoaded",this.resize),window.addEventListener("resize",this.resize)},resize(){const e=document.querySelector(".mainLibraryFrame"),t=document.querySelector(".mainDetailFrame"),a=document.querySelector(".header"),n=document.querySelector(".footer"),r=document.querySelector(".main"),s=document.querySelector(".mainContentFrame"),i=window.innerWidth,o=e?e.offsetWidth:0,c=t?t.offsetWidth:0,l=window.innerHeight,d=a?a.offsetHeight:0,u=n?n.offsetHeight:0;if(r&&(r.style.height=l-d-u+"px"),s){const e=i-o-c;s.style.width=e>200?`${e}px`:"200px"}},receiveMessageMain(){window.addEventListener("message",this.receiveMessage,!1)},async receiveMessage(e){"Full"===e.data?console.log(e.data):"albumDetail"===e.data?this.$router.replace("/whale/streaming/detail/album"):"artistDetail"===e.data?this.$router.replace("/whale/streaming/detail/artist"):"current"===e.data?this.$router.replace("/whale/streaming/current-playlist"):await this.sendDeviceId(e)},async sendDeviceId(e){sessionStorage.device_id=e.data;const t={device_id:sessionStorage.device_id};fetch("/whale/streaming/getDeviceId",{headers:{Accept:"application/json","Content-Type":"application/json"},method:"POST",body:JSON.stringify(t)}).then((e=>e.json())).then((e=>{sessionStorage.accessToken=e.accessToken,console.log("Success fetching device id to the Node js Wep App")})).catch((e=>console.error("Failed to fetch the device_id: ",e)))},checktype(){let e;fetch("/whale/streaming/getType",{headers:{Accept:"application/json","Content-Type":"application/json"},method:"GET"}).then((e=>e.json())).then((t=>{e=t.type,"album"===e?this.$router.replace("/whale/streaming/detail/album"):"artist"===e?this.$router.replace("/whale/streaming/detail/artist"):"current"===e?this.$router.replace("/whale/streaming/current-playlist"):this.$router.replace("/whale/streaming/recommend")}))}}};const U=(0,p.A)(V,[["render",s]]);var W=U,K=a(1387),R=a.p+"img/like.3340caa3.png";const J={class:"recommendations"},Q={class:"recommendationContents"},G=["onMouseover","onMouseleave"],Y=["onClick"],Z={class:"recommendationCover"},ee=["src","alt"],te={class:"recommendationInfo"},ae={class:"trackName"},ne={class:"artistName"};function re(e,t,a,n,s,i){return(0,r.uX)(),(0,r.CE)(r.FK,null,[t[2]||(t[2]=(0,r.Lk)("div",{class:"recommendationsHeader"},null,-1)),(0,r.Lk)("div",J,[t[1]||(t[1]=(0,r.Lk)("div",{class:"recommendationTitle"},[(0,r.Lk)("p",{class:"titleName"},"내가 즐겨 듣는 노래")],-1)),(0,r.Lk)("div",Q,[((0,r.uX)(!0),(0,r.CE)(r.FK,null,(0,r.pI)(s.recommendations,((e,a)=>((0,r.uX)(),(0,r.CE)("div",{class:"recommendationContent",key:a,onMouseover:e=>s.isShow[a]=!0,onMouseleave:e=>s.isShow[a]=!1},[i.addIsShow(a)?((0,r.uX)(),(0,r.CE)("div",{key:0,class:"recommendationLike",onClick:e=>i.insertTrack(a)},t[0]||(t[0]=[(0,r.Lk)("img",{src:R,alt:"Like Button",width:"30",height:"30",style:{"border-radius":"8px",opacity:"0.75"}},null,-1)]),8,Y)):(0,r.Q3)("",!0),(0,r.Lk)("div",Z,[(0,r.Lk)("img",{src:e.album.images[0].url,alt:e.name,width:"120",height:"120",style:{"border-radius":"8px"}},null,8,ee)]),(0,r.Lk)("div",te,[(0,r.Lk)("p",ae,(0,f.v_)(e.name),1),(0,r.Lk)("p",ne,(0,f.v_)(e.artists[0].name),1)])],40,G)))),128))])])],64)}a(4114);var se={data(){return{recommendations:null,isShow:[]}},mounted(){this.getUserTopItems()},methods:{async getUserTopItems(){const e=await fetch("/whale/streaming/getContents");if(await e.ok){const t=await e.json();t.items&&t.items.length>0?this.recommendations=t.items:console.error("No items found")}else console.error("Failed to fetch user top items:",e.statusText)},async insertTrack(e){try{const t={trackArtist:this.recommendations[e].artists[0].name,trackName:this.recommendations[e].name,trackAlbum:this.recommendations[e].album.name,trackCover:this.recommendations[e].album.images[0].url,trackSpotifyId:this.recommendations[e].id},a=await fetch("http://localhost:9002/whale/streaming/insertTrack",{headers:{Accept:"application/json","Content-Type":"application/json"},method:"POST",body:JSON.stringify(t)});a.ok?console.log("Success fetching Data to the Spring Wep App"):console.error("Failed to fetch the track info: ",a.statusText)}catch(t){console.error("Error while fetching the track info:",t)}},addIsShow(e){return this.isShow.push(!1),this.isShow[e]}}};const ie=(0,p.A)(se,[["render",re],["__scopeId","data-v-5226de9d"]]);var oe=ie;const ce={class:"search-container"};function le(e,t,a,n,s,i){return(0,r.uX)(),(0,r.CE)("div",ce,t[0]||(t[0]=[(0,r.Lk)("h1",null,"Search Home",-1)]))}var de={data(){return{}},mounted(){},methods:{}};const ue=(0,p.A)(de,[["render",le]]);var he=ue;const me={class:"search-container"};function pe(e,t,a,n,s,i){return(0,r.uX)(),(0,r.CE)("div",me,t[0]||(t[0]=[(0,r.Lk)("div",{id:"pagination"},null,-1),(0,r.Lk)("div",{id:"search-results"},null,-1)]))}var ge={data(){return{currentPage:1,itemsPerPage:10}},mounted(){this.$route.params.query&&(this.currentPage=1,this.searchTracks(this.$route.params.query,this.currentPage))},methods:{searchTracks(e,t=1){const a=(t-1)*this.itemsPerPage;fetch(`https://api.spotify.com/v1/search?q=${encodeURIComponent(e)}&type=track&limit=${this.itemsPerPage}&offset=${a}`,{headers:{Authorization:`Bearer ${sessionStorage.accessToken}`}}).then((e=>e.json())).then((a=>{this.displaySearchResults(a.tracks.items),this.setupPagination(a.tracks.total,t,e)})).catch((e=>console.error("검색 에러:",e)))},setupPagination(e,t,a){const n=document.getElementById("pagination");n.innerHTML="";const r=Math.ceil(e/this.itemsPerPage);if(t>1){const e=document.createElement("button");e.innerText="이전",e.addEventListener("click",(()=>{this.searchTracks(a,t-1)})),n.appendChild(e)}const s=document.createElement("span");if(s.innerText=`페이지 ${t} / ${r}`,n.appendChild(s),t<r){const e=document.createElement("button");e.innerText="다음",e.addEventListener("click",(()=>{this.searchTracks(a,t+1)})),n.appendChild(e)}},displaySearchResults(e){const t=document.getElementById("search-results");t.innerHTML="",e.forEach((e=>{const a=document.createElement("div");a.classList.add("track-item");const n=document.createElement("img");n.src=e.album.images[0]?e.album.images[0].url:"";const r=document.createElement("div");r.classList.add("track-details");const s=document.createElement("div");s.innerText=e.name;const i=document.createElement("div");i.innerText=e.artists.map((e=>e.name)).join(", "),i.classList.add("artist-name"),r.appendChild(s),r.appendChild(i);const o=document.createElement("button");o.addEventListener("click",(()=>{this.playTrack(sessionStorage.device_id,e.uri)})),a.appendChild(n),a.appendChild(r),a.appendChild(o),t.appendChild(a)}))},playTrack(e,t){fetch(`https://api.spotify.com/v1/me/player/play?device_id=${e}`,{method:"PUT",body:JSON.stringify({uris:[t]}),headers:{"Content-Type":"application/json",Authorization:`Bearer ${sessionStorage.accessToken}`}}).then((()=>{console.log("재생 시작:",t)})).catch((e=>console.error("재생 에러:",e)))}}};const ve=(0,p.A)(ge,[["render",pe]]);var ye=ve;const ke={class:"detail-container"};function fe(e,t,a,n,s,i){return(0,r.uX)(),(0,r.CE)("div",ke,t[0]||(t[0]=[(0,r.Lk)("h1",null,"Artist Detail",-1)]))}var Le={data(){return{}},mounted(){},methods:{}};const Ce=(0,p.A)(Le,[["render",fe]]);var be=Ce;const we={class:"detail-container"};function Ee(e,t,a,n,s,i){return(0,r.uX)(),(0,r.CE)("div",we,t[0]||(t[0]=[(0,r.Lk)("h1",null,"Album Detail",-1)]))}var Se={data(){return{}},mounted(){},methods:{}};const xe=(0,p.A)(Se,[["render",Ee]]);var Te=xe;const Me={class:"playlistDetail"},Ae={key:0,class:"playlistDetailContainer"},$e=["src","alt"],_e={class:"playlistDetailInfo"},Ie={class:"playlistName"},Fe={class:"playlistDesc"},Pe={class:"playlistOpt"};function Be(e,t,a,n,s,i){return(0,r.uX)(),(0,r.CE)(r.FK,null,[(0,r.Lk)("div",Me,[null!==s.playlist?((0,r.uX)(),(0,r.CE)("div",Ae,[(0,r.Lk)("img",{src:s.playlist.images[0].url,alt:s.playlist.name,width:"170",height:"170",style:{"border-radius":"8px"}},null,8,$e),(0,r.Lk)("div",_e,[t[0]||(t[0]=(0,r.Lk)("p",{class:"detailSort"},"플레이리스트",-1)),(0,r.Lk)("p",Ie,(0,f.v_)(s.playlist.name),1),(0,r.Lk)("p",Fe,(0,f.v_)(s.playlist.description),1),(0,r.Lk)("p",Pe,"WHALE • "+(0,f.v_)(s.playlist.tracks.total)+"곡",1)])])):(0,r.Q3)("",!0)]),t[1]||(t[1]=(0,r.Lk)("div",{class:"playlistFunction"},[(0,r.Lk)("div",{class:"playlistBtnCircle"},[(0,r.Lk)("svg",{"data-encore-id":"icon",role:"img","aria-hidden":"true",viewBox:"0 0 24 24",class:"playlistBtn"},[(0,r.Lk)("path",{d:"m7.05 3.606 13.49 7.788a.7.7 0 0 1 0 1.212L7.05 20.394A.7.7 0 0 1 6 19.788V4.212a.7.7 0 0 1 1.05-.606z"})])])],-1))],64)}var Xe={data(){return{playlist:null}},mounted(){this.getUserPlaylists(),this.changeBackground()},methods:{async getUserPlaylists(){const e=await fetch(`/whale/streaming/getPlaylist?id=${this.$route.params.id}`);if(await e.ok){const t=await e.json();t&&t.tracks.items.length>0?(this.playlist=t,console.log("Complete: ",this.playlist)):console.error("No items found")}else console.error("Failed to fetch user top items:",e.statusText)},changeBackground(){document.querySelector(".mainContent").style.backgroundImage="linear-gradient(to bottom, rgb(206, 116, 144), rgb(17, 18, 17))"}}};const je=(0,p.A)(Xe,[["render",Be],["__scopeId","data-v-540e6ff8"]]);var De=je;const Oe={class:"current-playlist-container"};function qe(e,t,a,n,s,i){return(0,r.uX)(),(0,r.CE)("div",Oe,t[0]||(t[0]=[(0,r.Lk)("h1",null,"Current Playlist Detail",-1)]))}var ze={data(){return{}},mounted(){},methods:{}};const He=(0,p.A)(ze,[["render",qe]]);var Ne=He;const Ve=[{path:"/whale/streaming/recommend",component:oe},{path:"/whale/streaming/searchHome",component:he},{path:"/whale/streaming/search/:query",component:ye},{path:"/whale/streaming/detail/artist",component:be},{path:"/whale/streaming/detail/album",component:Te},{path:"/whale/streaming/playlist/:id",component:De},{path:"/whale/streaming/current-playlist",component:Ne}],Ue=(0,K.aE)({history:(0,K.sC)(),routes:Ve});var We=Ue;(0,n.Ef)(W).use(We).mount("#app")}},t={};function a(n){var r=t[n];if(void 0!==r)return r.exports;var s=t[n]={exports:{}};return e[n].call(s.exports,s,s.exports,a),s.exports}a.m=e,function(){var e=[];a.O=function(t,n,r,s){if(!n){var i=1/0;for(d=0;d<e.length;d++){n=e[d][0],r=e[d][1],s=e[d][2];for(var o=!0,c=0;c<n.length;c++)(!1&s||i>=s)&&Object.keys(a.O).every((function(e){return a.O[e](n[c])}))?n.splice(c--,1):(o=!1,s<i&&(i=s));if(o){e.splice(d--,1);var l=r();void 0!==l&&(t=l)}}return t}s=s||0;for(var d=e.length;d>0&&e[d-1][2]>s;d--)e[d]=e[d-1];e[d]=[n,r,s]}}(),function(){a.n=function(e){var t=e&&e.__esModule?function(){return e["default"]}:function(){return e};return a.d(t,{a:t}),t}}(),function(){a.d=function(e,t){for(var n in t)a.o(t,n)&&!a.o(e,n)&&Object.defineProperty(e,n,{enumerable:!0,get:t[n]})}}(),function(){a.g=function(){if("object"===typeof globalThis)return globalThis;try{return this||new Function("return this")()}catch(e){if("object"===typeof window)return window}}()}(),function(){a.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)}}(),function(){a.p="/"}(),function(){var e={524:0};a.O.j=function(t){return 0===e[t]};var t=function(t,n){var r,s,i=n[0],o=n[1],c=n[2],l=0;if(i.some((function(t){return 0!==e[t]}))){for(r in o)a.o(o,r)&&(a.m[r]=o[r]);if(c)var d=c(a)}for(t&&t(n);l<i.length;l++)s=i[l],a.o(e,s)&&e[s]&&e[s][0](),e[s]=0;return a.O(d)},n=self["webpackChunkclient"]=self["webpackChunkclient"]||[];n.forEach(t.bind(null,0)),n.push=t.bind(null,n.push.bind(n))}();var n=a.O(void 0,[504],(function(){return a(87)}));n=a.O(n)})();
//# sourceMappingURL=app.15d47141.js.map