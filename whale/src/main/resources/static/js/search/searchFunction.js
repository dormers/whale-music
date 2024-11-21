// [ Resize ]
$(document).ready(() => {
    resize();
});
$(window).resize(() => {
    resize();
});

function resize() {
    const headerElement = document.querySelector(".headerSearch");
    const mainElement = document.querySelector(".mainSearch");

    const windowHeight = window.innerHeight;
    const headerHeight = headerElement ? headerElement.offsetHeight : 0;

    if (mainElement) {
        mainElement.style.height = `${windowHeight - headerHeight - headerHeight}px`;
    }
}

let currentSearchType = 'user'; // 기본 검색 유형

$(document).ready(() => {
    resize();

    // 검색 입력 변화 감지
    $('#searchInput').on('input', function () {
        let keyword = $(this).val();
        getSearchResults(keyword);
    });

    // 탭 클릭 이벤트 처리
    $('.mainSearchTab p').on('click', function () {
        // 활성 탭 스타일 업데이트
        $('.mainSearchTab p').removeClass('active');
        $(this).addClass('active');

        // 현재 검색 유형 업데이트
        currentSearchType = $(this).data('type');

        // 현재 키워드로 검색 실행
        let keyword = $('#searchInput').val();
        getSearchResults(keyword);
    });
});

function getSearchResults(keyword) {
    if (!keyword) {
        $('.mainSearchResult').empty(); // 키워드가 없으면 결과를 지웁니다.
        return;
    }

    let url;
    if (currentSearchType === 'user') {
        url = '/whale/search/user';
    } else if (currentSearchType === 'post') {
        url = '/whale/search/post';
    } else if (currentSearchType === 'feed') {
        url = '/whale/search/feed';
    }

    $.ajax({
        url: url,
        type: 'GET',
        data: {keyword: keyword},
        dataType: 'json',
        success: function (response) {
            if (response.success) {
                if (currentSearchType === 'user') {
                    displayUserResults(response.userList);
                } else if (currentSearchType === 'post') {
                    displayPostResults(response.postList);
                } else if (currentSearchType === 'feed') {
                    displayFeedResults(response.feedList);
                }
            } else {
                $('.mainSearchResult').html('<p>검색 결과가 없습니다.</p>');
            }
        },
        error: function (xhr, status, error) {
            $('.mainSearchResult').html('<p>오류가 발생했습니다. 다시 시도해주세요.</p>');
        }
    });
}

function displayUserResults(userList) {
    let resultDiv = $('.mainSearchResult');
    resultDiv.empty();

    if (userList.length === 0) {
        resultDiv.html('<p>검색 결과가 없습니다.</p>');
        return;
    }

    userList.forEach(function (user) {
        let userHtml = `
            <a href="/whale/profileHome?u=${encodeURIComponent(user.user_id)}" class="userLink">
                <div class="userItem">
                    <img src="${user.user_image_url}" alt="${user.user_nickname}" />
                    <div>
                        <p style="margin-bottom: 0;">${user.user_nickname}</p>
                        <p style="margin-top: 0; font-size: .85rem;">@${user.user_id}</p>
                    </div>
                </div>
            </a>`;
        resultDiv.append(userHtml);
    });
}

function displayPostResults(postList) {
    let resultDiv = $('.mainSearchResult');
    resultDiv.empty();

    if (postList.length === 0) {
        resultDiv.html('<p>검색 결과가 없습니다.</p>');
        return;
    }

    postList.forEach(function (post) {
        // 이미지 태그 제거
        let cleanText = post.post_text.replace(/<img[^>]*>/g, '');

        // DOMParser를 사용하여 HTML 파싱
        let parser = new DOMParser();
        let doc = parser.parseFromString(cleanText, 'text/html');

        // 모든 텍스트 노드 수집 (내용이 있는 것만)
        function getTextNodes(node) {
            let textNodes = [];
            if (node.nodeType === Node.TEXT_NODE) {
                if (node.textContent.trim() !== '') {
                    textNodes.push(node);
                }
            } else {
                node.childNodes.forEach(function (child) {
                    textNodes = textNodes.concat(getTextNodes(child));
                });
            }
            return textNodes;
        }

        let textNodes = getTextNodes(doc.body);

        // 텍스트 노드를 <p> 태그로 감싸고, 최대 두 개만 사용
        let fragment = doc.createDocumentFragment();
        textNodes.slice(0, 1).forEach(function (textNode) {
            let p = doc.createElement('p');
            p.textContent = textNode.textContent.trim();
            fragment.appendChild(p);
        });

        // 결과 HTML 생성
        let tempDiv = doc.createElement('div');
        tempDiv.appendChild(fragment);
        let finalContent = tempDiv.innerHTML;

        // 게시글 HTML 구성
        let postHtml = `
            <a href="communityDetail?c=${encodeURIComponent(post.community_id)}&p=${encodeURIComponent(post.post_id)}">
                <div class="postItem">
                    <div class="postItemFlexBox">
                        <div class="title">
                            <p class="post-tag">${post.post_tag_text}</p>
                            <h3>${post.post_title}</h3>                
                        </div>
                        <span>${post.user_nickname}</span>
                    </div>
                    ${finalContent}
                </div>
            </a>`;
        resultDiv.append(postHtml);
    });
}

function displayFeedResults(feedList) {
    let resultDiv = $('.mainSearchResult');
    resultDiv.empty();

    if (feedList.length === 0) {
        resultDiv.html('<p>검색 결과가 없습니다.</p>');
        return;
    }

    // 새로운 컨테이너 div 생성
    let containerDiv = $('<div class="feedContainer"></div>');

    feedList.forEach(function (feed) {
        let feedHtml = `
            <a href="feedDetail?f=${encodeURIComponent(feed.feed_id)}" class="feedLink">
                <div class="feedItem">
                    <!-- 피드 텍스트와 닉네임을 포함하려면 주석을 해제하세요 -->
                    <!-- <p>${feed.feed_text}</p> -->
                    <!-- <span>${feed.user_nickname}</span> -->
                    ${feed.feed_img_url ? `<img src="${feed.feed_img_url}" alt="Feed Image">` : ''}
                </div>
            </a>`;
        containerDiv.append(feedHtml);
    });

    resultDiv.append(containerDiv);
}
