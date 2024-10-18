// server.js

// [ Main Entry Point ]

// [ 1. Basic Setup ]
require('dotenv').config(); // dotenv 패키지로 환경 변수 로드

const express = require('express');
const session = require('express-session');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');

const https = require('https');
const fs = require('fs');
const path = require('path');
const PORT = process.env.PORT || 5500;

const authRoutes = require('./server/routes/login/authRoutes'); // 라우터 세팅
const mainRoutes = require('./server/routes/main/mainRoutes');


// [ 2. Express Middleware Setup: 미들웨어 설치 ]
const app = express();

// 1. CORS 설정 수정
app.use(cors({
 }));
 
 app.use(cookieParser())
    .use(bodyParser.json()) // 바디 파서 설정
    .use(bodyParser.urlencoded({ extended: true }))
    .use(session({ // 세션 설정
       secret: process.env.SESSION_SECRET,
       resave: false,
       saveUninitialized: true,
       cookie: {
         secure: true, // 개발 환경에서는 false, 배포 시 true로 변경
         sameSite: 'none', // 'strict', 'lax', 'none' 중에서 선택
       },
    }))
    .use(express.static(path.join(__dirname, 'public'))) // 정적 파일 제공
    .use(express.static(path.join(__dirname, 'client/dist')))
    .use((req, res, next) => { // 사용자 인증 확인 미들웨어: 라우터를 제외한 모든 주소 값 입력 시 login 페이지로 이동
       if (req.path.startsWith('/whale/')) {
         next();
       } else {
         res.redirect('/whale/');
       }
    })
    .use('/whale', authRoutes) // 라우터 세팅
    .use('/whale/streaming', mainRoutes)
    .use('/whale/streaming', express.static(path.join(__dirname, 'client/dist')));


// [ 3. SSL 인증서 로드 ]
const sslOptions = {
   key: fs.readFileSync(path.join(__dirname, 'ssl', 'server.key')),
   cert: fs.readFileSync(path.join(__dirname, 'ssl', 'server.crt')),
};


// [ 4. Server Listening: 서버 시작 ]
https.createServer(sslOptions, app).listen(PORT, () => {
  console.log(`HTTPS 서버가 포트 ${PORT}에서 실행 중입니다.`);
});
