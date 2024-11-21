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

async function getPlaylist(req,res) {
    return (await fetchSpotify.fetchWebApi(
        req, `v1/playlists/${ req.query.id }`, 'GET'
    ));
}

async function followPlaylist(req,res) {
    await fetchWebApi(
        req, `v1/playlists/${ req.query.id }/followers`, 'PUT'
    );
}

async function unfollowPlaylist(req,res) {
    await fetchWebApi(
        req, `v1/playlists/${ req.query.id }/followers`, 'DELETE'
    );
}

module.exports = {
    getPlaylist,
    followPlaylist,
    unfollowPlaylist
}