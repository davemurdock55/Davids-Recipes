//
//  RecipeSheetView.swift
//  Davids-Recipes
//
//  Created by David Murdock on 11/23/24.
//

import SwiftUI

struct RecipeSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(RecipeViewModel.self) private var viewModel
    
    var editingRecipe: Recipe?
    
    @State private var recipeIsFavorite: Bool = false
    @State private var recipeTitle: String = ""
    @State private var recipeImageUrl: String = ""
    @State private var recipeAuthor: String = ""
    @State private var recipeQuote: String = ""
    @State private var recipeCategories: [String] = []
    @State private var recipeIngredients: String = ""
    @State private var recipeInstructions: String = ""
    @State private var recipeNotes: String = ""
    
    var body: some View {
            NavigationStack {
                Form {
                    // Favorited (boolean)
                    ToggleInput(
                        labelText: "Favorite?",
                        isOn: $recipeIsFavorite
                    )
                    
                    // Recipe Title (string)
                    TextInput(
                        labelText: "Recipe Title",
                        value: $recipeTitle,
                        placeholderText: "Chocolate Chip Cookies"
                    )
                    
                    // Recipe Title (string)
                    TextInput(
                        labelText: "Cover Image Url",
                        value: $recipeImageUrl,
                        placeholderText: "https://www.example.com/images/logo.png"
                    )
                    
                    // Recipe Author (string)
                    TextInput(
                        labelText: "Recipe Author",
                        value: $recipeAuthor,
                        placeholderText: "Prof. Liddle"
                    )
                    
                    // Recipe Quote (long-string)
                    MultiLineTextInput(
                        labelText: "Recipe Quote",
                        value: $recipeQuote,
                        placeholderText: "> I like this recipe app a lot"
                    )

                    // Categories (required) (multi-add like tags or list input of some kind???)
                    ListInput(labelText: "Categories", stringArray: $recipeCategories)
                    
                    // Ingredients (markdown long-string or multi-add)
                    MultiLineTextInput(
                        labelText: "Ingredients",
                        value: $recipeIngredients,
                        placeholderText: """
                                        |   Quantity  |   Description  |   Notes  |
                                        |-----------|---------------|---------|
                                        |   4oz  |   Butter  |   Cut in half  |
                                        |   1 pinch  |   Salt  |   Use two fingers  |
                                        """
                    )
                    
                    // Instructions (markdown long-string or multi-add)
                    MultiLineTextInput(
                        labelText: "Instructions",
                        value: $recipeInstructions,
                        placeholderText: """
                                        1. Turn stove on medium 
                                        2. Mix ingredients together
                                        3. Pour ingredients on pan
                                        4. Cook until light brown
                                        """
                    )
                    
                    // notes (long-string)
                    MultiLineTextInput(
                        labelText: "Notes",
                        value: $recipeNotes,
                        placeholderText: "Here are some notes about the recipe"
                    )
                    
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("\(editingRecipe != nil ? "Edit \(editingRecipe?.title ?? "Recipe")" : "Add Recipe")")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: { dismiss() }) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem {
                        Button {
                            dismiss()
                            if let updatedRecipe = editingRecipe {
                                // update updatedRecipe constant with editingRecipe's updated content
                                // (don't worry, updatedRecipe keeps the same id as editingRecipe)
                                updatedRecipe.title = recipeTitle
                                updatedRecipe.imageUrl = recipeImageUrl
                                updatedRecipe.author = recipeAuthor
                                updatedRecipe.quote = recipeQuote
                                updatedRecipe.categories = recipeCategories
                                updatedRecipe.ingredients = recipeIngredients
                                updatedRecipe.instructions = recipeInstructions
                                updatedRecipe.notes = recipeNotes
                                updatedRecipe.isFavorite = recipeIsFavorite
                                updatedRecipe.lastModified = Date()
                                
                                viewModel.editRecipe(updatedRecipe)
                            } else {
                                // creating new recipe object
                                let newRecipe = Recipe(
                                    title: recipeTitle,
                                    imageUrl: recipeImageUrl,
                                    author: recipeAuthor,
                                    quote: recipeQuote,
                                    categories: recipeCategories,
                                    ingredients: recipeIngredients,
                                    instructions: recipeInstructions,
                                    notes: recipeNotes,
                                    isFavorite: recipeIsFavorite,
                                    lastModified: Date()
                                )
                                viewModel.addRecipe(newRecipe)
                            }
                                
                        } label: {
                            Text("Save")
                                .fontWeight(.semibold)
                        }
                    }
                }
                .onAppear {
                    if let recipe = editingRecipe {
                        recipeIsFavorite = recipe.isFavorite
                        recipeTitle = recipe.title
                        recipeImageUrl = recipe.imageUrl
                        recipeAuthor = recipe.author
                        recipeQuote = recipe.quote
                        recipeCategories = recipe.categories
                        recipeIngredients = recipe.ingredients
                        recipeInstructions = recipe.instructions
                        recipeNotes = recipe.notes
                    }
                }
            }
        
    }
    
}
