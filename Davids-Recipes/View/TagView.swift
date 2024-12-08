//
//  TagView.swift
//  Davids-Recipes
//
//  Created by David Murdock on 12/5/24.
//
import SwiftUI

struct TagView: View {
    var category: String
    
    var body: some View {
        HStack {
            Text("\(category)")
                .padding(.horizontal, Constants.tagHorizontalPadding)
                .padding(.vertical, Constants.tagVerticalPadding)
                .background(.accent)
                .foregroundStyle(.white)
                .cornerRadius(Constants.tagCornerRadius)
        }
    }
}

// MARK: - Constants
private struct Constants {
    static fileprivate let tagHorizontalPadding: Double = 12
    static fileprivate let tagVerticalPadding: Double = 4
    static fileprivate let tagCornerRadius: Double = 20
}
