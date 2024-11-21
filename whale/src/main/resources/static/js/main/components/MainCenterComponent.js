const MainCenterComponent = {
	template: `
		<div class="mainItems flexCenter" v-for="(menuBtnTrigger, i) in menuBtnTriggers" :key="i">
			<div class="frame" v-if="(i === 0) || (i === 1 && isOver === true)">
				<iframe :id="frameNames[i]" style="width: 100%; height: 100%; border-radius: 30px; border: none;" :src="whaleAddress[startPage[i]]" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>
				<Transition name="menuTransition" mode="out-in">
					<div class="menu-style menuBtn flexCenter" v-if="menuBtnTriggers[i]" :key="keyBtns[i]" @click="menuBtnTriggers[i] = !menuBtnTriggers[i]"><div class="menuBtn-square"></div></div>
	        		<div class="menu-style menuDock flexCenter" v-else :key="keyDocks[i]" @click="menuBtnTriggers[i] = !menuBtnTriggers[i]">
	        			<img class="menuDock-icon" :src="dockIcon" alt="Streaming Icon" style="height: 55%;" v-for="(dockIcon, j) in dockIcons" :key="j" @click.stop="changeDock(i,j,'')">
	        		</div>
        		</Transition>
        	</div>
        </div>
	`,
	props: {
		frameNames: Array,
		replaceIframe: {type: Function, default() {return 'Default function'}},
		startPage: Array,
		trackInfo: Array,
		whaleAddress: Array,
		isOver: Boolean,
	},
	data() {
		return {
			keyBtns: ['leftMenuBtn','rightMenuBtn'],
			keyDocks: ['leftDock','rightDock'],
			dockIcons: ['static/images/main/musicIcon.png','static/images/main/messageIcon.png','static/images/main/communityIcon.png','static/images/main/feedIcon.png','static/images/streaming/player/magnifying-glass.svg'],
			menuBtnTriggers: [true, true],
		};
	},
	watch : {
    },
    mounted() {
		this.checkStartPage();
	},
	methods: {
		checkStartPage() {
			fetch('main/checkStartPage')
				.then(response => response.json())
				.then(data => {
					this.startPage[0] = data.leftStartPage;
					this.startPage[1] = data.rightStartPage;
			});
		},
		changeDock(i,j,k) {
			this.replaceIframe(i,j,k);
			this.menuBtnTriggers[i] = true;
		},
	}
};

export default MainCenterComponent;