//
//  Currency.swift
//  APIs
//
//  Created by KaayZenn on 12/05/2023.
//

import Foundation

struct Currency: Codable {
    var newAmount: Double
    var newCurrency: String
    var oldCurrency: String
    var oldAmount: Double
}
