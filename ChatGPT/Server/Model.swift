//
//  Model.swift
//  ChatGPT
//
//  Created by Nurzhan Ababakirov on 5/4/23.
//

import Foundation

struct OpenAICompletionsBody: Encodable{
    let model: String
    let prompt: String
    let temperature: Float?
    let max_tokens: Int
}

struct OpenAICompletionsResponse: Decodable{
    let id: String
    let choices: [OpenAICompletionsChoise]
}

struct OpenAICompletionsChoise: Decodable{
    let text: String
}

