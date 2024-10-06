const UserName = require("../../domain/entities/user");
const { mooddatainfo } = require("../../infrastructure/db-fast/queries/userQueries");
const UseCaseInt = require("../interfaces/UseCaseInt");

class MoodData extends UseCaseInt{

    async execute(username) {
        
        const moodData = await mooddatainfo(username);
        return moodData;
    //     return moodData.map((data) =>  new UserName (
    //    {
    //            happy: data.happy,
    //            sad: data.sad,
    //            neutral:  data.neutral,
    //            calm: data.calm,
    //            relax: data.relax,
    //            focus: data.focus,

    // }));
    }
}

module.exports = MoodData;