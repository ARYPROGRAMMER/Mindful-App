import LlamaAI from "llamaai";
const apiToken = 'YOUR_API_TOKEN';
const llamaAPI = new LlamaAI(apiToken);
const payload = {
    "messages": [
      {"role": "user", "content": "Extract the desired information from the following passage.:\n\nHi!"},
    ],
    "functions": [
          {'name': 'information_extraction',
           'description': 'Extracts the relevant information from the passage.',
           'parameters': {
               'type': 'object',
               'properties': {
                   'sentiment': {
                      'title': 'sentiment',
                      'type': 'string',
                      'description': 'the sentiment encountered in the passage'
                      },
                   'aggressiveness': {
                      'title': 'aggressiveness',
                      'type': 'integer',
                      'description': 'a 0-10 score of how aggressive the passage is'
                      },
                   'language': {
                      'title': 'language',
                      'type': 'string',
                      'description': 'the language of the passage'
                      }
               },
               'required': ['sentiment', 'aggressiveness', 'language']
           }
        }
      ],
    "stream": false,
    "function_call": {"name": "information_extraction"},
  };
  
  llamaAPI.run(payload)
  .then(response => {
    console.log(response);
  })
  .catch(error => {
    console.error(error);
  });