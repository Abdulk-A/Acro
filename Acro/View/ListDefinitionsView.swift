//
//  ListDefinitionsView.swift
//  Acro
//
//  Created by Abdullah on 10/12/25.
//

import SwiftData
import SwiftUI

struct ListDefinitionsView: View {
    @Bindable var viewModel: ListDefinitionsViewModel
    
    
    @State private var editingIndex: Int? = nil
    @State private var editedText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Divider()
            ForEach(Array(viewModel.acronym.definitions.enumerated()), id: \.offset) { index, definition in
                if editingIndex == index {
                    EditDefinitionView(viewModel: viewModel, editedText: $editedText, editingIndex: $editingIndex, index: index)
                } else {
                    Text(definition)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                        .onTapGesture {
                            editingIndex = index
                            editedText = definition
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
    }
}

#Preview {
    ListDefinitionsView(
        viewModel: ListDefinitionsViewModel(
            acronym: Acronym(name: "AA", definitions: ["A A"])
        )
    )
}
