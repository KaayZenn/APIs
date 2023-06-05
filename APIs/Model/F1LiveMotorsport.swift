//
//  F1LiveMotorsport.swift
//  APIs
//
//  Created by KaayZenn on 14/05/2023.
//

import Foundation

struct F1LiveMotorSportDriver: Codable, Hashable {
    let meta: MetaDataDriver
    let results: [Driver]
}

struct MetaDataDriver: Codable, Hashable {
    let title: String
    let description: String
    let fields: [String: String]
}

struct Driver: Codable, Hashable {
    let driverId: Int
    let driverName: String
    let teamId: Int
    let teamName: String
    let nationality: String
    let isReserve: Int
    let updated: String
    let season: Int
}
