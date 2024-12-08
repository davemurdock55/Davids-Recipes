//
//  RecipeView.swift
//  Davids-Recipes
//
//  Created by David Murdock on 11/25/24.
//

import SwiftUI
import MarkdownUI

struct RecipeView: View {
    @Environment(RecipeViewModel.self) private var viewModel
    var recipe: Recipe
    
    @State private var showEditRecipeSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                // AI helped me switch from using an Async Image by giving me this code (since I found out that apparently AsyncImage is very buggy after doing some research)
                if let imageData = viewModel.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: Constants.imageFrameHeight)
                        .clipped()
                } else {
                    ProgressView()
                        .frame(height: Constants.imageFrameHeight)
                }

//                Text("\(recipe.title)").font(.title).fontWeight(.bold)
//                    .padding(.vertical, Constants.standardPadding)
                
                Text("\(recipe.author)").font(.title3)
                Text("Last Updated: \(recipe.lastModified, format: Date.FormatStyle(date: .numeric))").font(.subheadline)
                
                HStack {
                    ForEach(recipe.categories, id: \.self) { category in
                        TagView(category: category)
                    }
                }
                .padding(.vertical, Constants.standardPadding)
                
                Markdown("\(recipe.quote)")
                    .markdownBlockStyle(\.blockquote) { configuration in
                        configuration.label
                            .padding()
                            .overlay(alignment: .leading) {
                                Rectangle()
                                    .fill(Color.accent)
                                    .frame(width: Constants.quoteLineWidth)
                            }
                            .background(Color.accent.opacity(Constants.lowOpacity))
                    }
                    .padding(.bottom, Constants.standardPadding)
                
                Text("Ingredients").font(.title2).fontWeight(.bold)
                Markdown("\(recipe.ingredients)")
                    .markdownTableBorderStyle(
                        TableBorderStyle(color: Color.accent)
                    )
                    .markdownBlockStyle(\.table) { configuration in
                        configuration.label
                            .markdownTableBackgroundStyle(
                                .alternatingRows(
                                    .clear,
                                    .clear,
                                    header: Color.accent.opacity(Constants.lowOpacity)
                                )
                            )
                    }
                    .padding(.bottom, Constants.standardPadding)
                    .padding(.horizontal, Constants.standardPadding)
                
                Text("Instructions").font(.title2).fontWeight(.bold)
                Markdown("\(recipe.instructions)")
                    .padding(.bottom, Constants.standardPadding)
                
                Text("Notes").font(.title2).fontWeight(.bold)
                Markdown("\(recipe.notes)")
                    .frame(width: Constants.notesWidth)
                    .padding(.bottom, Constants.standardPadding)
            }
        }
        .onAppear {
            // AI helped advise me to re-load the image whenever the View re-appears
            viewModel.loadImage(for: recipe)
        }
        .onChange(of: showEditRecipeSheet) {
            viewModel.loadImage(for: recipe)
        }
        .navigationTitle("\(recipe.title)")
        .toolbar {
            ToolbarItem {
                Button {
                    viewModel.toggleFavorite(for: recipe)
                } label: {
                    if recipe.isFavorite {
                        Image(systemName: "heart.fill")
                    } else {
                        Image(systemName: "heart")
                    }
                }
            }
            ToolbarItem {
                Button {
                    showEditRecipeSheet = true
                } label: {
                    Text("Edit")
                }
                .sheet(isPresented: $showEditRecipeSheet) {
                    RecipeSheetView(editingRecipe: recipe)
                }
            }
        }
    }
    
}

// MARK: - Constants
private struct Constants {
    static fileprivate let imageFrameHeight: Double = 300
    static fileprivate let standardPadding: Double = 10
    static fileprivate let lowOpacity: Double = 0.25
    static fileprivate let quoteLineWidth: Double = 4
    static fileprivate let notesWidth: Double = 350
}
