// [ 1. Basic Setup ]
const express = require('express');
const router = express.Router();
const path = require('path');

// 컨트롤러 객체 생성
const contentsService = require('../../service/spotify/contentsService');
const libraryService = require('../../service/spotify/libraryService');
const playlistService = require('../../service/spotify/playlistService');
const playerService = require('../../service/spotify/playerService');
const infoService = require('../../service/spotify/infoService');
const searchService = require('../../service/spotify/searchService');


// [ 2. 라우터 사용 ]
router.get('/', (req, res) => {
    // Spring 서버 로그인시 세션에 저장
    req.session.accessToken = req.query.accessToken;
    req.session.user_id = req.query.userId;
    req.session.type = req.query.type;
    req.session.type_id = req.query.id;
    res.sendFile(path.join(__dirname, '../../../client/dist/index.html'));
});


router.post('/getDeviceId', (req, res) => {
    const { device_id } = req.body;
    req.session.device_id = device_id;
    res.json({ accessToken: req.session.accessToken, userId: req.session.user_id });
});

router.get('/getContents', async (req, res) => {
    const results = await contentsService.contentsService(req, res);
    res.json(results);
});

router.get('/getType', async (req, res) => {
    res.json({ type: req.session.type, id: req.session.type_id });
});

router.get('/getLibraries', async (req, res) => {
    const results = await libraryService.libraryService(req, res);
    res.json(results);
});

router.get('/getPlaylist', async (req, res) => {
    const results = await playlistService.playlistService(req, res);
    res.json(results);
});

router.get('/followPlaylist', async (req, res) => {
    const results = await playlistService.followPlaylistService(req, res);
    res.json(results);
});

router.get('/unfollowPlaylist', async (req, res) => {
    const results = await playlistService.unfollowPlaylistService(req, res);
    res.json(results);
});

router.get('/play', async (req, res) => {
    const results = await playerService.playerService(req, res);
    res.json(results);
});

router.post('/plays', async (req, res) => {
    const results = await playerService.playerService(req, res);
    res.json(results);
});

router.get('/pause', async (req, res) => {
    const results = await playerService.playerPauseService(req, res);
    res.json(results);
});

router.get('/getTrackInfo', async (req, res) => {
    const results = await infoService.trackInfoService(req, res);
    res.json(results);
});

router.get('/getArtistInfo', async (req, res) => {
    const results = await infoService.artistInfoService(req, res);
    res.json(results);
});

router.get('/getArtistTopTrack', async (req, res) => {
    const results = await infoService.artistTopTrackService(req, res);
    res.json(results);
});

router.get('/getArtistAlbum', async (req, res) => {
    const results = await infoService.artistAlbumService(req, res);
    res.json(results);
});

router.get('/getArtistPlaylist', async (req, res) => {
    const results = await searchService.searchService(req, res);
    res.json(results);
});

router.get('/getAlbumInfo', async (req, res) => {
    const results = await infoService.albumInfoService(req, res);
    res.json(results);
});


// [ 3. Module로 사용하기 위한 설정 ]
module.exports = router;