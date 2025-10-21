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
    @Environment(\.modelContext) var modelContext
    
    @State private var editingIndex: Int? = nil
    @State private var editedText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Divider()
            
            ForEach(Array(viewModel.acronym.definitions.enumerated()), id: \.offset) { index, definition in
                
                if editingIndex == index {
                    TextField("Definition", text: $editedText)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            saveEdit(at: index)
                        }
                        .onDisappear {
                            saveEdit(at: index)
                        }
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
    
    func saveEdit(at index: Int) {
        guard editingIndex == index else { return }
        
        viewModel.acronym.definitions[index] = editedText
        editingIndex = nil
        
        try? modelContext.save()
    }
}

#Preview {
    ListDefinitionsView(
        viewModel: ListDefinitionsViewModel(
            acronym: Acronym(name: "AA", definitions: ["A A"])
        )
    )
}
