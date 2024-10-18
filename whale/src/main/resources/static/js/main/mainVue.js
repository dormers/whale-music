import { createApp } from 'https://unpkg.com/vue@3/dist/vue.esm-browser.js';
import MainHeaderComponent from './components/MainHeaderComponent.js';
import MainHeaderMenuComponent from './components/MainHeaderMenuComponent.js';
import MainCenterComponent from './components/MainCenterComponent.js';
import MainFooterComponent from './components/MainFooterComponent.js';

const app = createApp({
	data() {
		return {
			headerMenuCheck: [false, false, false],
			frameNames: ['leftIframe','rightIframe'],
			whaleAddress: ['communityHome','streaming','https://open.spotify.com/embed/playlist/37i9dQZF1E4xGcU10nFpkR?utm_source=generator','message/home','feedHome','settingHome'],
		}
	},
	mounted() {
		this.executeResize();
	},
	methods: {
		// [ Resize ]
		executeResize() {$(document).ready(() => {this.resize();}); $(window).resize(() => {this.resize();});},
		resize() {var windowHeight = $(window).height(); var headerHeight = $(".header").height(); var footerHeight = $(".footer").height()+$(".footerMargin").height(); $('.main').css({'height': (windowHeight-headerHeight-footerHeight-1)+'px'});},
		
		// [ iframe ]
		fetchIframe(whichIframe,data) {try {document.querySelector('#'+whichIframe).contentWindow.postMessage(data,'https://localhost:5500');} catch (error) {}},
		
		// [ Props ]
		async fetchWebApi(endpoint, method, body) {const res = await fetch(`https://api.spotify.com/${endpoint}`, {headers: {Authorization: `Bearer ${sessionStorage.accessToken}`,},method,body: JSON.stringify(body)}); return res.json();},
		
		// [ Main Header ]
		menuCheck(i) {if (this.headerMenuCheck[0] === true && this.headerMenuCheck[i] === false) {this.closeMenu();} this.headerMenuCheck[0] = !this.headerMenuCheck[0]; this.headerMenuCheck[i] = !this.headerMenuCheck[i];},
		closeMenu() {this.headerMenuCheck.forEach((element, index) => {if (element === true) {this.headerMenuCheck[index] = false;}})},
		
		// [ Main Header Menu ]
		changeRedirectIndex(i) {this.replaceIframe(1,i); this.closeMenu();},
		
		// [ Main Center ]
		replaceIframe(i,j) {$("#"+this.frameNames[i]).get(0).contentWindow.location.replace(this.whaleAddress[j]); if (j === 0) {setTimeout(() => {this.fetchIframe(this.frameNames[i],sessionStorage.device_id);}, 1000);}},
	},
});

app.component("MainHeaderComponent",MainHeaderComponent);
app.component("MainHeaderMenuComponent",MainHeaderMenuComponent);
app.component("MainCenterComponent",MainCenterComponent);
app.component("MainFooterComponent",MainFooterComponent);

app.mount('#main');