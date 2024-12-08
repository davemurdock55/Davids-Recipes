//
//  SeedData.swift
//  Davids-Recipes
//
//  Created by David Murdock on 12/3/24.
//

import Foundation

let sampleRecipes = [
    Recipe(
        title: "Sweet Crepes",
        imageUrl: "https://plus.unsplash.com/premium_photo-1707757442378-8cb5223916ae?q=80&w=2944&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        author: "David Murdock",
        quote: """
        > I love crepes so much  
        > They are so yummy to me  
        > This is a haiku
        """,
        categories: ["Breakfast", "Dessert"],
        ingredients: """
        |   Quantity    |   Description |   Notes   |
        |-----|-----|-----|
        |   2  |    eggs    |   Eggs taste good |
        |   1/2 cup |   Milk    |   You need milk   |
        """,
        instructions: """
        1. Mix it together
        2. Cook it on a pan
        3. Eat them and enjoy
        """,
        notes: "This recipe is for sweet crepes and not savory ones",
        isFavorite: true,
        lastModified: Date()
    ),
]
