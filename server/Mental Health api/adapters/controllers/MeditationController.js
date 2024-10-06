const GetAdviceByMood = require("../../application/usecases/getAdvice");
const GetDailyQuotes = require("../../application/usecases/getdailyquotes");
const GeminiApi = require("../../infrastructure/geminiai/geminiService");

class MeditationController{

    static async dailyQuotes(req,res){
        try{

            const quotesRepository = new GeminiApi();
            const getDailyQuotes = new GetDailyQuotes(quotesRepository);
            const quotes = await getDailyQuotes.execute();
           return res.json(quotes);

        }
        catch(err){
            res.status(500).json({error: err.message});
        }
    }

    
    static async myMood(req,res){
        try{
            
            const { mood }= req.params;
            const quotesRepository = new GeminiApi();

            const getAdviceByMood = new GetAdviceByMood(quotesRepository);
            const advice = await getAdviceByMood.execute(mood);
            return res.json(advice);

        }
        catch(err){
            res.status(500).json({error: err.message});
        }
    }
}

module.exports = MeditationController;