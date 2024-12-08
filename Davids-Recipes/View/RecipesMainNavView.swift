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
    @State private var selectedRecipe: Recipe?
    @State private var searchText: String = ""
    @State private var showAddRecipeSheet: Bool = false
    
    var body: some View {
        if viewModel.recipes.count > 0 {
            NavigationSplitView {
                List {
                    Section {
                        NavigationLink(
                            destination: RecipeListView(
                                recipes: viewModel.recipes,
                                title: "All Recipes",
                                searchText: $searchText,
                                showAddRecipeSheet: $showAddRecipeSheet,
                                selectedRecipe: $selectedRecipe
                            )
                        ) {
                            Label("All Recipes", systemImage: "list.bullet.rectangle")
                        }
                        NavigationLink(
                            destination: RecipeListView(
                                recipes: viewModel.favorites,
                                title: "Favorites",
                                searchText: $searchText,
                                showAddRecipeSheet: $showAddRecipeSheet,
                                selectedRecipe: $selectedRecipe
                            )
                        ) {
                            Label("Favorites", systemImage: "heart")
                        }
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
                                    showAddRecipeSheet: $showAddRecipeSheet,
                                    selectedRecipe: $selectedRecipe
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
                    showAddRecipeSheet: $showAddRecipeSheet,
                    selectedRecipe: $selectedRecipe
                )
            } detail: {
                if let recipe = selectedRecipe {
                    RecipeView(recipe: recipe)
                } else {
                    EmptyRecipeView(showAddRecipeSheet: $showAddRecipeSheet, noRecipesAtAll: false)
                }
            }
        } else {
            EmptyRecipeView(showAddRecipeSheet: $showAddRecipeSheet, noRecipesAtAll: true)
       }
    }
    
}

// MARK: - Helper View
private struct RecipeListView: View {
    let recipes: [Recipe]
    let title: String
    @Binding var searchText: String
    @Binding var showAddRecipeSheet: Bool
    @Environment(RecipeViewModel.self) private var viewModel
    @Binding var selectedRecipe: Recipe?

    var body: some View {
        List {
            ForEach(filter(recipes)) { recipe in
                NavigationLink(
                    recipe.title,
                    destination: RecipeView(recipe: recipe),
                    tag: recipe,
                    selection: $selectedRecipe)
            }
            .onDelete(perform: viewModel.deleteRecipes)
        }
        .navigationTitle("\(title)")
        .navigationBarItems(
            trailing: HStack {
                EditButton()
                Button(action: { showAddRecipeSheet = true }) {
                    Label("Add Recipe", systemImage: "plus")
                }
                .sheet(isPresented: $showAddRecipeSheet) {
                    RecipeSheetView()
                }
            }
        )
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search Ingredients"
        )
    }

    // MARK: - Helper Function
    // Used the Claude snippet we were shown in class (and referenced ChatGPT a little in the creation of this function - mainly as a reminder that I could simply access searchText from outside of the helper)
    private func filter(_ recipes: [Recipe]) -> [Recipe] {
        if !searchText.isEmpty {
            return recipes.filter({ $0.ingredients.localizedCaseInsensitiveContains(searchText) })
        } else {
            return recipes
        }
    }
}


// MARK: - Constants
private struct Constants {
    static fileprivate let buttonCornerRadius: Double = 10
    static fileprivate let bottomPadding: Double = 5
}


// MARK: - Preview
#Preview {
    do {
        let container = try ModelContainer(for: Recipe.self)
        let viewModel = RecipeViewModel(container.mainContext)
        
        return RecipesMainNavView()
            .modelContainer(container)
            .environment(viewModel)
    } catch {
        fatalError("Failed to create preview: \(error.localizedDescription)")
    }
}
