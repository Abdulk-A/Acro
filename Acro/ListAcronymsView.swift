//
//  ListAcronymsView.swift
//  Acro
//
//  Created by Abdullah on 10/2/25.
//

import SwiftUI

struct ListAcronymsView: View {
    
    let acronym: Acronym
    
    @State private var expanded: Bool = true
    
    var body: some View {
        VStack {
            ForEach(acronym.definitions, id: \.self) { definition in
                Text(definition)
                    .font(.caption)
            }
        }
        .padding(.top, 30)
        Spacer()
            .navigationTitle(acronym.name)
    }
}

#Preview {
    ListAcronymsView(acronym: Acronym(name: "ACME", definitions: ["American Customer Experience Management"]))
}
