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
    var uuid: String
    
    enum CodingKeys: String, CodingKey {
        case name, cuisine,
             photoUrlLarge = "photo_url_large",
             photoUrlSmall = "photo_url_small",
             uuid
    }
}
