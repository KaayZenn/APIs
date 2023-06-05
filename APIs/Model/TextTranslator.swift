//
//  TextTranslator.swift
//  APIs
//
//  Created by KaayZenn on 14/05/2023.
//

import Foundation

struct TextTranslator: Codable {
    let status: String
    let data: TranslationData
}

struct TranslationData: Codable {
    let translatedText: String
}
