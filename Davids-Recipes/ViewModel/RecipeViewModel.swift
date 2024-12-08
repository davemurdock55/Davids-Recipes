//
//  RecipeViewModel.swift
//  Davids-Recipes
//
//  Created by David Murdock on 11/21/24.
//

import SwiftUI
import SwiftData

@Observable
class RecipeViewModel {
    // MARK: - Properties
    private var modelContext: ModelContext

    // MARK: - Initialization
    init(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchData()
    }

    // MARK: - Model access
    private(set) var recipes: [Recipe] = []
    private(set) var favorites: [Recipe] = []
    var imageData: Data?
//    private(set) var categories: [Recipe] = []
    
//    func recipes(for category: String) -> [Recipe] {
//        return recipes.filter{
//            $0.categories.contains(category)
//        }
//    }

    // MARK: - User Intents
    func filterRecipes(by filterText: String) -> [Recipe] {
        switch filterText {
            case "All Recipes":
                return recipes
            case "Favorites":
                return favorites
            default:
                return recipes.filter { $0.categories.contains(filterText) }
        }
    }

    func addRecipe(_ newRecipe: Recipe) {
        withAnimation {
            modelContext.insert(newRecipe)
            fetchData()
        }
    }
    
    func editRecipe(_ updatedRecipe: Recipe) {
        withAnimation {
            modelContext.insert(updatedRecipe)
            try? modelContext.save()
            fetchData()
        }
    }

    func toggleFavorite(for recipe: Recipe) {
        withAnimation {
            recipe.isFavorite.toggle()
            try? modelContext.save()
            fetchFavorites()
        }
    }

    func deleteRecipes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(recipes[index])
            }
            fetchData()
        }
    }
    
    // AI helped me switch from using an Async Image by giving me this code (since I found out that apparently AsyncImage is very buggy after doing some research)
    func loadImage(for recipe: Recipe) {
        guard let url = URL(string: recipe.imageUrl) else { return }
        
        // Perform a URLSession request to fetch the image and reset cache
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imageData = data
            }
        }.resume()
    }
    
    
    // MARK: - Private Helpers
    private func fetchData() {
        try? modelContext.save()

        fetchAllRecipes()
        fetchFavorites()
//        fetchAllCategories()
        
        if recipes.isEmpty {
            sampleRecipes.forEach { modelContext.insert($0) }
            fetchAllRecipes()
            fetchFavorites()
        }
    }
    
    private func fetchAllRecipes() {
        try? modelContext.save() // this is to cover for a SwiftData bug Prof Liddle has seen

        let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.title)])
        
        do {
            recipes = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to Load Recipes")
        }
    }

    private func fetchFavorites() {
        try? modelContext.save()
        
        let descriptor = FetchDescriptor<Recipe>(
            predicate: #Predicate { $0.isFavorite },
            sortBy: [SortDescriptor(\.title)]
        )
        
        do {
            favorites = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load favorites")
        }
    }
}
