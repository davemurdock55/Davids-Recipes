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
        var filteredRecipes = viewModel.filterRecipes(by: filterText ?? "All Recipes")
        
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
                        NavigationLink(
                            value: "All Recipes"
//                            destination: recipeList(
//                                for: viewModel.recipes,
//                                with: "All Recipes"
//                            )
                        ) {
                            Label("All Recipes", systemImage: "list.bullet.rectangle")
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
                    VStack(alignment: .center) {
                        Text("Welcome to David's Recipe App!")
                            .font(.title)
                            .multilineTextAlignment(.center)
                        Text("Please Select a recipe or add a new one to get started")
                        Button {
                            showAddRecipeSheet = true
                        } label: {
                            Label("Add a Recipe", systemImage: "plus")
                        }
                        .padding()
                        .foregroundStyle(.white)
                        .background(.accent)
                        .cornerRadius(Constants.buttonCornerRadius)
                        .sheet(isPresented: $showAddRecipeSheet) {
                            RecipeSheetView()
                        }
                    }
                    .padding(Constants.bottomPadding)
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
               .cornerRadius(Constants.buttonCornerRadius)
               .sheet(isPresented: $showAddRecipeSheet) {
                   RecipeSheetView()
               }
           }
           .padding(Constants.bottomPadding)
       }
    }
    
    
//    You can do something like this to list recipes in both places
//    private func recipeList(for recipes: [Recipe], with title: String) -> some View {
//        List {
//            ForEach(recipes) { recipe in
//                NavigationLink(recipe.title, destination: RecipeView(recipe: recipe))
//            }
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                EditButton()
//            }
//            ToolbarItem {
//                Button {
//                    showAddRecipeSheet = true
//                } label: {
//                    Label("Add Item", systemImage: "plus")
//                }
//            }
//        }
//    }
    
}

// MARK: - Constants
private struct Constants {
    static fileprivate let buttonCornerRadius: Double = 10
    static fileprivate let bottomPadding: Double = 5
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
