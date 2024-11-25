//
//  TextInput.swift
//  Davids-Recipes
//
//  Created by David Murdock on 11/23/24.
//

import SwiftUI

struct TextInput: View {
    var labelText: String
    @Binding var value: String
    var placeholderText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(labelText).font(.title3).fontWeight(.medium)
            TextField(placeholderText, text: $value)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
        }
    }
}
