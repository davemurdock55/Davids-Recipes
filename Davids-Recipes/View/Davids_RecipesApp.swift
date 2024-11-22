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
            ContentView()
        }
        .modelContainer(container)
        .environment(viewModel) // this is environment, NOT @EnvironmentObject like what we did to pass the ViewModel around
    }

    init() {
        do {
            container = try ModelContainer(for: Recipe.self)
            // note how we don't have square brackets around Recipe.self - we just aren't listing multiple models for this example (which is optional)
            // if you set up your relationships properly, Swift pulls in all the models with relationships so you don't have to do it manually
        } catch {
            fatalError("Failed to create ModelContainer for Recipe. If you made a change to the Model, uninstall the app, and restart it from Xcode.")
        }
    
        viewModel = RecipeViewModel(container.mainContext)
    }
}
