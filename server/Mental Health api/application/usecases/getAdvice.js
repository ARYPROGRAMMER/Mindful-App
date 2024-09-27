const UseCaseInt = require("../interfaces/UseCaseInt");

class GetAdviceByMood extends UseCaseInt{
    constructor(adviceRepository){
        super();
        this.adviceRepository = adviceRepository;
    }

    async execute(mood) {
        const adviceData = await this.adviceRepository.getAdviceByMood(mood);
        return adviceData;
    }
}

module.exports = GetAdviceByMood;