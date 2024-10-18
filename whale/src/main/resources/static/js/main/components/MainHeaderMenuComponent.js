const MainHeaderMenuComponent = {
	template: `
		<Transition name="menuTransition">
			<div class="headerMenu-wrap" v-if="headerMenuCheck[0]" @click="closeMenu()">
				<div class="headerMenu-containers" @click.stop="">
					<div class="headerMenu-container" id="headerMenu-alarm" v-if="headerMenuCheck[1]">
						<div class="header-contents flexCenter"><p class="header-alarm-content">메시지</p></div>
						<div class="header-contents flexCenter"><p class="header-alarm-content">좋아요</p></div>
						<div class="header-contents flexCenter"><p class="header-alarm-content">댓글</p></div>
					</div>
					<div class="headerMenu-container" id="headerMenu-profile" v-if="headerMenuCheck[2]">
						<div class="header-contents flexCenter"><p class="header-profile-content">마이페이지</p></div>
						<div class="header-contents flexCenter" @click="redirectIframe(5)"><p class="header-profile-content">설정</p></div>
						<div class="header-contents flexCenter" style="border: none;"><p class="header-profile-content">로그아웃</p></div>
					</div>
				</div>
	    	</div>
    	</Transition>
	`,
	props: {
		headerMenuCheck: Array,
	},
	data() {
		return {
		};
	},
	methods: {
		closeMenu() {this.$emit('header-close-menu');},
		redirectIframe(i) {this.$emit('menu-redirect-iframe',i);},
	},
};

export default MainHeaderMenuComponent;