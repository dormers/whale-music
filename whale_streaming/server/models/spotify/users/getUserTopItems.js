const fetchSpotify = require('../dao/fetchSpotify');

async function getUserTopItems(req,res) {
    return (await fetchSpotify.fetchWebApi(
        req, `v1/me/top/tracks?limit=5`, 'GET'
    ));
}

module.exports = {
    getUserTopItems
}