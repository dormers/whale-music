// [ 1. Basic Setup ]
const express = require('express');
const router = express.Router();
const path = require('path');

// 컨트롤러 객체 생성
const contentsController = require('../../controllers/spotify/contentsController');


// [ 2. 라우터 사용 ]
router.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../../../client/dist/index.html'));
});


router.post('/getDeviceId', (req, res) => {
    const { device_id } = req.body;
    req.session.device_id = device_id;
    res.json({ accessToken: req.session.accessToken });
});

router.get('/getContents', async (req, res) => {
    const results = await contentsController.contentsController(req, res);
    res.json(results);
});


// [ 3. Module로 사용하기 위한 설정 ]
module.exports = router;