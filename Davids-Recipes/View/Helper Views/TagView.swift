//
//  TagView.swift
//  Davids-Recipes
//
//  Created by David Murdock on 12/5/24.
//
import SwiftUI

// I had AI suggest to me how to make tags as a View and it showed me the novel solution of just using a Text() View, which I thought was pretty cool
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
