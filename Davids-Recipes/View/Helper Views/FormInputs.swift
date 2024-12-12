//
//  FormInputs.swift
//  Davids-Recipes
//
//  Created by David Murdock on 11/23/24.
//

import SwiftUI

struct ToggleInput: View {
    var labelText: String
    @Binding var isOn: Bool
    
    var body: some View {
        // looked up the exact syntax online again
        Toggle(isOn: $isOn) {
            Text(labelText)
                .font(.title3)
                .fontWeight(.medium)
        }
        .tint(.accent)
        .padding(.vertical, Constants.formInputPadding)
    }
}

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
        .padding(.vertical, Constants.formInputPadding)
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
                // found out online about TextEditor before we talked about them in class
                TextEditor(text: $value)
                    .frame(height: Constants.multiLineInputHeight)
                    .padding(Constants.formInputPadding)
                    .background(Constants.formInputBackground)
                    .cornerRadius(Constants.formInputCornerRadius)
                
                // Found out online how to do a placeholder for a TextEditor
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
                    .padding(Constants.lineInputButtonPadding)
                    .cornerRadius(Constants.formInputCornerRadius)
                }
            }
        }
        .padding(.vertical, Constants.formInputPadding)
        
        // Had some help from AI to intially build out the .append() action
        // helped me come up with the idea to just append an empty string for the user to add to (or maybe I came up with it, but I forget)
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
    static fileprivate let formLabelFontSize: Font = .title3
    static fileprivate let formLabelFontWeight: Font.Weight = .medium
    static fileprivate let formInputPadding: Double = 10.0
    static fileprivate let formInputBackground: Color = Color(.systemGray6)
    static fileprivate let formInputCornerRadius: Double = 10.0
    static fileprivate let multiLineInputHeight: Double = 100.0
    static fileprivate let multiLineInputHorizontalPadding: Double = 14.0
    static fileprivate let multiLineInputVerticalPadding: Double = 18.0
    static fileprivate let placeholderOpacity: Double = 0.5
    static fileprivate let lineInputButtonPadding: Double = 5.0
}
