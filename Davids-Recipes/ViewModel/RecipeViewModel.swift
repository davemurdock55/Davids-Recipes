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
        fetchAllRecipes()
        fetchFavorites()
    }

    // MARK: - Model access
    private(set) var recipes: [Recipe] = []
    private(set) var favorites: [Recipe] = []

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
            fetchAllRecipes()
            fetchFavorites()
        }
    }
    
    func editRecipe(_ updatedRecipe: Recipe) {
        withAnimation {
            modelContext.insert(updatedRecipe)
            try? modelContext.save()
            fetchAllRecipes()
            fetchFavorites()
        }
    }

    func toggleFavorite(for recipe: Recipe) {
        withAnimation {
            recipe.favorited.toggle()
            try? modelContext.save()
            fetchFavorites()
        }
    }

    func deleteRecipes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(recipes[index])
            }
            fetchAllRecipes()
            fetchFavorites()
        }
    }

    // MARK: - Helpers
    private func fetchAllRecipes() {
        try? modelContext.save() // this is to cover for a SwiftData bug Prof Liddle has seen

        do {
            let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.title)])
            recipes = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to Load Recipes")
        }
    }

    private func fetchFavorites() {
        do {
            let descriptor = FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.favorited },
                sortBy: [SortDescriptor(\.title)]
            )
            favorites = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load favorites")
        }
    }
}
