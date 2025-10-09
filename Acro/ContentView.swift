//
//  ContentView.swift
//  Acro
//
//  Created by Abdullah on 10/2/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    //getting access to where swiftdata stores data - hence modelcontext
    @Environment(\.modelContext) var modelContext
    @Query var acronyms: [Acronym]
    @State private var newAcronym: String = ""
    @State private var standsFor: String = ""
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(acronyms) { acronym in
                    NavigationLink(value: acronym) {
                        HStack {
                            Text(acronym.name)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Acro")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Acronym.self) { acroynm in
                ListAcronymsView(acronym: acroynm)
            }
            
            VStack {
                TextField( "Add Acronym", text: $newAcronym)
                TextField("Add Definition", text: $standsFor)
            }
            .padding(.horizontal)
            
            Button {
                if newAcronym.isEmpty { return }
                if standsFor.isEmpty { return }
                addAcronym()
            } label: {
                Text( "Add Acronym" )
            }
        }
    }
    
    func addAcronym() {
        let name = newAcronym.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !name.isEmpty, !standsFor.isEmpty else { return }
        
        if let acroExists = acronyms.first(where: {$0.name == name}) {
            
            if !acroExists.definitions.contains(standsFor) {
                acroExists.definitions.append(standsFor)
            }
        }
        else {
            let acro = Acronym(name: name, definitions: [standsFor])
            modelContext.insert(acro)
        }
        
        newAcronym = ""
        standsFor = ""
    }
    

}

#Preview {
    ContentView()
        .modelContainer(for: Acronym.self, inMemory: true)
}
