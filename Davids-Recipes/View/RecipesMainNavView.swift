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
    @State private var selectedCategory: String?
    @State private var selectedRecipe: Recipe?
    @State private var showAddRecipeSheet: Bool = false
    
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
        if allCategories.count > 0 {
            NavigationSplitView {
                List(selection: $selectedCategory) {
                    Section {
                        // TODO: - Do something else when you click on All Recipes and Favorites (vs a category)
                        NavigationLink(value: "All Recipes") {
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
                // TODO: - Sort this list in alphabetical order (breakfast first, etc.)
                // -- Bonus points for if there's a way we can organize it by Breakfast, Lunch, then Dinner, then Dessert, then Other in the sorting, and have everything else come before "Other"
                
                // TODO: - Get the favorites to actually show up in favorites
                // we'll probably just need to move this filtering logic over to the ViewModel and handle it all there
                List(selection: $selectedRecipe) {
                    ForEach(viewModel.recipes.filter({ $0.categories.contains(selectedCategory ?? "") })) { recipe in
                        NavigationLink(value: recipe) {
                            Text("\(recipe.title)")
                        }
                    }
                    .onDelete(perform: viewModel.deleteRecipes)
                }
                .navigationTitle("\(selectedCategory ?? "")")
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
