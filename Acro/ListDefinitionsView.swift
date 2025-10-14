//
//  ListDefinitionsView.swift
//  Acro
//
//  Created by Abdullah on 10/12/25.
//

import SwiftUI

struct ListDefinitionsView: View {
    let acronym: Acronym
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Divider()
            
            ForEach(acronym.definitions, id: \.self) { definition in
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
    ListDefinitionsView(acronym: Acronym(name: "AA", definitions: ["A A"]))
}
