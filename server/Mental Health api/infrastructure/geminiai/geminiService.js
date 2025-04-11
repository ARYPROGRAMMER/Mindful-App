const { GoogleGenerativeAI } = require("@google/generative-ai");
const QuoteRepository = require("../../application/interfaces/QuotesRepostitory");
OPENAI_API_KEY = "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"
// ANTROPIC_API_KEY = "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"
const genAi = new GoogleGenerativeAI("AIzaSyBd6AiBrx_5Kt1vQwAtDfHOqt1AztpoZ2s");
const model = genAi.getGenerativeModel({model: "gemini-1.5-flash"});


// const { Anthropic } = require('@anthropic-ai/sdk');

// const anthropic = new Anthropic({
//   apiKey: ANTROPIC_API_KEY, // defaults to process.env["ANTHROPIC_API_KEY"]
// });

// const { OpenAI } = require('openai');
// const openai  =  new OpenAI({
//     apiKey: OPENAI_API_KEY, // This is the default and can be omitted
//   });
//   const generateText = async (prompt) => {
//     // Make a call to the createCompletion method of the OpenAIApi class
//     // and pass in an object with the desired parameters
//     // const response = await openai.createCompletion({
//     //     model: 'text-davinci-003', // specify the model to use
//     //     prompt: prompt, // specify the prompt
//     //     temperature: 0.8, // specify the randomness of the generated text
//     //     max_tokens: 800, // specify the maximum number of tokens to generate
//     // });

//     const chatCompletion = await openai.chat.completions.create({
//         messages: [{ role: 'user', content: prompt}],
//         model: 'gpt-3.5-turbo',
//       });

//     // Return the generated text from the response
//     return chatCompletion;
// }

// LAMA_API_KEY = "LA-6d926628488d413daecb7f218e267777c45a3fde4ee9404fa50e052db0210420"

// const LlamaAI = require('llamaai');

// const apiToken = LAMA_API_KEY;
// const llamaAPI = new LlamaAI(apiToken);

GROQ_LLAMA_KEY="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"
const { Groq } = require('groq-sdk');

const groq = new Groq({ apiKey:GROQ_LLAMA_KEY });

class GeminiApi extends QuoteRepository{
   

    async getAdviceByMood(mood){
        // This method is responsible for fetching advice by mood
        const prompt = `
        
        Given the current mood of the user,provide an approapriate meditation advice or mental health exercise.Your response should be concise and precise alongwith emotional and sentimental analysis aspect taken into consideration The possible structure with the following format: 
        "Your advice here or mental health exercise here"
        }

        For example, if the mood is "happy", the response could be: 

        "You are doing great! Keep up the good work and stay positive"
        
        if mood is "sad", the response could be:
        "It's okay to feel sad sometimes. Remember to take care of yourself and reach out to someone you trust for support"
          
        so the mood of the user is : ${mood}
        
        onrefresh provide new advice on each request

        return only the string no brackets no keyword no JSON nothing

        `;

        // // Build the Request
        // const apiRequestJson = {
        //     "messages": [
        //         {"role": "user", "content": prompt},
        //     ],
            
        //     "stream": false,
    
        // };
        
        // // Execute the Request
        //     llamaAPI.run(apiRequestJson)
        //     .then(response => {
        //         return response;
        //         // Process response
        //     })
        //     .catch(error => {
        //         // Handle errors
        //         return error;
        //     });
         
        // const result = await anthropic.messages.create({
        //     model: "claude-3-5-sonnet",
        //     max_tokens: 1024,
        //     messages: [{ role: "user", content: prompt }],
        // });



        // const result = generateText(prompt);
        

        const res = await groq.chat.completions.create({
            messages: [
              {
                role: "user",
                content: prompt,
              },
            ],
            model: "qwen-2.5-32b",
   
            temperature: 1,
            max_tokens: 2048,
        
            
        });
       
        return res.choices[0].message.content;

        // const result = await model.generateContent(prompt);
        // const response = await result.response;
        // const text = response.text();
        // return text;
    }

    async getDailyQuotes(){
        // This method is responsible for fetching daily quotes
        const prompt = `
        Please provide three inspirational quotes for meditation, one for each part of the day: morning, noon and evening.Return the Json format with the following structure:
        
        Reference structure:    {
                                    morningQuote: "Your morning quote here",
                                    noonQuote: "Your noon quote here",
                                    eveningQuote: "Your evening quote here"
                                }
        Provide concise and precise quotes that are inspirational and motivational. The quotes should be different for each part of the day.

        do not include any source code in the response and omit the word json in the response also provide new quotes on each request
   
        `;


        const res = await groq.chat.completions.create({
            messages: [
              {
                role: "system",
                content: prompt,
              },
            ],
            model: "qwen-2.5-32b",
            response_format: { type: "json_object" },
            temperature: 1,
            max_tokens: 2048,
        
            
        });
       
        return res.choices[0].message.content;
        // const result = await model.generateContent(prompt);
        // const response = await result.response;
        // const text = response.text();
        // return text;

    }

}

module.exports = GeminiApi;
