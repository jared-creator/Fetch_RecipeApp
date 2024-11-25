//
//  RecipesDecoder.swift
//  Fetch-RecipeApp
//
//  Created by JaredMurray on 11/24/24.
//

import Foundation

actor RecipesFetcher {
    static let shared = RecipesFetcher()
    
    var recipes: Recipe? = nil
    
    func fetchRecipes() async throws -> Recipe {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            throw FRError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FRError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            recipes = try decoder.decode(Recipe.self, from: data)
            return recipes!
        } catch {
            throw FRError.invalidData
        }
    }
    
    
}
