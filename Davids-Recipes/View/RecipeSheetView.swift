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
    
    @State private var favorited: Bool = false
    @State private var recipeTitle: String = ""
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
                        isOn: $favorited
                    )
                    
                    // Recipe Title (string)
                    TextInput(
                        labelText: "Recipe Title",
                        value: $recipeTitle,
                        placeholderText: "Recipe Title"
                    )
                    // Recipe Author (string)
                    TextInput(
                        labelText: "Recipe Author",
                        value: $recipeAuthor,
                        placeholderText: "Recipe Author"
                    )
                    // Recipe Quote (long-string)
                    MultiLineTextInput(
                        labelText: "Recipe Quote",
                        value: $recipeQuote,
                        placeholderText: "Recipe Quote"
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
                        placeholderText: "Notes"
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
                                updatedRecipe.author = recipeAuthor
                                updatedRecipe.recipeQuote = recipeQuote
                                updatedRecipe.categories = recipeCategories
                                updatedRecipe.ingredients = recipeIngredients
                                updatedRecipe.instructions = recipeInstructions
                                updatedRecipe.notes = recipeNotes
                                updatedRecipe.favorited = favorited
                                updatedRecipe.lastModified = Date()
                                
                                viewModel.editRecipe(updatedRecipe)
                            } else {
                                // creating new recipe object
                                let newRecipe = Recipe(
                                    title: recipeTitle,
                                    author: recipeAuthor,
                                    recipeQuote: recipeQuote,
                                    categories: recipeCategories,
                                    ingredients: recipeIngredients,
                                    instructions: recipeInstructions,
                                    notes: recipeNotes,
                                    favorited: favorited,
                                    lastModified: Date()
                                )
                                viewModel.addRecipe(newRecipe)
                            }
                                
                        } label: {
                            Text("Save")
                        }
                    }
                }
                .onAppear {
                    if let recipe = editingRecipe {
                        favorited = recipe.favorited
                        recipeTitle = recipe.title
                        recipeAuthor = recipe.author
                        recipeQuote = recipe.recipeQuote
                        recipeCategories = recipe.categories
                        recipeIngredients = recipe.ingredients
                        recipeInstructions = recipe.instructions
                        recipeNotes = recipe.notes
                    }
                }
            }
        
    }
    
}
