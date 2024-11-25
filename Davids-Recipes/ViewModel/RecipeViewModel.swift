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
        // You can comment this out to start fresh with no data :)
        fetchData()
    }

    // MARK: - Model access
    private(set) var recipes: [Recipe] = []
    private(set) var favorites: [Recipe] = []
    
    // MARK: - User Intents
    func addRecipe() {
        withAnimation {
            let newRecipe = Recipe(
                title: "TestRecipe",
                author: "David Murdock",
                recipeQuote: "Quote",
                categories: ["Breakfast", "Lunch"],
                ingredients: "Ingredient 1, Ingredient 2",
                instructions: "1. Start by opening the pop tart 2. Put it in the toaster 3. Eat",
                notes: "Make sure you take the pop tart out!!!",
                favorited: true,
                lastModified: Date()
            )
            
            modelContext.insert(newRecipe)
            fetchData()
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
    
    // MARK: - Helpers
    private func fetchData() {
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
    
    // you could also access the Categories or Ingredients
    // you could have favorites here
    // and you could make an intent to search recipes
    // ...
}
