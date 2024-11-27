//
//  RecipesDecoder.swift
//  Fetch-RecipeApp
//
//  Created by JaredMurray on 11/24/24.
//

import Foundation
import UIKit

actor RecipesFetcher {
    static let shared = RecipesFetcher()
    private static let cache = NSCache<NSString, UIImage>()
        
    var recipes: Recipe? = nil
    
    func fetchRecipes(session: URLSession = .shared) async throws -> Recipe {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            throw FRError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FRError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            recipes = try decoder.decode(Recipe.self, from: data)
            for i in 0..<recipes!.recipes.count {
                try await cacheImage(image: recipes!.recipes[i].photoUrlLarge, meal: recipes!.recipes[i].uuid)                
            }
            return recipes!
        } catch {
            throw FRError.invalidData
        }
    }
    
    func cacheImage(image url: String, meal id: String, session: URLSession = .shared) async throws {
        guard let imageURL = URL(string: url) else {
            throw FRError.invalidURL
        }
        
        let (data, response) = try await session.data(from: imageURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FRError.invalidResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw FRError.invalidData
        }
        
        Self.cache.setObject(image, forKey: id as NSString)
    }
    
    func fetchImage(meal id: String) -> UIImage? {
        if let cachedImage = Self.cache.object(forKey: id as NSString) {
            return cachedImage
        } else {
            return nil
        }
    }
}

// Full Data https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json
//Malformed Data URL https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json
// Empty Data: https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json
