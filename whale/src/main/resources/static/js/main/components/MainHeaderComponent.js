const MainHeaderComponent = {
	template: `
		<div class="header">
	        <div class="headerItems flexCenter">
	        	<div id="adminRedirect" v-if="isAdmin === '1'" @click="redirectAdmin()"><img src="static/images/main/adminIcon.png" alt="Admin Img" width="45px" height="45px"></div>
	        </div>
	        <div class="headerItems flexCenter" id="headerLogo" @click="goMain()">
	            <img src="static/images/main/whaleLogo.png" alt="Music Whale Logo" height="80px">
	        </div>
	        <div class="headerItems" id="headerContents">
	            <div class="flexCenter" id="headerAlarm" :style="{backgroundColor: headerMenuCheck[1] ? '#efefef' : '#FCFCFC'}" @click="alarmCheck()">
	                <img src="static/images/main/bellEmpty.png" alt="Alarm" height="33px" style="opacity: 0.5;">
	            </div>
	            <div class="flexCenter" id="headerProfile" :style="{backgroundColor: headerMenuCheck[2] ? '#efefef' : '#FCFCFC'}" @click="profileCheck()">
	                <div class="flexCenter" id="profile">
	                	<img :src="profileImg" alt="Profile Image" width="100%" height="100%" style="border-radius: 50%; opacity: 0.8;">
	                </div>
	            </div>
	            <div id="headerMargin"></div>
	        </div>
	    </div>
	`,
	props: {
		headerMenuCheck: Array,
	},
	data() {
		return {
			isAdmin: sessionStorage.access_id,
			profileImg: 'static/images/setting/pro.png',
		};
	},
	methods: {
		goMain() {location.replace('main');},
		alarmCheck() {this.$emit('header-alarm-toggle', 1);},
		profileCheck() {this.$emit('header-profile-toggle', 2);},
		redirectAdmin() {location.href='adminMainView';},
	},
};

export default MainHeaderComponent;