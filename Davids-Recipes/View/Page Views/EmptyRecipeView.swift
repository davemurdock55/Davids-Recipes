//
//  EmptyRecipeView.swift
//  Davids-Recipes
//
//  Created by David Murdock on 12/7/24.
//

import SwiftUI

struct EmptyRecipeView: View {
    @Binding var showAddRecipeSheet: Bool
    var noRecipesAtAll: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Welcome to David's Recipe App!")
                .font(.title)
                .multilineTextAlignment(.center) // looked this up online (multiTextAlignment)
            
            if noRecipesAtAll == false {
                Text("Please Select a recipe or add a new one to get started")
            }
            
            Button {
                showAddRecipeSheet = true
            } label: {
                Label("Add \(noRecipesAtAll ? "Your First" : "a") Recipe", systemImage: "plus")
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

// MARK: - Constants
private struct Constants {
    static fileprivate let buttonCornerRadius: Double = 10
    static fileprivate let bottomPadding: Double = 5
}
