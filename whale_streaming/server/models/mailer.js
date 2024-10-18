// server/models/mailer.js
const nodemailer = require('nodemailer');

const sendResetEmail = async (email, resetLink, userId) => {
  let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASS,
    }
  });

  let mailOptions = {
    from: `"Music Whale Support" <${process.env.EMAIL_USER}>`,
    to: email,
    subject: 'Whale 계정 비밀번호 재설정',
    text: `안녕하세요, ${userId}님.\n\n비밀번호 재설정을 위해 다음 링크를 클릭하세요:\n${resetLink}\n\n해당 링크는 1시간 동안 유효합니다.\n\n감사합니다.\nWhale 팀`
  };

  await transporter.sendMail(mailOptions);
};

module.exports = { sendResetEmail };
