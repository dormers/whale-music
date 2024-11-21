document.addEventListener("DOMContentLoaded", function () {
    const settingElement = document.querySelector('.setting-body');
    const feedElement = document.querySelector('.feed-container');
    const communityElement = document.querySelector('.container');
    const communityDetailElement = document.querySelector('.container');
    const communityPostElement = document.querySelector('.content-wrapper');
    const communityPostModalElement = document.querySelector('.modal');
    const streamingElement = document.querySelector('.streamingBody');
    const profileHomeElement = document.querySelector('.container');
    const toggleSlide = document.getElementById('toggle-slide');
    let darkmodeOn = localStorage.getItem('darkmodeOn') || "0";

    const updateScrollbarStyle = () => {
        const styleSheet = document.getElementById("darkmode-scrollbar-styles");
        if (darkmodeOn === "1") {
            styleSheet.innerHTML = `
                html::-webkit-scrollbar {display: block; width: 8px;}
                html::-webkit-scrollbar-track {background: #2e2e2e;}
                html::-webkit-scrollbar-thumb {background-color: #555; border-radius: 4px;}
                html {width: 100%; height: 190px; overflow-y: auto; scroll-behavior: smooth; display: flex; flex-direction: column;}
            `;
        } else {
            styleSheet.innerHTML = `
                html::-webkit-scrollbar {display: block; width: 8px;}
                html::-webkit-scrollbar-track {background: #fff;}
                html::-webkit-scrollbar-thumb {background-color: #ccc; border-radius: 4px;}
                html {width: 100%; height: 190px; overflow-y: auto; scroll-behavior: smooth; display: flex; flex-direction: column;}
            `;
        }
    };

    if (settingElement) {
        settingElement.setAttribute("data-darkmode", darkmodeOn);
        const isDarkMode = darkmodeOn === "1";
        toggleSlide.checked = isDarkMode;
        settingElement.classList.toggle("dark", isDarkMode);
        settingElement.classList.toggle("light", !isDarkMode);

        toggleSlide.addEventListener('change', function () {
            darkmodeOn = this.checked ? "1" : "0";
            localStorage.setItem('darkmodeOn', darkmodeOn);
            settingElement.setAttribute("data-darkmode", darkmodeOn);
            settingElement.classList.toggle("dark", darkmodeOn === "1");
            settingElement.classList.toggle("light", darkmodeOn !== "1");
            window.parent.postMessage({ darkmodeOn: darkmodeOn }, "*");

            const xhr = new XMLHttpRequest();
            xhr.open('POST', '/whale/updateDarkmode', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.send('darkmode_setting_onoff=' + darkmodeOn);
        });
    }

    if (feedElement) {
        feedElement.setAttribute("data-darkmode", darkmodeOn);
        const isDarkMode = darkmodeOn === "1";
        feedElement.classList.toggle("dark", isDarkMode);
        feedElement.classList.toggle("light", !isDarkMode);

        window.addEventListener('message', function (event) {
            if (event.data && event.data.darkmodeOn !== undefined) {
                darkmodeOn = event.data.darkmodeOn;
                feedElement.setAttribute("data-darkmode", darkmodeOn);
                const isDarkMode = darkmodeOn === "1";
                feedElement.classList.toggle("dark", isDarkMode);
                feedElement.classList.toggle("light", !isDarkMode);

                updateScrollbarStyle(); // 스크롤바 스타일 업데이트
            }
        });
    }

    if (communityElement) {
        communityElement.setAttribute("data-darkmode", darkmodeOn);
        const isDarkMode = darkmodeOn === "1";
        communityElement.classList.toggle("dark", isDarkMode);
        communityElement.classList.toggle("light", !isDarkMode);

        window.addEventListener('message', function (event) {
            if (event.data && event.data.darkmodeOn !== undefined) {
                darkmodeOn = event.data.darkmodeOn;
                communityElement.setAttribute("data-darkmode", darkmodeOn);
                const isDarkMode = darkmodeOn === "1";
                communityElement.classList.toggle("dark", isDarkMode);
                communityElement.classList.toggle("light", !isDarkMode);

                updateScrollbarStyle(); // 스크롤바 스타일 업데이트
            }
        });
    }

    if (communityDetailElement) {
        communityDetailElement.setAttribute("data-darkmode", darkmodeOn);
        const isDarkMode = darkmodeOn === "1";
        communityDetailElement.classList.toggle("dark", isDarkMode);
        communityDetailElement.classList.toggle("light", !isDarkMode);

        window.addEventListener('message', function (event) {
            if (event.data && event.data.darkmodeOn !== undefined) {
                darkmodeOn = event.data.darkmodeOn;
                communityDetailElement.setAttribute("data-darkmode", darkmodeOn);
                const isDarkMode = darkmodeOn === "1";
                communityDetailElement.classList.toggle("dark", isDarkMode);
                communityDetailElement.classList.toggle("light", !isDarkMode);

                updateScrollbarStyle(); // 스크롤바 스타일 업데이트
            }
        });
    }

    if (communityPostElement) {
        communityPostElement.setAttribute("data-darkmode", darkmodeOn);
        const isDarkMode = darkmodeOn === "1";
        communityPostElement.classList.toggle("dark", isDarkMode);
        communityPostElement.classList.toggle("light", !isDarkMode);

        window.addEventListener('message', function (event) {
            if (event.data && event.data.darkmodeOn !== undefined) {
                darkmodeOn = event.data.darkmodeOn;
                communityPostElement.setAttribute("data-darkmode", darkmodeOn);
                const isDarkMode = darkmodeOn === "1";
                communityPostElement.classList.toggle("dark", isDarkMode);
                communityPostElement.classList.toggle("light", !isDarkMode);

                updateScrollbarStyle(); // 스크롤바 스타일 업데이트
            }
        });
    }

    if (communityPostModalElement) {
        communityPostModalElement.setAttribute("data-darkmode", darkmodeOn);
        const isDarkMode = darkmodeOn === "1";
        communityPostModalElement.classList.toggle("dark", isDarkMode);
        communityPostModalElement.classList.toggle("light", !isDarkMode);

        window.addEventListener('message', function (event) {
            if (event.data && event.data.darkmodeOn !== undefined) {
                darkmodeOn = event.data.darkmodeOn;
                communityPostModalElement.setAttribute("data-darkmode", darkmodeOn);
                const isDarkMode = darkmodeOn === "1";
                communityPostModalElement.classList.toggle("dark", isDarkMode);
                communityPostModalElement.classList.toggle("light", !isDarkMode);

                updateScrollbarStyle(); // 스크롤바 스타일 업데이트
            }
        });
    }

    if (profileHomeElement) {
        profileHomeElement.setAttribute("data-darkmode", darkmodeOn);
        const isDarkMode = darkmodeOn === "1";
        profileHomeElement.classList.toggle("dark", isDarkMode);
        profileHomeElement.classList.toggle("light", !isDarkMode);

        window.addEventListener('message', function (event) {
            if (event.data && event.data.darkmodeOn !== undefined) {
                darkmodeOn = event.data.darkmodeOn;
                profileHomeElement.setAttribute("data-darkmode", darkmodeOn);
                const isDarkMode = darkmodeOn === "1";
                profileHomeElement.classList.toggle("dark", isDarkMode);
                profileHomeElement.classList.toggle("light", !isDarkMode);

                updateScrollbarStyle(); // 스크롤바 스타일 업데이트
            }
        });
    }

    if (streamingElement) {
        streamingElement.setAttribute("data-darkmode", darkmodeOn);
        const isDarkMode = darkmodeOn === "1";
        streamingElement.classList.toggle("dark", isDarkMode);
        streamingElement.classList.toggle("light", !isDarkMode);

        window.addEventListener('message', function (event) {
            if (event.data && event.data.darkmodeOn !== undefined) {
                darkmodeOn = event.data.darkmodeOn;
                streamingElement.setAttribute("data-darkmode", darkmodeOn);
                const isDarkMode = darkmodeOn === "1";
                streamingElement.classList.toggle("dark", isDarkMode);
                streamingElement.classList.toggle("light", !isDarkMode);

                updateScrollbarStyle(); // 스크롤바 스타일 업데이트
            }
        });

        const bodyClass = document.body.classList.contains("dark") ? "dark" : "light";
        if (page !== 'home') {
            if (bodyClass === "dark") {
                console.log("Dark theme is active");

                const updateBackground = () => {
                    const mainContent = document.querySelector('.mainContent');
                    if (mainContent) {
                        function getRandomColor() {
                            const r = Math.floor(Math.random() * 256);
                            const g = Math.floor(Math.random() * 256);
                            const b = Math.floor(Math.random() * 256);
                            console.log("Generated RGB values:", r, g, b);
                            return `rgb(${r}, ${g}, ${b})`;
                        }

                        const randomColor = getRandomColor();
                        console.log("Random color:", randomColor);
                        mainContent.style.backgroundImage = `linear-gradient(${randomColor} 0%, rgb(17, 18, 17) 100%)`;
                        console.log("Background image:", mainContent.style.backgroundImage);
                    } else {
                        console.error('mainContent 요소를 찾을 수 없습니다.');
                    }
                };
                updateBackground(); // dark 모드일 때 배경 업데이트
            } else if (bodyClass === "light") {
                console.log("Light theme is active");

                const updateBackground = () => {
                    const mainContent = document.querySelector('.mainContent');
                    if (mainContent) {
                        function getRandomColor() {
                            const r = Math.floor(Math.random() * 256);
                            const g = Math.floor(Math.random() * 256);
                            const b = Math.floor(Math.random() * 256);
                            console.log("Generated RGB values:", r, g, b);
                            return `rgb(${r}, ${g}, ${b})`;
                        }

                        const randomColor = getRandomColor();
                        console.log("Random color:", randomColor);
                        mainContent.style.backgroundImage = `linear-gradient(${randomColor} 0%, rgb(249, 250, 249) 100%)`;
                        console.log("Background image:", mainContent.style.backgroundImage);
                    } else {
                        console.error('mainContent 요소를 찾을 수 없습니다.');
                    }
                };
                updateBackground(); // light 모드일 때 배경 업데이트
            }
        }
    }

    window.addEventListener('storage', function (event) {
        if (event.key === 'darkmodeOn') {
            darkmodeOn = event.newValue || "0";
            if (settingElement) {
                settingElement.setAttribute("data-darkmode", darkmodeOn);
                const isDark = darkmodeOn === "1";
                settingElement.classList.toggle("dark", isDark);
                settingElement.classList.toggle("light", !isDark);
                toggleSlide.checked = isDark;
            }
            if (feedElement) {
                feedElement.setAttribute("data-darkmode", darkmodeOn);
                const isDark = darkmodeOn === "1";
                feedElement.classList.toggle("dark", isDark);
                feedElement.classList.toggle("light", !isDark);
            }
            if (communityElement) {
                communityElement.setAttribute("data-darkmode", darkmodeOn);
                const isDark = darkmodeOn === "1";
                communityElement.classList.toggle("dark", isDark);
                communityElement.classList.toggle("light", !isDark);
            }
            if (communityDetailElement) {
                communityDetailElement.setAttribute("data-darkmode", darkmodeOn);
                const isDark = darkmodeOn === "1";
                communityDetailElement.classList.toggle("dark", isDark);
                communityDetailElement.classList.toggle("light", !isDark);
            }
            if (communityPostElement) {
                communityPostElement.setAttribute("data-darkmode", darkmodeOn);
                const isDark = darkmodeOn === "1";
                communityPostElement.classList.toggle("dark", isDark);
                communityPostElement.classList.toggle("light", !isDark);
            }
            if (communityPostModalElement) {
                communityPostModalElement.setAttribute("data-darkmode", darkmodeOn);
                const isDark = darkmodeOn === "1";
                communityPostModalElement.classList.toggle("dark", isDark);
                communityPostModalElement.classList.toggle("light", !isDark);
            }
            if (profileHomeElement) {
                profileHomeElement.setAttribute("data-darkmode", darkmodeOn);
                const isDark = darkmodeOn === "1";
                profileHomeElement.classList.toggle("dark", isDark);
                profileHomeElement.classList.toggle("light", !isDark);
            }
            if (streamingElement) {
                streamingElement.setAttribute("data-darkmode", darkmodeOn);
                const isDark = darkmodeOn === "1";
                streamingElement.classList.toggle("dark", isDark);
                streamingElement.classList.toggle("light", !isDark);

                const bodyClass = document.body.classList.contains("dark") ? "dark" : "light";

                if (bodyClass === "dark") {
                    console.log("Dark theme is active");

                    const updateBackground = () => {
                        const mainContent = document.querySelector('.mainContent');
                        if (mainContent) {
                            function getRandomColor() {
                                const r = Math.floor(Math.random() * 256);
                                const g = Math.floor(Math.random() * 256);
                                const b = Math.floor(Math.random() * 256);
                                console.log("Generated RGB values:", r, g, b);
                                return `rgb(${r}, ${g}, ${b})`;
                            }

                            const randomColor = getRandomColor();
                            console.log("Random color:", randomColor);
                            mainContent.style.backgroundImage = `linear-gradient(${randomColor} 0%, rgb(17, 18, 17) 100%)`;
                            console.log("Background image:", mainContent.style.backgroundImage);
                        } else {
                            console.error('mainContent 요소를 찾을 수 없습니다.');
                        }
                    };
                    updateBackground(); // dark 모드일 때 배경 업데이트
                } else if (bodyClass === "light") {
                    console.log("Light theme is active");

                    const updateBackground = () => {
                        const mainContent = document.querySelector('.mainContent');
                        if (mainContent) {
                            function getRandomColor() {
                                const r = Math.floor(Math.random() * 256);
                                const g = Math.floor(Math.random() * 256);
                                const b = Math.floor(Math.random() * 256);
                                console.log("Generated RGB values:", r, g, b);
                                return `rgb(${r}, ${g}, ${b})`;
                            }

                            const randomColor = getRandomColor();
                            console.log("Random color:", randomColor);
                            mainContent.style.backgroundImage = `linear-gradient(${randomColor} 0%, rgb(249, 250, 249) 100%)`;
                            console.log("Background image:", mainContent.style.backgroundImage);
                        } else {
                            console.error('mainContent 요소를 찾을 수 없습니다.');
                        }
                    };
                    updateBackground(); // light 모드일 때 배경 업데이트
                }
            }
            updateScrollbarStyle(); // 스크롤바 스타일 업데이트
        }
    });

    // 초기 페이지 로드 시 스크롤바 스타일 적용
    updateScrollbarStyle();
});
