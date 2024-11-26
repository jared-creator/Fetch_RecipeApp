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
    @State private var recipeImage: UIImage? = nil
    var fetcher = RecipesFetcher()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if vm.reloadingData == false {
                        FoodList
                    } else {
                        ProgressView("Fetching Recipes")
                            .foregroundStyle(.pink)
                    }
                }
                .navigationTitle("Recipes")
                .navigationBarTitleDisplayMode(.inline) //Large title creates a visual glitch when using 'pull down to refresh'
                .onAppear {
                    Task {
                        do {
                            food = try await fetcher.fetchRecipes()
                        } catch {
                            print(error)
                        }
                    }
                    UIRefreshControl.appearance().tintColor = .systemPink
                    UISearchBar.appearance().tintColor = .systemPink
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("", selection: $vm.cuisineSelection) {
                                ForEach(Cuisine.allCases, id: \.id) { cuisine in
                                    Text(cuisine.rawValue)
                                        .tag(cuisine)
                                }
                            }
                        }
                        .tint(.pink)
                    }
                }
                
            }
        }
    }
    
    private var FoodList: some View {
        VStack {
            if !recipeSearch.isEmpty {
                List {
                    Section {
                        ForEach(recipeSearch, id: \.uuid) { recipe in
                            HStack {
                                RecipeImage(imageID: recipe.uuid)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(recipe.name)
                                        .bold()
                                    
                                    Text(recipe.cuisine)
                                        .font(.subheadline).italic()
                                }
                            }
                            .listRowBackground(Color.clear)
                        }
                    } header: {
                    }
                    .padding(.bottom, 10)
                }                
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .listStyle(.inset)
                .searchable(text: $vm.foodListSearch, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search for a recipe by name"))
                .refreshable {
                    do {
                        food = try await fetcher.fetchRecipes()
                    } catch {
                        
                    }
                }
            } else {
                ContentUnavailableView {
                    Image(systemName: "fork.knife.circle.fill")
                        .font(.system(size: 100))
                } description: {
                    Text("No recipes were found.")
                        .font(.headline)
                } actions: {
                    Button("Refresh") {
                        Task {
                            do {
                                food = try await fetcher.fetchRecipes()
                                vm.reloadingData.toggle()
                                if !vm.foodListSearch.isEmpty {
                                    vm.foodListSearch = ""
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    vm.reloadingData.toggle()
                                }
                            } catch {
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var recipeSearch: [MealDescription] {
        if let food = food {
            if vm.foodListSearch.isEmpty {
                switch vm.cuisineSelection {
                case .All:
                    return food.recipes
                case .American:
                    return food.recipes.filter { $0.cuisine == Cuisine.American.rawValue }
                case .British:
                    return food.recipes.filter { $0.cuisine == Cuisine.British.rawValue }
                case .Canadian:
                    return food.recipes.filter { $0.cuisine == Cuisine.Canadian.rawValue }
                case .Croatian:
                    return food.recipes.filter { $0.cuisine == Cuisine.Croatian.rawValue }
                case .French:
                    return food.recipes.filter { $0.cuisine == Cuisine.French.rawValue }
                case .Greek:
                    return food.recipes.filter { $0.cuisine == Cuisine.Greek.rawValue }
                case .Italian:
                    return food.recipes.filter { $0.cuisine == Cuisine.Italian.rawValue }
                case .Malaysian:
                    return food.recipes.filter { $0.cuisine == Cuisine.Malaysian.rawValue }
                case .Polish:
                    return food.recipes.filter { $0.cuisine == Cuisine.Polish.rawValue }
                case .Portuguese:
                    return food.recipes.filter { $0.cuisine == Cuisine.Portuguese.rawValue }
                case .Russian:
                    return food.recipes.filter { $0.cuisine == Cuisine.Russian.rawValue }
                case .Tunisian:
                    return food.recipes.filter { $0.cuisine == Cuisine.Tunisian.rawValue }
                }
            } else {
                switch vm.cuisineSelection {
                case .All:
                    return food.recipes.filter { $0.name.contains(vm.foodListSearch) }
                case .American:
                    return food.recipes.filter { $0.name.contains(vm.foodListSearch) && $0.cuisine == Cuisine.American.rawValue }
                case .British:
                    return food.recipes.filter { $0.name.contains(vm.foodListSearch) && $0.cuisine == Cuisine.British.rawValue }
                case .Canadian:
                    return food.recipes.filter { $0.name.contains(vm.foodListSearch) && $0.cuisine == Cuisine.Canadian.rawValue }
                case .Croatian:
                    return food.recipes.filter { $0.name.contains(vm.foodListSearch) && $0.cuisine == Cuisine.Croatian.rawValue }
                case .French:
                    return food.recipes.filter { $0.name.contains(vm.foodListSearch) && $0.cuisine == Cuisine.French.rawValue }
                case .Greek:
                    return food.recipes.filter { $0.name.contains(vm.foodListSearch) && $0.cuisine == Cuisine.Greek.rawValue }
                case .Italian:
                    return food.recipes.filter { $0.name.contains(vm.foodListSearch) && $0.cuisine == Cuisine.Italian.rawValue }
                case .Malaysian:
                    return food.recipes.filter { $0.name.contains(vm.foodListSearch) && $0.cuisine == Cuisine.Malaysian.rawValue }
                case .Polish:
                    return food.recipes.filter { $0.name.contains(vm.foodListSearch) && $0.cuisine == Cuisine.Polish.rawValue }
                case .Portuguese:
                    return food.recipes.filter { $0.name.contains(vm.foodListSearch) && $0.cuisine == Cuisine.Portuguese.rawValue }
                case .Russian:
                    return food.recipes.filter { $0.name.contains(vm.foodListSearch) && $0.cuisine == Cuisine.Russian.rawValue }
                case .Tunisian:
                    return food.recipes.filter { $0.name.contains(vm.foodListSearch) && $0.cuisine == Cuisine.Tunisian.rawValue }
                }
            }
        } else {
            return []
        }
    }
}

#Preview {
    RecipeList()
}
