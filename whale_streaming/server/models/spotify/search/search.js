const fetchSpotify = require('../dao/fetchSpotify');

async function search(req,res){
    const query = req.query.q;
    const type = req.query.t;

    const encodedQuery = encodeURIComponent(query);

    return (await fetchSpotify.fetchWebApi(
        `v1/search?q=${encodedQuery}&type=${type}`, 'GET'
    ));
}

module.exports = {
    search
}