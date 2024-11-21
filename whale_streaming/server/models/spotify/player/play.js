const fetchSpotify = require('../dao/fetchSpotify');

async function fetchWebApi(req, endpoint, method, body) {
    await fetch(`https://api.spotify.com/${endpoint}`, {
        headers: {
            Authorization: `Bearer ${req.session.accessToken}`,
            'Content-Type': 'application/json',
        },
        method,
        body:JSON.stringify(body)
    });
}

async function play(req,res){
    await fetchWebApi(
        req,
        `v1/me/player/play?device_id=${ req.query.device_id }`,
        'PUT',
        {
            "context_uri": `${ req.query.uri }`
        }
    );
}

async function playTrack(req,res){
    await fetchWebApi(
        req,
        `v1/me/player/play?device_id=${ req.query.device_id }`,
        'PUT',
        {
            "uris": [ `${ req.query.uri }` ],
            "position_ms": req.query.position
        }
    );
}

async function playTracks(req,res){
    await fetchWebApi(
        req, `v1/me/player/play?device_id=${ req.body.device_id }`, 'PUT', { "uris": req.body.uri }
    );
}

async function pauseTrack(req,res){
    await fetchWebApi(
        req, `v1/me/player/pause?device_id=${ req.query.device_id }`, 'PUT'
    );
}

async function getPlayback(req,res){
    return (await fetchSpotify.fetchWebApi(
        req, `v1/me/player`, 'GET'
    ));
}

module.exports = {
    play,
    playTrack,
    playTracks,
    pauseTrack,
    getPlayback
}