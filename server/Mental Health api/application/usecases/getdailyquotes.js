const Meditation = require("../../domain/entities/meditation");
const UseCaseInt = require("../interfaces/UseCaseInt");

class GetDailyQuotes extends UseCaseInt{
    constructor(quoteRepository){
        super();
        this.quoteRepository = quoteRepository;
    }

    async execute() {
        const quotesData = await this.quoteRepository.getDailyQuotes();
        return new Meditation({text: quotesData});
    }
}

module.exports = GetDailyQuotes;