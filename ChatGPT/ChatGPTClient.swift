//
//  ChatGPTClient.swift
//  ChatGPT
//
//  Created by Nurzhan Ababakirov on 5/4/23.
//

import Alamofire

class ChatGPTClient {
    let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
        
    }
    
    func askQuestion(question: String, completion: @escaping (String?, Error?) -> Void) {
        let url = "https://api.openai.com/v1/engines/davinci-codex/completions"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        let parameters: Parameters = [
            "prompt": question,
            "max_tokens": 100,
            "n": 1,
            "stop": "\n",
            "temperature": 0.7
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any],
                       let choices = json["choices"] as? [[String: Any]],
                       let text = choices.first?["text"] as? String {
                        completion(text, nil)
                    } else {
                        completion(nil, NSError(domain: "ChatGPTClient", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"]))
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
}
