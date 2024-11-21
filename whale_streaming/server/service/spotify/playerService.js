const play = require('../../models/spotify/player/play');

async function playerService(req,res) {
    if (req.body.uri) {await play.playTracks(req,res);}
    else if (req.query.uri.substring(8,13) === 'track') {await play.playTrack(req,res);}
    else {await play.play(req,res);}
}

async function playerPauseService(req,res) {
    await play.pauseTrack(req,res);
    const results = await play.getPlayback(req,res);
    return results;
}

module.exports = {
    playerService,
    playerPauseService
}