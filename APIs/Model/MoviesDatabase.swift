//
//  MoviesDatabase.swift
//  APIs
//
//  Created by KaayZenn on 12/05/2023.
//

import Foundation

struct ApiResponse: Decodable, Hashable {
    let page: Int
    let next: String
    let entries: Int
    let results: [Movie]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(page)
        hasher.combine(next)
        hasher.combine(entries)
        hasher.combine(results)
    }
    
    static func == (lhs: ApiResponse, rhs: ApiResponse) -> Bool {
        return lhs.page == rhs.page &&
            lhs.next == rhs.next &&
            lhs.entries == rhs.entries &&
            lhs.results == rhs.results
    }
}

struct Movie: Decodable, Hashable {
    let id: String
    let primaryImage: PrimaryImage?
    let titleType: TitleType
    let titleText: TitleText
    let releaseYear: ReleaseYear
    let releaseDate: ReleaseDate
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(primaryImage)
        hasher.combine(titleType)
        hasher.combine(titleText)
        hasher.combine(releaseYear)
        hasher.combine(releaseDate)
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id &&
            lhs.primaryImage == rhs.primaryImage &&
            lhs.titleType == rhs.titleType &&
            lhs.titleText == rhs.titleText &&
            lhs.releaseYear == rhs.releaseYear &&
            lhs.releaseDate == rhs.releaseDate
    }
}

struct PrimaryImage: Decodable, Hashable {
    let id: String
    let width: Int
    let height: Int
    let url: String
    let caption: Caption
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(width)
        hasher.combine(height)
        hasher.combine(url)
        hasher.combine(caption)
    }
    
    static func == (lhs: PrimaryImage, rhs: PrimaryImage) -> Bool {
        return lhs.id == rhs.id &&
            lhs.width == rhs.width &&
            lhs.height == rhs.height &&
            lhs.url == rhs.url &&
            lhs.caption == rhs.caption
    }
}

struct Caption: Decodable, Hashable {
    let plainText: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(plainText)
    }
    
    static func == (lhs: Caption, rhs: Caption) -> Bool {
        return lhs.plainText == rhs.plainText
    }
}

struct TitleType: Decodable, Hashable {
    let displayableProperty: DisplayableProperty
    let text: String
    let id: String
    let isSeries: Bool
    let isEpisode: Bool
    let categories: [Category]
    let canHaveEpisodes: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(displayableProperty)
        hasher.combine(text)
        hasher.combine(id)
        hasher.combine(isSeries)
        hasher.combine(isEpisode)
        hasher.combine(categories)
        hasher.combine(canHaveEpisodes)
    }
    
    static func == (lhs: TitleType, rhs: TitleType) -> Bool {
        return lhs.displayableProperty == rhs.displayableProperty &&
            lhs.text == rhs.text &&
            lhs.id == rhs.id &&
            lhs.isSeries == rhs.isSeries &&
            lhs.isEpisode == rhs.isEpisode &&
            lhs.categories == rhs.categories &&
            lhs.canHaveEpisodes == rhs.canHaveEpisodes
    }
}

struct DisplayableProperty: Decodable, Hashable {
    let value: Value
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
    
    static func == (lhs: DisplayableProperty, rhs: DisplayableProperty) -> Bool {
        return lhs.value == rhs.value
    }
}

struct Value: Decodable, Hashable {
    let plainText: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(plainText)
    }
    
    static func == (lhs: Value, rhs: Value) -> Bool {
        return lhs.plainText == rhs.plainText
    }
}

struct Category: Decodable, Hashable {
    let value: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.value == rhs.value
    }
}

struct TitleText: Decodable, Hashable {
    let text: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
    
    static func == (lhs: TitleText, rhs: TitleText) -> Bool {
        return lhs.text == rhs.text
    }
}

struct ReleaseYear: Decodable, Hashable {
    let year: Int
    let endYear: Int?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(year)
        hasher.combine(endYear)
    }
    
    static func == (lhs: ReleaseYear, rhs: ReleaseYear) -> Bool {
        return lhs.year == rhs.year &&
            lhs.endYear == rhs.endYear
    }
}

struct ReleaseDate: Decodable, Hashable {
    let day: Int
    let month: Int
    let year: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(day)
        hasher.combine(month)
        hasher.combine(year)
    }
    
    static func == (lhs: ReleaseDate, rhs: ReleaseDate) -> Bool {
        return lhs.day == rhs.day &&
            lhs.month == rhs.month &&
            lhs.year == rhs.year
    }
}
