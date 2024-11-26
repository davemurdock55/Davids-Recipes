//
//  RecipeView.swift
//  Davids-Recipes
//
//  Created by David Murdock on 11/25/24.
//

import SwiftUI

struct RecipeView: View {
    @Environment(RecipeViewModel.self) private var viewModel
    var recipe: Recipe
    
    @State private var showEditRecipeSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("\(recipe.title)").font(.title).fontWeight(.bold)
            Text("\(recipe.author)").font(.title3)
            Text("Last Updated: \(recipe.lastModified, format: Date.FormatStyle(date: .numeric, time: .standard))").font(.subheadline)
            Text("Categories").font(.title2).fontWeight(.bold)
            ForEach(recipe.categories, id: \.self) { category in
                Text(category)
            }
            Text("Ingredients").font(.title2).fontWeight(.bold)
            Text("\(recipe.ingredients)")
            
            Text("Instructions").font(.title2).fontWeight(.bold)
            Text("\(recipe.instructions)")
            
            Text("Notes").font(.title2).fontWeight(.bold)
            Text("\(recipe.notes)")
        }
        .navigationTitle("\(recipe.title)")
        .toolbar {
            ToolbarItem {
                Button {
                    viewModel.toggleFavorite(for: recipe)
                } label: {
                    if recipe.favorited {
                        Image(systemName: "heart.fill")
                    } else {
                        Image(systemName: "heart")
                    }
                }
            }
            ToolbarItem {
                Button {
                    showEditRecipeSheet = true
                } label: {
                    Text("Edit")
                }
                .sheet(isPresented: $showEditRecipeSheet) {
                    RecipeSheetView(editingRecipe: recipe)
                }
            }
        }
        
    }
}
