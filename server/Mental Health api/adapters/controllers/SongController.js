const GetSongs = require("../../application/usecases/getsongs");

class SongController {
    static async all(req,res){
        try{
            const getSongs = new GetSongs();
            const songs = await getSongs.execute();
     
            return res.json(songs);
       }
        catch(err){
            res.status(500).json({error: err.message});
        }
    }
}

module.exports = SongController;