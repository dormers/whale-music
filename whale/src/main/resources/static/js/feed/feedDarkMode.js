document.addEventListener("DOMContentLoaded", function () {
    const feedElement = document.querySelector('.feed-container');
    const toggleSlide = document.getElementById('toggle-slide');

    // 페이지가 로드될 때마다 localStorage에서 darkmodeOn 값을 가져와 data-darkmode 설정
    let darkmodeOn = localStorage.getItem('darkmodeOn') || "0"; // 값이 없으면 기본값을 "0"으로 설정
    feedElement.setAttribute("data-darkmode", darkmodeOn);

    // 다크 모드 초기 설정
    const isDarkMode = darkmodeOn === "1";
    toggleSlide.checked = isDarkMode;
    feedElement.classList.toggle("dark", isDarkMode);
    feedElement.classList.toggle("light", !isDarkMode);

    // 토글 버튼 변경 시 다크 모드 설정 및 저장
    toggleSlide.addEventListener('change', function () {
        darkmodeOn = this.checked ? "1" : "0";

        // 다크 모드 상태를 localStorage와 data-darkmode 속성에 저장
        localStorage.setItem('darkmodeOn', darkmodeOn);
        feedElement.setAttribute("data-darkmode", darkmodeOn);

        // 다크 모드 클래스 적용
        feedElement.classList.toggle("dark", darkmodeOn === "1");
        feedElement.classList.toggle("light", darkmodeOn !== "1");

        // AJAX 요청
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '/whale/updateDarkmode', true); // 서버에 POST 요청 보냄
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        // 서버로 데이터 전송
        xhr.send('darkmode_setting_onoff=' + darkmodeOn);

        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    console.log('Darkmode setting update in DB.');
                    console.log(darkmodeOn === "1" ? "Dark mode enabled (1)" : "Dark mode disabled (0)");
                } else {
                    console.log('Error updating darkmode setting. Status:', xhr.status, 'Response:', xhr.responseText);
                }
            }
        };
    });

    // 다른 탭에서 localStorage 값이 변경될 때 적용
    window.addEventListener('storage', function (event) {
        if (event.key === 'darkmodeOn') {
            darkmodeOn = event.newValue || "0";
            feedElement.setAttribute("data-darkmode", darkmodeOn);
            const isDark = darkmodeOn === "1";
            feedElement.classList.toggle("dark", isDark);
            feedElement.classList.toggle("light", !isDark);
            toggleSlide.checked = isDark;
        }
    });
});
