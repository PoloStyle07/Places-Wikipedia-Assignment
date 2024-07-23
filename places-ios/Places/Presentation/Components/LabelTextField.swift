//
//  LabelTextField.swift
//  Places
//
//  Created by Marc Janga on 23/07/2024.
//

import SwiftUI

struct LabelTextField: View {
    let title: String
    let input: Binding<String>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            TextField("", text: input)
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.black)
                )
        }
        .accessibilityElement()
        .accessibilityLabel("\(title), Textfield")
    }
}

#Preview {
    @State var input = ""
    
    return LabelTextField(
        title: "Name",
        input: $input
    )
    .padding(16)
}
