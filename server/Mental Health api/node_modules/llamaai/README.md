# LlamaAPI Node.js Library

## How to Use

Follow these steps to use the LlamaAPI library:

1. Install the library via npm:

   ```bash
   npm install llamaai
   ```

2. Bring the library into your project:

   ```javascript
   import LlamaAI from 'llamaai';
   ```

3. Instantiate the LlamaAPI class, providing your API token:

   ```javascript
   const apiToken = 'INSERT_YOUR_API_TOKEN_HERE';
   const llamaAPI = new LlamaAI(apiToken);
   ```

4. Execute API requests using the `run` method:

   ```javascript
   const apiRequestJson = {
      "messages": [
          {"role": "user", "content": "What is the weather like in Boston?"},
      ],
      "functions": [
          {
              "name": "get_current_weather",
              "description": "Get the current weather in a given location",
              "parameters": {
                  "type": "object",
                  "properties": {
                      "location": {
                          "type": "string",
                          "description": "The city and state, e.g. San Francisco, CA",
                      },
                      "days": {
                          "type": "number",
                          "description": "for how many days ahead you wants the forecast",
                      },
                      "unit": {"type": "string", "enum": ["celsius", "fahrenheit"]},
                  },
              },
              "required": ["location", "days"],
          }
      ],
      "stream": false,
      "function_call": "get_current_weather",
     };
   
   
      llamaAPI.run(apiRequestJson)
        .then(response => {
          // Process the API response here
        })
        .catch(error => {
          // Handle any errors here
        });
   ```



And that's all! You can now utilize the LlamaAPI library in your project to communicate with the Llama API.

For additional details, please refer to the [API documentation](https://docs.llama-api.com).


