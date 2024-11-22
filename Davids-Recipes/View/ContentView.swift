//
//  ContentView.swift
//  Davids-Recipes
//
//  Created by David Murdock on 11/21/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(RecipeViewModel.self) private var viewModel
//    @Query private var recipes: [Recipe]
    
    private var allCategories: [String] {
        var categoriesSet = Set<String>()
        
        viewModel.recipes.forEach { recipe in
            recipe.categories.forEach { category in
                categoriesSet.insert(category)
            }
        }
        
        return Array(categoriesSet)
    }

    var body: some View {
        NavigationSplitView {
            List {
                if allCategories.count > 0 {
                    ForEach(allCategories, id: \.self) { category in
                        NavigationLink {
                            Text(category)
                        } label: {
                            Text(category)
                        }
                    }
                } else {
                    Button(action: viewModel.addRecipe) {
                        Label("Add Recipe", systemImage: "plus")
                    }
                }
            }
        } content: {
                List {
                    ForEach(viewModel.recipes) { recipe in
                        NavigationLink {
                            Text("\(recipe.title) at \(recipe.lastModified, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        } label: {
                            Text(recipe.title)
                        }
                    }
                    .onDelete(perform: viewModel.deleteRecipes)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: viewModel.addRecipe) {
                            Label("Add Recipe", systemImage: "plus")
                        }
                    }
                }
            } detail: {
                Text("Select a recipe")
            }
        }
    
//    private func addRecipe() {
//        withAnimation {
//            let newRecipe = Recipe(
//                title: "TestRecipe",
//                author: "David Murdock",
//                recipeQuote: "Quote",
//                categories: ["Breakfast", "Lunch"],
//                ingredients: "Ingredient 1, Ingredient 2",
//                instructions: "1. Start by opening the pop tart 2. Put it in the toaster 3. Eat",
//                notes: "Make sure you take the pop tart out!!!",
//                favorited: true,
//                lastModified: Date()
//            )
//            
//            modelContext.insert(newRecipe)
//        }
//    }
//
//    private func deleteRecipes(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(recipes[index])
//            }
//        }
//    }
}

#Preview {
    let container = try! ModelContainer(for: Recipe.self)
    let viewModel = RecipeViewModel(container.mainContext)
    
    ContentView()
        .modelContainer(container)
        .environment(viewModel)
}
