//
//  EditDefinitionView.swift
//  Acro
//
//  Created by Abdullah on 10/21/25.
//

import SwiftUI

struct EditDefinitionView: View {
    
    @Bindable var viewModel: ListDefinitionsViewModel
    @Environment(\.modelContext) var modelContext
    
    @Binding var editedText: String
    @Binding var editingIndex: Int?
    let index: Int
    
    var body: some View {
        TextField("Definition", text: $editedText)
            .onSubmit {
                saveEdit(at: index)
            }
            .onDisappear {
                saveEdit(at: index)
            }
    }
    
    func saveEdit(at index: Int) {
        guard editingIndex == index else { return }
        
        viewModel.acronym.definitions[index] = editedText
        editingIndex = nil
        
        try? modelContext.save()
    }
}

#Preview {
    EditDefinitionView(        viewModel: ListDefinitionsViewModel(
        acronym: Acronym(name: "AA", definitions: ["A A"])
    ), editedText: .constant("hello"), editingIndex: .constant(nil), index: 0)
}
