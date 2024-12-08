//
//  RecipeModel.swift
//  Davids-Recipes
//
//  Created by David Murdock on 11/21/24.
//

import Foundation
import SwiftData

@Model
final class Recipe: ObservableObject {
    var title: String
    var imageUrl: String
    var author: String
    var quote: String
    var categories: [String]
    var ingredients: String
    var instructions: String
    var notes: String
    var isFavorite: Bool
    var lastModified: Date
    
    init(title: String, imageUrl: String, author: String, quote: String, categories: [String], ingredients: String, instructions: String, notes: String, isFavorite: Bool, lastModified: Date) {
        self.title = title
        self.imageUrl = imageUrl
        self.author = author
        self.quote = quote
        self.categories = categories
        self.ingredients = ingredients
        self.instructions = instructions
        self.notes = notes
        self.isFavorite = isFavorite
        self.lastModified = lastModified
    }
}
