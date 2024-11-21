const fetchSpotify = require('../dao/fetchSpotify');

async function getArtistInfo(req,res) {
    return (await fetchSpotify.fetchWebApi(
        req, `v1/artists/${ req.query.id }`, 'GET'
    ));
}

async function getArtistTopTrack(req,res) {
    return (await fetchSpotify.fetchWebApi(
        req, `v1/artists/${ req.query.id }/top-tracks`, 'GET'
    ));
}

async function getArtistAlbum(req,res) {
    return (await fetchSpotify.fetchWebApi(
        req, `v1/artists/${ req.query.id }/albums`, 'GET'
    ));
}

async function getArtistRelatedArtists(req,res) {
    return (await fetchSpotify.fetchWebApi(
        req, `v1/artists/${ req.query.id }/related-artists`, 'GET'
    ));
}

module.exports = {
    getArtistInfo,
    getArtistTopTrack,
    getArtistAlbum,
    getArtistRelatedArtists
}