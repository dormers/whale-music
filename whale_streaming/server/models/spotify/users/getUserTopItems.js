const fetchSpotify = require('../dao/fetchSpotify');

async function getUserTopItems(req,res) {
    return (await fetchSpotify.fetchWebApi(
        req, `v1/me/top/tracks?limit=10`, 'GET'
    ));
}

async function getUserRecentlyTrack(req,res) {
    return (await fetchSpotify.fetchWebApi(
        req, `v1/me/player/recently-played?limit=10`, 'GET'
    ));
}

async function getFeaturedPlaylist(req,res) {
    return (await fetchSpotify.fetchWebApi(
        req, `v1/browse/featured-playlists?limit=10`, 'GET'
    ));
}

async function getRecommendedArtist(req,res,x) {
    return (await fetchSpotify.fetchWebApi(
        req, `v1/artists/${x}/related-artists`, 'GET'
    ));
}

module.exports = {
    getUserTopItems,
    getUserRecentlyTrack,
    getFeaturedPlaylist,
    getRecommendedArtist
}