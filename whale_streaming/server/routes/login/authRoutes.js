// server/routes/login/authRoutes.js

const express = require("express");
const router = express.Router();
const path = require("path");
const querystring = require("querystring");
const bcrypt = require("bcrypt");
const axios = require('axios');
const crypto = require('crypto');

// oracleDB 설치
const { oracledb, dbConfig } = require("../../models/db/node/oracledb");

// smtp mailer
const { sendResetEmail } = require("../../models/mailer");

// Spotify 인증을 위한 설정
const stateKey = 'spotify_auth_state';
const clientId = process.env.CLIENT_ID;
const clientSecret = process.env.CLIENT_SECRET;
const redirectUri = process.env.REDIRECT_URI;

// 라우터에 정적 파일 제공
router.use(express.static(path.join(__dirname, "../../../public")));

// 로그인 페이지 및 회원가입 페이지, 아이디/비밀번호 찾기 루트 등록
router.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "../../../public/html/index.html"));
});
router.get("/register", (req, res) => {
  res.sendFile(path.join(__dirname, "../../../public/html/register.html"));
});
router.get("/find", (req, res) => {
  res.sendFile(path.join(__dirname, "../../../public/html/find.html"));
});

// Spring의 메인 페이지로 이동
router.get("/main", (req, res) => {
  if (req.session.accessToken) {
    // 스프링 서버로 리다이렉트
    res.redirect(
      "http://localhost:9002/whale/check-access-id?" +
        querystring.stringify({
          access_token: req.session.accessToken,
          refresh_token: req.session.refreshToken,
          user_id: req.session.username,
          logged_in: req.session.loggedIn,
          access_id: req.session.accessId,
        })
    );
  } else {
    // Spotify 인증 페이지로 리다이렉트
    res.redirect("/whale/spotify/login");
  }
});

// 서버 측 로그인 여부 확인 API
router.get("/check-login", (req, res) => {
  if (req.session.loggedIn) {
    res.json({ loggedIn: true, username: req.session.username });
  } else {
    res.json({ loggedIn: false });
  }
});

// 사용자 로그인 API (bcrypt 사용)
router.post("/login", async (req, res) => {
  const { username, password } = req.body;

  let connection;

  try {
    connection = await oracledb.getConnection(dbConfig);

    // 사용자 조회
    const result = await connection.execute(
      `SELECT * FROM user_info WHERE user_id = :username`,
      [username],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (result.rows.length > 0) {
      const user = result.rows[0];

      // 데이터베이스에서 가져온 해시된 비밀번호
      const hashedPassword = user.USER_PASSWORD;

      // bcrypt의 compare 함수로 비밀번호 검증
      const passwordMatch = await bcrypt.compare(password, hashedPassword);

      if (passwordMatch) {
        req.session.loggedIn = true;
        req.session.username = username;
        req.session.authFlow = 'login'; // 로그인 플로우 설정

        // 관리자 여부 확인
        let connection;
        try {
          connection = await oracledb.getConnection(dbConfig);

          const result = await connection.execute(
            `SELECT USER_ACCESS_ID FROM USER_INFO WHERE USER_ID = :userId`,
            {
              userId: req.session.username,
            },
            { outFormat: oracledb.OUT_FORMAT_OBJECT }
          );

          const accessId = await result;

          req.session.accessId = accessId.rows[0].USER_ACCESS_ID;

        } catch (err) {
          console.error('Spotify 사용자 정보 업데이트 에러:', err);
          res.status(500).send('서버 에러가 발생했습니다.');
        } finally {
          if (connection) {
            try {
              await connection.close();
            } catch (err) {
              console.error(err);
            }
          }
        }

        // 로그인 성공 시 Spotify 인증 페이지로 리다이렉트하도록 응답
        res.json({ success: true, redirectTo: "/whale/spotify/login" });
      } else {
        res.json({
          success: false,
          message: "아이디 또는 비밀번호가 올바르지 않습니다.",
        });
      }
    } else {
      res.json({
        success: false,
        message: "아이디 또는 비밀번호가 올바르지 않습니다.",
      });
    }
  } catch (err) {
    console.error("로그인 에러:", err);
    res
      .status(500)
      .json({ success: false, message: "서버 에러가 발생했습니다." });
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (err) {
        console.error("연결 종료 에러:", err);
      }
    }
  }
});

// 사용자 회원가입 시작 API
router.post("/register/initiate", async (req, res) => {
  // 회원가입 플로우 설정
  req.session.authFlow = 'register';

  // Spotify 인증 페이지로 리다이렉트하도록 응답
  res.json({ success: true, redirectTo: "/whale/spotify/login" });
});

// Spotify 인증 라우트 (로그인 및 회원가입)
router.get('/spotify/login', (req, res) => {
  const state = crypto.randomBytes(16).toString('hex');
  res.cookie(stateKey, state);

  const scope = 'ugc-image-upload user-read-playback-state user-modify-playback-state user-read-currently-playing streaming playlist-read-private playlist-read-collaborative playlist-modify-private playlist-modify-public user-follow-modify user-follow-read user-top-read user-read-recently-played user-library-modify user-library-read user-read-email user-read-private'; // 필요한 권한 설정

  const queryParams = querystring.stringify({
    response_type: 'code',
    client_id: clientId,
    scope: scope,
    redirect_uri: redirectUri,
    state: state,
    show_dialog: true,
  });

  res.redirect(`https://accounts.spotify.com/authorize?${queryParams}`);
});

// 사용자 아이디/비밀번호 찾기 시작 API
router.post("/find/initiate", async (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ success: false, message: "이메일을 입력해주세요." });
  }

  let connection;
  try {
    // 필요한 로직 수행 (예: 세션 설정, 이메일 전송 등)
    // 예시: 세션에 authFlow 설정
    req.session.authFlow = 'find';

    connection = await oracledb.getConnection(dbConfig);

    // 이메일이 존재하는지 확인
    const result = await connection.execute(
      `SELECT user_id FROM user_info WHERE user_email = :email`,
      [email],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (result.rows.length === 0) {
      return res.json({ success: false, message: "등록된 이메일이 아닙니다." });
    }

    const userId = result.rows[0].USER_ID;

    // 고유 토큰 생성
    const token = crypto.randomBytes(32).toString('hex');

    // 토큰 저장
    await connection.execute(
      `INSERT INTO password_resets (user_id, token) VALUES (:user_id, :token)`,
      [userId, token],
      { autoCommit: true }
    );

    // 비밀번호 재설정 링크 생성
    const resetLink = `https://localhost:5500/whale/reset-password.html?token=${token}`;

    // 이메일 발송
    await sendResetEmail(email, resetLink, userId);

    res.json({ success: true, message: "비밀번호 재설정 링크가\n이메일로 전송되었습니다." });
  } catch (err) {
    console.error("아이디/비밀번호 찾기 시작 에러:", err);
    res.status(500).json({ success: false, message: "서버 에러가 발생했습니다." });
  }
});

// **비밀번호 재설정 페이지 라우트 추가**
router.get("/reset-password.html", (req, res) => {
  res.sendFile(path.join(__dirname, "../../../public/html/reset-password.html"));
});

// 사용자 비밀번호 재설정 API
router.post("/find/reset-password", async (req, res) => {
  const { token, newPassword } = req.body;

  if (!token || !newPassword) {
    return res.status(400).json({ success: false, message: "모든 필드를 입력해주세요." });
  }

  let connection;

  try {
    connection = await oracledb.getConnection(dbConfig);

    // 토큰 검증 및 사용자 ID 조회
    const result = await connection.execute(
      `SELECT user_id, created_at FROM password_resets WHERE token = :token`,
      [token],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (result.rows.length === 0) {
      return res.json({ success: false, message: "유효하지 않은 토큰입니다." });
    }

    const { USER_ID: userId, CREATED_AT: createdAt } = result.rows[0];

    // 토큰 유효 기간 확인 (예: 1시간)
    const currentTime = new Date();
    const tokenTime = new Date(createdAt);
    const diffHours = Math.abs(currentTime - tokenTime) / 36e5;

    if (diffHours > 1) {
      // 토큰 만료
      await connection.execute(
        `DELETE FROM password_resets WHERE token = :token`,
        [token],
        { autoCommit: true }
      );
      return res.json({ success: false, message: "토큰이 만료되었습니다. 다시 시도해주세요." });
    }

    // 비밀번호 해싱
    const hashedPassword = await bcrypt.hash(newPassword, 10);

    // 비밀번호 업데이트
    await connection.execute(
      `UPDATE user_info SET user_password = :password WHERE user_id = :user_id`,
      [hashedPassword, userId],
      { autoCommit: true }
    );

    // 사용된 토큰 삭제
    await connection.execute(
      `DELETE FROM password_resets WHERE token = :token`,
      [token],
      { autoCommit: true }
    );

    res.json({ success: true, message: "비밀번호가 성공적으로 변경되었습니다." });

  } catch (err) {
    console.error("비밀번호 재설정 에러:", err);
    res.status(500).json({ success: false, message: "서버 에러가 발생했습니다." });
  }
});

// Spotify 콜백 처리
router.get('/spotify/callback', async (req, res) => {
  const code = req.query.code || null;
  const state = req.query.state || null;
  const storedState = req.cookies ? req.cookies[stateKey] : null;

  console.log('Received Spotify callback');
  console.log('State:', state);
  console.log('Stored State:', storedState);

  if (state === null || state !== storedState) {
    console.log('State mismatch');
    res.redirect('/whale/register'); // 상태 불일치 시 회원가입 페이지로 리디렉트
  } else {
    res.clearCookie(stateKey);

    try {
      // 액세스 토큰 및 리프레시 토큰 받기
      const tokenResponse = await axios({
        method: 'POST',
        url: 'https://accounts.spotify.com/api/token',
        params: {
          grant_type: 'authorization_code',
          code: code,
          redirect_uri: redirectUri,
        },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        auth: {
          username: clientId,
          password: clientSecret,
        },
      });

      // 세션에 받아온 정보 저장
      req.session.accessToken = tokenResponse.data.access_token;
      req.session.refreshToken = tokenResponse.data.refresh_token;
      req.session.tokenType = tokenResponse.data.token_type;
      req.session.expiresIn = tokenResponse.data.expires_in;

      console.log('Access Token:', req.session.accessToken);
      console.log('Refresh Token:', req.session.refreshToken);

      // 사용자 프로필 정보 가져오기
      const userProfileResponse = await axios.get('https://api.spotify.com/v1/me', {
        headers: {
          Authorization: `Bearer ${req.session.accessToken}`,
        },
      });

      const spotifyUser = userProfileResponse.data;
      console.log('Spotify 사용자 이메일:', spotifyUser.email);

      // Spotify 이메일을 세션에 저장
      req.session.spotifyEmail = spotifyUser.email;

      // 인증 플로우에 따라 리다이렉트
      console.log('Auth Flow:', req.session.authFlow);
      if (req.session.authFlow === 'login') {
        res.redirect('/whale/main');
      } else if (req.session.authFlow === 'register') {
        res.redirect('/whale/register');
      } else {
        res.redirect('/whale/');
      }

    } catch (error) {
      console.error('Spotify 인증 에러:', error);
      res.redirect('/whale/');
    }
  }
});

// 사용자 등록 완료 처리 API
router.post("/register/complete", async (req, res) => {
  const { username, password, email, nickname } = req.body;

  console.log('Register Complete:', { username, email, nickname });

  // 필수 필드 확인
  if (!username || !nickname || !password || !email) {
    return res.status(400).json({ success: false, message: "모든 필드를 입력해주세요." });
  }

  // Spotify에서 받은 이메일과 일치하는지 확인
  if (email !== req.session.spotifyEmail) {
    console.log('Email mismatch:', email, req.session.spotifyEmail);
    return res.status(400).json({ success: false, message: "이메일이 일치하지 않습니다." });
  }

  let connection;

  try {
    connection = await oracledb.getConnection(dbConfig);

    // 사용자 중복 확인
    const existingUser = await connection.execute(
      `SELECT * FROM user_info WHERE user_id = :username`,
      [username],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (existingUser.rows.length > 0) {
      console.log('Duplicate username:', username);
      return res.json({ success: false, message: "이미 존재하는 아이디입니다." });
    }

    // 닉네임 중복 확인
    const existingNickname = await connection.execute(
      `SELECT * FROM user_info WHERE user_nickname = :nickname`,
      [nickname],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (existingNickname.rows.length > 0) {
      console.log('Duplicate nickname:', nickname);
      await connection.rollback();
      return res.json({ success: false, message: "이미 존재하는 닉네임입니다." });
    }

    // 비밀번호 해싱
    const hashedPassword = await bcrypt.hash(password, 10); // 10은 솔트 라운드 수입니다.

    // 새로운 사용자 추가 (이메일 및 닉네임 포함)
    await connection.execute(
      `INSERT INTO user_info (user_id, user_password, user_email, user_nickname) VALUES (:username, :password, :email, :nickname)`,
      [username, hashedPassword, email, nickname],
      { autoCommit: true }
    );

    // 환경 설정 기본값 세팅
    await connection.execute(
      `INSERT INTO USER_NOTIFICATION_ONOFF (USER_ID) VALUES (:username)`,
      [username],
      { autoCommit: true }
    );
    await connection.execute(
      `INSERT INTO PAGE_ACCESS_SETTING (USER_ID) VALUES (:username)`,
      [username],
      { autoCommit: true }
    );
    await connection.execute(
      `INSERT INTO STARTPAGE_SETTING (USER_ID) VALUES (:username)`,
      [username],
      { autoCommit: true }
    );
    await connection.execute(
      `INSERT INTO BLOCK (USER_ID) VALUES (:username)`,
      [username],
      { autoCommit: true }
    );
    await connection.execute(
      `INSERT INTO USER_SETTING (USER_ID) VALUES (:username)`,
      [username],
      { autoCommit: true }
    );

    // 회원가입 성공 후 세션 설정
    req.session.loggedIn = true;
    req.session.username = username;
    req.session.authFlow = null; // 플로우 초기화

    res.json({ success: true, message: "회원가입 완료되었습니다.", redirectTo: "/whale/" });

  } catch (err) {
    console.error("회원가입 에러:", err);
    res
      .status(500)
      .json({ success: false, message: "서버 에러가 발생했습니다." });
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (err) {
        console.error("연결 종료 에러:", err);
      }
    }
  }
});

// Spotify 이메일 제공 API
router.get("/getSpotifyUserData", (req, res) => {
  if (req.session.spotifyEmail) {
    res.json({ email: req.session.spotifyEmail });
  } else {
    res.json({ email: null });
  }
});

// Module로 사용하기 위한 설정
module.exports = router;
