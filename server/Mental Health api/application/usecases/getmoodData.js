const { mooddatainfo } = require("../../infrastructure/db-fast/queries/userQueries");
const UseCaseInt = require("../interfaces/UseCaseInt");

class MoodData extends UseCaseInt{

    async execute(username) {
        
        const moodData = await mooddatainfo(username);
        return moodData;
    }
}

module.exports = MoodData;