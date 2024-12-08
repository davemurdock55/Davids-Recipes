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
    private(set) var categories: [String] = []
    var imageData: Data?
    
    func recipes(for category: String) -> [Recipe] {
        return recipes.filter{
            $0.categories.contains(category)
        }
    }

    // MARK: - User Intents
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
    
    
    // MARK: - Private Helpers
    private func fetchData() {
        try? modelContext.save()

        fetchAllRecipes()
        fetchFavorites()
        setCategories()
        
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
    
    private func setCategories() {
        var categoriesSet = Set<String>()
        
        recipes.forEach { recipe in
            recipe.categories.forEach { category in
                categoriesSet.insert(category)
            }
        }

        categories = Array(categoriesSet).sorted()
    }
}
