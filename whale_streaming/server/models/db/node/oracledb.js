// [ 1. Basic Setup ]
const oracledb = require('oracledb');                                                 // OracleDB 설치

// Oracle DB 연결 정보
const dbConfig = {
  user: process.env.DB_USER,                                                          // 환경 변수에서 가져오기
  password: process.env.DB_PASSWORD,                                                  // 환경 변수에서 가져오기
  connectString: process.env.DB_ADDRESS,                                              // 환경 변수에서 가져오기
};

// Oracle Instant Client 환경 변수 경로 추가. 필요하지 않다면 지우세요. 만약 이를 이용하고 싶다면 자신의 instantclient_12_2 폴더 경로를 추가하세요.
oracledb.initOracleClient({ libDir: process.env.instantAddress });

// Ctrl+C가 제대로 작동하지 않을 경우 사용됩니다.
process.on('SIGINT', async () => {
  try {
    process.exit(0);                                                        // Exit the process
  } catch (err) {
    console.error("Error when closing the server:", err);
    process.exit(1);                                                        // Exit with an error code
  }
});


// [ 2. Module로 사용하기 위한 설정 ]
module.exports = {
  oracledb,
  dbConfig,
}