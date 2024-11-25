//
//  Recipe.swift
//  Fetch-RecipeApp
//
//  Created by JaredMurray on 11/24/24.
//

import Foundation
struct Recipe: Codable {
    var recipes: [MealDescription]
}

struct MealDescription: Codable {
    var cuisine: String
    var name: String
    var photoUrlLarge: String
    var photoUrlSmall: String
//    var sourceUrl: String
    var uuid: String
//    var youtubeUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name, cuisine,
             photoUrlLarge = "photo_url_large",
             photoUrlSmall = "photo_url_small",
//             sourceUrl = "source_url",
             uuid
//             youtubeUrl = "youtube_url"
    }
}


//var exampleMeal: Recipe {
//    .init(recipes: [.init(cuisine: "American", name: "Hot Dogs", photoUrlLarge: "", photoUrlSmall: "", sourceUrl: "", uuid: "hagsd", youtubeUrl: "")])
//}
