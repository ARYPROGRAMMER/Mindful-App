import axios from "axios";


class LlamaAI {
  constructor(apiToken, hostname = 'https://api.llama-api.com', domainPath = '/chat/completions') {
    this.hostname = hostname;
    this.domainPath = domainPath;
    this.apiToken = apiToken;
    this.headers = { Authorization: `Bearer ${this.apiToken}` };
    this.queue = [];
  }

  async makeRequest(apiRequestJson) {
    try {
      return await axios.post(`${this.hostname}${this.domainPath}`, apiRequestJson, { headers: this.headers });
    } catch (error) {
      throw new Error(`Error while making request: ${error.message}`);
    }
  }

  async _runStreamForJupyter(apiRequestJson) {
    const response = await this.makeRequest(apiRequestJson);

    for (const chunk of response.data) {
      this.queue.push(chunk);
    }
  }

  async *getSequences() {
    while (this.queue.length > 0) {
      yield this.queue.shift();
      await new Promise(resolve => setTimeout(resolve, 100));
    }
  }

  async runStream(apiRequestJson) {
    await this._runStreamForJupyter(apiRequestJson);
    this.getSequences();
  }

  async runSync(apiRequestJson) {
    const response = await this.makeRequest(apiRequestJson);

    if (response.status !== 200) {
      throw new Error(`POST ${response.status} ${response.data.detail}`);
    }

    return response.data;
  }

  run(apiRequestJson) {
    if (apiRequestJson.stream) {
      return this.runStream(apiRequestJson);
    } else {
      return this.runSync(apiRequestJson);
    }
  }
}

export default LlamaAI