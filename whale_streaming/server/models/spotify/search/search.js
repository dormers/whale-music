const fetchSpotify = require('../dao/fetchSpotify');

async function search(req,res){
    const query = req.query.q;
    const type = req.query.t;

    const encodedQuery = encodeURIComponent(query);

    return (await fetchSpotify.fetchWebApi(
        req,`v1/search?q=${encodedQuery}&type=artist%2Calbum%2Ctrack%2Cplaylist`, 'GET'
    ));
}

module.exports = {
    search
}