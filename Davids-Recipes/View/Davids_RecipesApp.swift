//
//  Davids_RecipesApp.swift
//  Davids-Recipes
//
//  Created by David Murdock on 11/21/24.
//

import SwiftUI
import SwiftData

@main
struct Davids_RecipesApp: App {
    let container: ModelContainer
    let viewModel: RecipeViewModel
    
    var body: some Scene {
        WindowGroup {
            RecipesMainNavView()
        }
        .modelContainer(container)
        .environment(viewModel)
    }

    init() {
        do {
            container = try ModelContainer(for: Recipe.self)
        } catch {
            fatalError("Failed to create ModelContainer for Recipe. If you made a change to the Model, uninstall the app, and restart it from Xcode.")
        }
    
        viewModel = RecipeViewModel(container.mainContext)
    }
}
