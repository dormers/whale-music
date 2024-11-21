const fetchSpotify = require('../dao/fetchSpotify');

async function getUserLibraries(req,res) {
    return (await fetchSpotify.fetchWebApi(
        req, `v1/me/playlists`, 'GET'
    ));
}

module.exports = {
    getUserLibraries
}