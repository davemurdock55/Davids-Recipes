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
    
    // MARK: - Properties
    init(_ modelContext: ModelContext) {
        self.modelContext = modelContext
//        fetchData()
    }

    // MARK: - Model access
    private(set) var recipes: [Recipe] = []
    
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
        }
    }

    func deleteRecipes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(recipes[index])
            }
        }
    }
    
    // you could also access the Categories or Ingredients
    // you could have favorites here
    // and you could make an intent to search recipes
    // ...
}
