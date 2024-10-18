const search = require('../../models/spotify/search');

async function searchController(req,res) {
    const searchResults = await search.search(req,res);

    res.render('main',{albums: searchResults.albums.items});
}

module.exports = {
    searchController
}