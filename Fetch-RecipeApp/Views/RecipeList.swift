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
        NavigationStack {
            VStack {
                foodList
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.inline) //Large title creates a visual glitch when using 'pull down to refresh'
            .onAppear {
                Task {
                    do {
                        food = try await fetcher.fetchRecipes()
                    } catch {
                        
                    }
                }
            }
        }
    }
    
    private var foodList: some View {
        List {
            ForEach(recipeSearch, id: \.uuid) { recipe in
                Text(recipe.name)
            }
        }
        .searchable(text: $vm.foodListSearch, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search for a recipe by name"))
        .refreshable {
            do {
                food = try await fetcher.fetchRecipes()
            } catch {
                
            }
        }
    }
    
    private var recipeSearch: [MealDescription] {
        if let food = food {
            if vm.foodListSearch.isEmpty {
                return food.recipes
            } else {
                return food.recipes.filter { $0.name.contains(vm.foodListSearch)}
            }
        } else {
            return []
        }
    }
}

#Preview {
    RecipeList()
}
