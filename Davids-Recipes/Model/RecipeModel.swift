//
//  RecipeModel.swift
//  Davids-Recipes
//
//  Created by David Murdock on 11/21/24.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    var title: String
    var author: String
    var recipeQuote: String
    var categories: [String]
    var ingredients: String // could change this to something else (needs "quantity", "ingredientName", and "note")
    var instructions: String // could change this to something else (needs "step" and "description")
    var notes: String
    var favorited: Bool
    var lastModified: Date
    
    init(title: String, author: String, recipeQuote: String, categories: [String], ingredients: String, instructions: String, notes: String, favorited: Bool, lastModified: Date) {
        self.title = title
        self.author = author
        self.recipeQuote = recipeQuote
        self.categories = categories
        self.ingredients = ingredients
        self.instructions = instructions
        self.notes = notes
        self.favorited = favorited
        self.lastModified = lastModified
    }
}
