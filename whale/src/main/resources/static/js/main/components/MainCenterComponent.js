const MainCenterComponent = {
	template: `
		<div class="mainItems flexCenter" v-for="(menuBtnTrigger, i) in menuBtnTriggers" :key="i">
			<div class="frame">
                <iframe :id="frameNames[i]" style="width: 100%; height: 100%; border-radius:30px; border: none" :src="whaleAddress[i]" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>
	        	<Transition name="menuTransition" mode="out-in">
	        		<div class="menu-style menuBtn flexCenter" v-if="menuBtnTriggers[i]" :key="keyBtns[i]" @click="menuBtnTriggers[i] = !menuBtnTriggers[i]"><div class="menuBtn-square"></div></div>
	        		<div class="menu-style menuDock flexCenter" v-else :key="keyDocks[i]" @click="menuBtnTriggers[i] = !menuBtnTriggers[i]">
	        			<img class="menuDock-icon" :src="dockIcon" alt="Streaming Icon" style="height: 55%;" v-for="(dockIcon, j) in dockIcons" :key="j" @click.stop="replaceIframe(i,j)">
	        		</div>
        		</Transition>
            </div>
        </div>
	`,
	props: {
		frameNames: Array,
		whaleAddress: Array,
		replaceIframe: {type: Function, default() {return 'Default function'}},
	},
	data() {
		return {
			keyBtns: ['leftMenuBtn','rightMenuBtn'],
			keyDocks: ['leftDock','rightDock'],
			dockIcons: ['static/images/main/communityIcon.png','static/images/main/streamingIcon.png','static/images/main/musicTemp.png','static/images/main/messageIcon.png','static/images/main/feedIcon.png'],
			startPage: [ null, null ],
			menuBtnTriggers: [true, true],
		};
	},
	watch : {
    },
	methods: {
	}
};

export default MainCenterComponent;