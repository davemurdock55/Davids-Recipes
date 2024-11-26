//
//  FormInputs.swift
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
            Text(labelText).font(Constants.formLabelFontSize).fontWeight(Constants.formLabelFontWeight)
            TextField(placeholderText, text: $value)
                .padding(Constants.formInputPadding)
                .background(Constants.formInputBackground)
                .cornerRadius(Constants.formInputCornerRadius)
        }
    }
}


struct MultiLineTextInput: View {
    var labelText: String
    @Binding var value: String
    var placeholderText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(labelText).font(Constants.formLabelFontSize).fontWeight(Constants.formLabelFontWeight)
            ZStack(alignment: .topLeading) {
                TextEditor(text: $value)
                    .padding(Constants.formInputPadding)
                    .background(Constants.formInputBackground)
                    .cornerRadius(Constants.formInputCornerRadius)
                
                if value.isEmpty {
                    Text(placeholderText)
                        .foregroundColor(.gray)
                        .padding(.horizontal, Constants.multiLineInputHorizontalPadding)
                        .padding(.vertical, Constants.multiLineInputVerticalPadding)
                        .opacity(Constants.placeholderOpacity)
                }
            }
        }
        .padding(.vertical, Constants.formInputPadding)
    }
}

struct ListInput: View {
    var labelText: String
    @Binding var stringArray: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(labelText)
                .font(Constants.formLabelFontSize)
                .fontWeight(Constants.formLabelFontWeight)
            
//            if stringArray.isEmpty {
//                Text("* Required").foregroundStyle(.red)
//            }

            ForEach($stringArray.indices, id: \.self) { index in
                HStack {
                    TextField("Other", text: $stringArray[index])
                        .padding(Constants.formInputPadding)
                        .background(Constants.formInputBackground)
                        .cornerRadius(Constants.formInputCornerRadius)
                    Button {
                        stringArray.remove(at: index)
                    } label: {
                        Image(systemName: "trash")
                    }
                    .buttonStyle(.borderless)
                    .padding()
                    .cornerRadius(Constants.formInputCornerRadius)
                }
            }
        }
        .padding(.vertical, Constants.formInputPadding)
        
        Button(action: { stringArray.append("") }) {
            HStack {
                Spacer()
                Image(systemName: "plus.circle")
                Spacer()
            }
            .padding(.horizontal, Constants.formInputPadding)
            .cornerRadius(Constants.formInputCornerRadius)
        }
    }
}

// MARK: - Constants
private struct Constants {
    static let formLabelFontSize: Font = .title3
    static let formLabelFontWeight: Font.Weight = .medium
    static let formInputPadding: Double = 10.0
    static let formInputBackground: Color = Color(.systemGray6)
    static let formInputCornerRadius: Double = 10.0
    static let multiLineInputHorizontalPadding: Double = 14.0
    static let multiLineInputVerticalPadding: Double = 18.0
    static let placeholderOpacity: Double = 0.5
    static let lineInputButtonPadding: Double = 5.0
}
