class QuoteRepository{

    async getDailyQuotes(){
        throw new Error('ERR_METHOD_NOT_IMPLEMENTED');
    }

    async getAdviceByMood(mood){
        throw new Error('ERR_METHOD_NOT_IMPLEMENTED');
    }
}

module.exports = QuoteRepository;