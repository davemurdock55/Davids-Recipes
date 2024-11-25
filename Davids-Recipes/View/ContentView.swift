//
//  ContentView.swift
//  Davids-Recipes
//
//  Created by David Murdock on 11/21/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
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
                        ForEach(allCategories, id: \.self) { category in
                            NavigationLink(value: category) {
                                Text(category)
                            }
                        }
                }
            } content: {
                List(selection: $selectedRecipe) {
                        ForEach(viewModel.recipes.filter({ $0.categories.contains(selectedCategory ?? "") })) { recipe in
                            NavigationLink(value: recipe) {
                                Text("\(recipe.title) at \(recipe.lastModified, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            }
                        }
                        .onDelete(perform: viewModel.deleteRecipes)
                    }
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
                    VStack{
                        Text("\(recipe.title)").font(.title)
                        Text("\(recipe.author)").font(.subheadline)
                        Text("\(recipe.lastModified)")
                    }
                } else {
                    Text("Select a recipe")
                }
            }
        } else {
           VStack(alignment: .center) {
               Text("Welcome to David's Recipe App!")
                   .font(.title)
                   .multilineTextAlignment(.center)
               Button(action: { showAddRecipeSheet = true }) {
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
        
        return ContentView()
            .modelContainer(container)
            .environment(viewModel)
    } catch {
        fatalError("Failed to create preview: \(error.localizedDescription)")
    }
}
