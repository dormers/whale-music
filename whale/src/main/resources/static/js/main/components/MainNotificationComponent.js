const MainCenterComponent = {
	template: `
		<div id="notification-container"></div>
	`,
	props: {
		getNotification: {type: Function, default() {return 'Default function'}},
	},
	data() {
		return {
			socket: null,
		};
	},
	watch : {
    },
    mounted() {
		this.openSocket();
	},
	methods: {
		openSocket() {
			const protocol = window.location.protocol === 'https:' ? 'wss://' : 'ws://';
			const socketUrl = protocol + "25.5.112.217:9002/whale/home?userId=" + sessionStorage.user_id;
			this.socket = new WebSocket(socketUrl);
			
			this.socket.onopen = () => {
		        console.log("Home WebSocket 연결 성공");
		    };
		
		    this.socket.onmessage = (event) => {
		        console.log("새 메시지 수신:", event.data);
		        const homeMessage = JSON.parse(event.data);
		        this.updateChatList(homeMessage);
		        
		        // 알림 표시 함수 호출
		        this.showNotification(homeMessage.userImageUrl, 
		        					  homeMessage.messageType, 
		        					  homeMessage.senderId, 
		        					  homeMessage.senderNickname, 
		        					  homeMessage.messageText);
		        this.getNotification();
		    };
		
		    this.socket.onclose = (event) => {
		        console.log("Home WebSocket 연결 종료:", event);
		    };
		
		    this.socket.onerror = (error) => {
		        console.error("Home WebSocket 오류:", error);
		    };
		},
	
	    updateChatList(homeMessage) {
	        // 기존 채팅 목록 업데이트 로직 ...
	    },
	
	    // 알림 생성 함수 추가
	    showNotification(userImageUrl, messageType, senderId, userNickname, messageText) {
	        const container = document.getElementById('notification-container');
	        
	        const notification = document.createElement('div');
	        notification.className = 'notification';
	        
	        notification.innerHTML = `
		        <div class="notification-message-go" style="display: flex; flex-direction: row; align-items: center; text-decoration: none; color: inherit;">
		            <img src="${userImageUrl}" alt="User Image" style="width: 40px; height: 40px; border-radius: 50%;">
		            <div class="text-content">
		                <div><strong>${userNickname}</strong></div>
		                	<div>${messageText}</div>                	                	
		            </div>
		        </div>
	        `;
	        container.appendChild(notification);
	        
	        // Add a click event listener to the notification
		    notification.querySelector('.notification-message-go').addEventListener('click', () => {
		        this.$emit('message-go', 4, 10, `?u=${senderId}`);
		    });
	        
	        // 2초 후에 알림 제거
	        setTimeout(() => {
	            notification.style.opacity = '0';
	            notification.style.transform = 'translateY(-20px)';
	            setTimeout(() => {
	                if (notification.parentNode === container) {
	                    container.removeChild(notification);
	                }
	            }, 500); // CSS 트랜지션 시간과 일치시킴
	        }, 2000);
	    },
	}
};

export default MainCenterComponent;