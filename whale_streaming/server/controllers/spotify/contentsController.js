const getUserTopItems = require('../../models/spotify/users/getUserTopItems');

async function contentsController(req,res) {
    const results = await getUserTopItems.getUserTopItems(req,res);
    return results;
}

module.exports = {
    contentsController
}