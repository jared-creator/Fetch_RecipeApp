//
//  ContentView.swift
//  Fetch-RecipeApp
//
//  Created by JaredMurray on 11/24/24.
//

import SwiftUI

struct RecipeList: View {
    @State private var food: Recipe? = nil
    @State private var vm = RecipeListViewModel()
    var fetcher = RecipesFetcher()
    
    var body: some View {
        VStack {
            foodList
        }
        .onAppear {
            Task {
                do {
                    food = try await fetcher.fetchRecipes()
                } catch {
                    
                }
            }
        }
    }
    
    private var foodList: some View {
        List {
            if let food = food {
                ForEach(food.recipes, id: \.uuid) { recipe in
                    Text(recipe.name)
                }
            }
        }
        .refreshable {
            do {
                food = try await fetcher.fetchRecipes()
            } catch {
                
            }
        }
    }
}

#Preview {
    RecipeList()
}
