const trackInfo = require('../../models/spotify/info/getTrackInfo');
const artistInfo = require('../../models/spotify/info/getArtistInfo');
const albumInfo = require('../../models/spotify/info/getAlbumInfo');

async function trackInfoService(req,res) {
    const results = await trackInfo.getTrackInfo(req,res);
    return results;
}

async function artistInfoService(req,res) {
    const results = await artistInfo.getArtistInfo(req,res);
    return results;
}

async function artistTopTrackService(req,res) {
    const results = await artistInfo.getArtistTopTrack(req,res);
    return results;
}

async function artistAlbumService(req,res) {
    const results = await artistInfo.getArtistAlbum(req,res);
    return results;
}

async function artistRelatedArtistsService(req,res) {
    const results = await artistInfo.getArtistRelatedArtists(req,res);
    return results;
}

async function albumInfoService(req,res) {
    const results = await albumInfo.getAlbumInfo(req,res);
    return results;
}

module.exports = {
    trackInfoService,
    artistInfoService,
    artistTopTrackService,
    artistAlbumService,
    artistRelatedArtistsService,
    albumInfoService
}