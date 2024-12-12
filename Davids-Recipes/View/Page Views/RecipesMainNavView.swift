//
//  RecipesMainNavView.swift
//  Davids-Recipes
//
//  Created by David Murdock on 11/21/24.
//

import SwiftUI
import SwiftData

struct RecipesMainNavView: View {
    @Environment(RecipeViewModel.self) private var viewModel
    @State private var searchText: String = ""
    @State private var showAddRecipeSheet: Bool = false

    var body: some View {
        // Only show this if there are recipes (e.g. might not meet this if all recipes are deleted)
        if viewModel.recipes.count > 0 {
            NavigationSplitView {
                List {
                    Section {
                        NavigationLink(
                            // I was initially using "selection" instead of destination, but ran into a depreciation warning when I tried to add "tags" to that, so I did get some help from AI in resolving that depreciation warning
                            destination: RecipeListView(
                                recipes: viewModel.recipes,
                                title: "All Recipes",
                                searchText: $searchText,
                                showAddRecipeSheet: $showAddRecipeSheet
                            )
                        ) {
                            Label("All Recipes", systemImage: "list.bullet.rectangle")
                        }
                        NavigationLink(
                            destination: RecipeListView(
                                recipes: viewModel.favorites,
                                title: "Favorites",
                                searchText: $searchText,
                                showAddRecipeSheet: $showAddRecipeSheet
                            )
                        ) {
                            Label("Favorites", systemImage: "heart")
                        }
                        // had help from online for this (*see resources.txt)
                    } header: {
                        Text("Main")
                    }
                    
                    Section {
                        ForEach(viewModel.categories, id: \.self) { category in
                            NavigationLink(
                                destination: RecipeListView(
                                    recipes: viewModel.recipes(for: category),
                                    title: category,
                                    searchText: $searchText,
                                    showAddRecipeSheet: $showAddRecipeSheet
                                )
                            ) {
                                Text(category)
                            }
                        }
                    } header: {
                        Text("Categories")
                    }
                }
                .navigationTitle("David's Recipes")
            } content: {
                RecipeListView(
                    recipes: viewModel.recipes,
                    title: "All Recipes",
                    searchText: $searchText,
                    showAddRecipeSheet: $showAddRecipeSheet
                )
            } detail: {
                // Had help from AI to fix a weird rendering bug (that's where the "if let" comes from (already had the EmptyRecipeView))
                // Making sure there is a Selected Recipe
                if let recipe = viewModel.recipes.first {
                    RecipeView(recipe: recipe)
                } else {
                    // as I was asking the above question to fix the rendering bug, the AI suggested I should pass viewModel.recipes.isEmpty instead of hard-coding a boolean here
                    EmptyRecipeView(showAddRecipeSheet: $showAddRecipeSheet, noRecipesAtAll: viewModel.recipes.isEmpty)
                }
            }
        } else {
            EmptyRecipeView(showAddRecipeSheet: $showAddRecipeSheet, noRecipesAtAll: viewModel.recipes.isEmpty)
        }
    }
}


// MARK: - Constants
private struct Constants {
    static fileprivate let buttonCornerRadius: Double = 10
    static fileprivate let bottomPadding: Double = 5
}


// MARK: - Preview
// Commented out for you :)
//#Preview {
//    do {
//        let container = try ModelContainer(for: Recipe.self)
//        let viewModel = RecipeViewModel(container.mainContext)
//        
//        return RecipesMainNavView()
//            .modelContainer(container)
//            .environment(viewModel)
//    } catch {
//        fatalError("Failed to create preview: \(error.localizedDescription)")
//    }
//}
