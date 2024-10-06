
const Song = require("../../domain/entities/song");
const { getAllSongs } = require("../../infrastructure/db/queries/songQueries");
const UseCaseInt = require("../interfaces/UseCaseInt");

class GetSongs extends UseCaseInt{
    async execute() {
        
        const songRows = await getAllSongs();
        return songRows.map((song) =>  new Song (
       {
                id: song.id,
                imageid : song.imageid,
                title: song.title,
                author:  song.author,
                songlink : song.songlink,

    }));
    }
}

module.exports = GetSongs;