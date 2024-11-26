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
    @State private var filterText: String?
    @State private var selectedRecipe: Recipe?
    @State private var showAddRecipeSheet: Bool = false
    @State private var searchText: String = ""
    
    private var allCategories: [String] {
        var categoriesSet = Set<String>()
        
        viewModel.recipes.forEach { recipe in
            recipe.categories.forEach { category in
                categoriesSet.insert(category)
            }
        }

        return Array(categoriesSet).sorted()
    }
    
    private var displayRecipes: [Recipe] {
        var filteredRecipes = viewModel.filterRecipes(by: filterText ?? Constants.allRecipes)
        
        if !searchText.isEmpty {
            filteredRecipes = filteredRecipes.filter({ $0.ingredients.localizedCaseInsensitiveContains(searchText) })
        }
        
        return filteredRecipes
    }

    var body: some View {
        if allCategories.count > 0 {
            NavigationSplitView {
                List(selection: $filterText) {
                    Section {
                        NavigationLink(value: Constants.allRecipes) {
                            Label(Constants.allRecipes, systemImage: "list.bullet.rectangle")
                        }
                        NavigationLink(value: "Favorites") {
                            Label("Favorites", systemImage: "heart")
                        }
                    } header: {
                        Text("Main")
                    }
                    
                    Section {
                        ForEach(allCategories, id: \.self) { category in
                            NavigationLink(value: category) {
                                Text(category)
                            }
                        }
                    } header: {
                        Text("Categories")
                    }
                }
                .navigationTitle("David's Recipes")
            } content: {
                List(selection: $selectedRecipe) {
                    ForEach(
                        displayRecipes
                    ) { recipe in
                        NavigationLink(value: recipe) {
                            Text("\(recipe.title)")
                        }
                    }
                    .onDelete(perform: viewModel.deleteRecipes)
                }
                .navigationTitle("\(filterText ?? "")")
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
            } detail: {
                if let recipe = selectedRecipe {
                    RecipeView(recipe: recipe)
                } else {
                    Text("Select a recipe")
                }
            }
        } else {
           VStack(alignment: .center) {
               Text("Welcome to David's Recipe App!")
                   .font(.title)
                   .multilineTextAlignment(.center)
               Button {
                   showAddRecipeSheet = true
               } label: {
                   Label("Add Your First Recipe", systemImage: "plus")
               }
               .padding()
               .foregroundStyle(.white)
               .background(.accent)
               .cornerRadius(10)
               .sheet(isPresented: $showAddRecipeSheet) {
                   RecipeSheetView()
               }
           }
           .padding(5)
       }
    }
    
}

private struct Constants {
    static fileprivate let allRecipes: String = "All Recipes"
}

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
