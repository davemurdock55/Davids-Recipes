//
//  RecipeView.swift
//  Davids-Recipes
//
//  Created by David Murdock on 11/25/24.
//

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack{
            Text("\(recipe.title)").font(.title)
            Text("\(recipe.author)").font(.subheadline)
            Text("\(recipe.lastModified)")
        }
    }
    
}
