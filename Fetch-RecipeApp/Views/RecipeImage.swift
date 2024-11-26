//
//  RecipeImage.swift
//  Fetch-RecipeApp
//
//  Created by JaredMurray on 11/25/24.
//

import SwiftUI

struct RecipeImage: View {
    var fetcher = RecipesFetcher()
    var imageID: String
    @State private var recipeImage: UIImage? = nil
    
    var body: some View {
        VStack {
            if let recipeImage = recipeImage {
                Image(uiImage: recipeImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } else {
                ProgressView("Loading...")
            }
        }
        .task {
            await fetchImage()
        }
    }
    
    func fetchImage() async {
        guard let image = await fetcher.fetchImage(meal: imageID) else { return }
        recipeImage = image
    }
}
