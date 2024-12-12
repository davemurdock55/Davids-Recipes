//
//  RecipeListView.swift
//  Davids-Recipes
//
//  Created by David Murdock on 12/10/24.
//
import SwiftUI

// I wanted to use a View instead of a function and I could've built this solo, but AI was able to help me build out the base for it faster (most of it was just changing the parameters to variables and putting the returned content into "var body: some View", but it also advised me to put the "filter" helper in here (I already had it built out in my RecipesMainNavView)
struct RecipeListView: View {
    let recipes: [Recipe]
    let title: String
    @Binding var searchText: String
    @Binding var showAddRecipeSheet: Bool
    @Environment(RecipeViewModel.self) private var viewModel

    var body: some View {
        List {
            ForEach(filter(recipes)) { recipe in
                NavigationLink(
                    value: recipe
                ) {
                    Text(recipe.title)
                }
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
            prompt: "Search anything"
        )
        .navigationDestination(for: Recipe.self) { recipe in
            RecipeView(recipe: recipe)
        }
    }

    // Filtering Recipe results based on search text
    private func filter(_ recipes: [Recipe]) -> [Recipe] {
        if !searchText.isEmpty {
            return recipes.filter({ $0.searchKeywords.localizedCaseInsensitiveContains(searchText) })
        } else {
            return recipes
        }
    }
}
