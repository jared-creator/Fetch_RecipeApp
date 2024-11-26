//
//  RecipeListViewModel.swift
//  Fetch-RecipeApp
//
//  Created by JaredMurray on 11/24/24.
//

import Foundation
import SwiftUI

@Observable
class RecipeListViewModel {
    var foodListSearch = ""
    var reloadingData = false
    var columns = Array(repeating: GridItem(.flexible()), count: 2)    
    var cuisineSelection: Cuisine = .All
}

enum Cuisine: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case All
    case American
    case British
    case Canadian
    case Croatian
    case French
    case Greek
    case Italian
    case Malaysian
    case Polish
    case Portuguese
    case Russian
    case Tunisian
}
