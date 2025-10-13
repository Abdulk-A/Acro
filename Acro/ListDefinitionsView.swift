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
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 1)
            .opacity(0.2)
            .padding(.bottom, 8)
        
        ForEach(acronym.definitions, id: \.self) { definition in
            Text(definition)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ListDefinitionsView(acronym: Acronym(name: "AA", definitions: ["A A"]))
}
