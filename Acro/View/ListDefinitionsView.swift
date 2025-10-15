//
//  ListDefinitionsView.swift
//  Acro
//
//  Created by Abdullah on 10/12/25.
//

import SwiftUI

struct ListDefinitionsView: View {
    @Bindable var viewModel: ListDefinitionsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Divider()
            
            ForEach(viewModel.acronym.definitions, id: \.self) { definition in
                Text(definition)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
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
