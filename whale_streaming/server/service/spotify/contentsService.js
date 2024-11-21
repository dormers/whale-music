const getUserTopItems = require('../../models/spotify/users/getUserTopItems');

async function contentsService(req,res) {
    let results = [[],[],[],[]];
    results[0] = await getUserTopItems.getUserTopItems(req,res);
    const temp = await getUserTopItems.getUserRecentlyTrack(req,res);
    const buff= []
    temp.items.forEach((el) => {
        if (!buff.includes(el.track.id)) {
            buff.push(el.track.id);
            results[1].push(el.track);
        }
    });
    results[2] = await getUserTopItems.getFeaturedPlaylist(req,res);
    results[3] = await getUserTopItems.getRecommendedArtist(req,res,results[1][0].artists[0].id);
    return results;
}

module.exports = {
    contentsService
}