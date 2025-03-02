# Whale music - 음악 스트리밍 서비스 프로젝트

Spotify Api를 사용하여 다양한 음악을 스트리밍하고, 음악과 관련된 내용을 나눌 수 있는 커뮤니티 플랫폼입니다. 로그인/회원가입, 음악 스트리밍, 피드/커뮤니티, 메세지/프로필, 환경설정, 관리자 등의 기능을 갖추고 두개의 탭을 양쪽에 배치하여 음악 스트리밍 서비스를 즐기면서도 메시지, 커뮤니티, 피드 등의 기능을 이용함에 어떠한 제약이 없도록 설계했습니다. 백엔드는 Java와 Spring, Node.js를 사용하고, 프론트엔드는 Vue.js와 Jsp를 활용하였습니다. 데이터는 Spotify Api를 통해 수집하거나 Oracle에 저장하여 사용합니다.

[프로젝트 목표]
* Spotify API 사용: 외부 데이터를 활용, 가공하는 방법을 배우고 익힘
* 커뮤니티 사이트 구축: 음악 게시판, 피드, 메세지 기능 등을 추가하여 음악 커뮤니티 기능을 만들고자 함

[프로젝트 개요]
* 기간: 2024.09.02 ~ 2024.11.20
* 팀원: 백엔드 5명
* 사용기술: Java, Spring, Oracle, MyBatis, Vue.js, Node.js
* 담당(김서연): 유저 관리[회원가입, 로그인, 로그아웃, 회원탈퇴] (100%), 음악 스트리밍 기능[스트리밍, 플레이리스트, 좋아요 기능] (60%)

## 담당 기능
<로그인/로그아웃>
* 스포티파이 API 의 OAudth 인증 시스템을 이용하여 로그인 기능을 개발했습니다.
* Spring Boot에서는 Server Side Rendering을 많이 활용했습니다.
* Spotify 인증 과정을 Spotify Web API Java Library를 통해 구현했습니다.

![Image](https://github.com/user-attachments/assets/209d15f5-858a-4c43-916e-d1a8efe239d9)

<회원가입>
* Spotify API 인증을 통해 얻은 access token을 사용하여 Spotify에 로그인한 사용자의 이메일 정보를 수집합니다.
* 회원 가입에 필요한 정보를 Ajax를 이용해 서버에 요청하면, 중복 여부를 확인하고 비밀번호를 해싱하여 USER_INFO 테이블에 저장합니다.
* 이후, 사용자가 Whale을 이용하기 위해 필요한 다양한 테이블(환경 설정, 프로필 등)에 기본값을 입력한 후 회원 가입 절차를 마무리합니다.

![Image](https://github.com/user-attachments/assets/9ddaa30a-47cf-4487-84ef-822dcecd324b)

<아이디/비밀번호 찾기>
* 입력된 이메일이 USER_INFO 테이블에 존재하는지 확인하고, 존재할 경우 고유한 Token을 생성하여 PASSWORD_RESETS 테이블에 해당 사용자 아이디와 함께 저장합니다.
* 이후 JavaMailSender를 통해 이메일을 발송합니다.
* 사용자가 제공한 정보가 일치할 경우, Token과 새 비밀번호를 Ajax를 통해 서버에 요청하면, 서버는 PASSWORD_RESETS 테이블에서 해당 Token에 대한 정보를 확인합니다.

![Image](https://github.com/user-attachments/assets/6a155eed-bcdb-4e49-90b4-30160dd02d46)
![Image](https://github.com/user-attachments/assets/03b2af89-1615-46b2-bb91-59f74882282a)

<음악 스트리밍>
* 음악, 앨범, 플레이리스트, 아티스트 정보와 상호작용할 수 있도록 설계했습니다.
* 메인 페이지에서는 access token을 이용하여 현재 Spotify에 로그인한 사용자의 즐겨 듣는 곡, 최근 재생한 항목, 추천 플레이리스트 정보를 받아온 후, 최근 재생한 항목의 데이터를 Spotify API에 요청하여 추천 아티스트 정보를 응답받고, 이를 서버에서 렌더링합니다.

![Image](https://github.com/user-attachments/assets/29a2654c-b115-4227-92f2-cfa86988bdeb)

<앨범 상세 페이지>
* Query의 albumId를 사용하여 Spotify API에 요청을 보내고, 해당 앨범의 정보와 그 앨범에 포함된 트랙 정보를 응답받습니다.
* 앨범 상세 페이지에서 아티스트 페이지로 이동하기 위해 albumId를 이용해 상단과 동일한 절차를 통해 아티스트 정보를 응답합니다.
* 위에서 수집한 데이터들을 Model에 저장하여 반환합니다.

<검색 페이지>
* Query의 내용을 Spotify API에 전달하여 일치하는 아티스트, 트랙, 앨범 및 플레이리스트 정보를 반환받습니다.
* 위에서 수집한 데이터들을 Model에 저장하여 반환합니다.

![Image](https://github.com/user-attachments/assets/dab9532a-23f1-4e4c-850d-fab4f9d8de91)

<아티스트 상세 페이지>
* Query의 artistId를 Spotify API에 전달하여 해당 아티스트의 정보, 인기 곡, 그리고 앨범 목록을 받아옵니다.
* 응답받은 아티스트 정보에서 이름을 추출하여 Spotify API를 통해 검색 기능을 이용해 관련된 플레이리스트를 반환합니다.
* 위에서 수집한 데이터들을 Model에 저장하여 반환합니다.

<트랙 상세 페이지>
* Query의 trackId를 Spotify API에 보내 해당 트랙에 대한 정보를 요청합니다.
* 트랙 상세 페이지에서 아티스트 페이지와 앨범 페이지로 이동하기 위해 trackId를 사용하여 위와 같은 방식으로 앨범 및 아티스트 정보를 받아옵니다.
* 위에서 수집한 데이터들을 Model에 저장하여 반환합니다.

![Image](https://github.com/user-attachments/assets/95191efc-d65f-42fd-96b0-fd958c2f51ea)

<좋아요 상세 페이지>
* Session에 저장된 userId를 활용하여 사용자가 좋아요 표시한 트랙 리스트를 조회합니다.
* 좋아요 상세 페이지에서 아티스트 페이지와 앨범 페이지로 이동하기 위해 trackId를 사용하여 아티스트 정보를 동일한 방식으로 가져옵니다.
* 위에서 수집한 데이터들을 Model에 저장하여 반환합니다.

![Image](https://github.com/user-attachments/assets/ecc03cf5-7384-4975-8355-176b31b48d21)
