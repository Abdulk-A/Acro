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
    
    @State private var showInput = false
    
    var body: some View {
        NavigationStack {
            
            
            SlidingDoorView($showInput) {
                
                HStack {
                    VStack {
                        TextField( "Add Acronym", text: $newAcronym)
                        TextField("Add Definition", text: $standsFor)
                    }
                    .padding(.horizontal)
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.75)) {
                            addAcronym()
                            showInput.toggle()
                        }
                    
                    } label: {
                        Text("ADD")
                            .frame(maxWidth: 50, maxHeight: .infinity)
                            .padding(.horizontal)
                            .background(.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .foregroundStyle(.blue.opacity(0.5))
                            
                    }
                    .animation(.easeOut(duration: 1), value: showInput)
                }

            }
//            .zIndex(1)
            
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
            .scrollContentBackground(.hidden) 
            .background(Color(.systemGray6))
            .navigationTitle("Acro")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Acronym.self) { acroynm in
                ListAcronymsView(acronym: acroynm)
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 3) {
                        Button {
                            withAnimation(.easeInOut(duration: showInput ? 0.75 : 0.2)) {
                                showInput.toggle()
                            }
                        } label: {
                            Image(systemName: "plus.circle")
                                .padding(4)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.green.opacity(0.3))
                                )
                        }

                        
                        Button {
                            
                        } label: {
                            Image(systemName: "minus.circle")
                                .padding(4)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.pink.opacity(0.3))
                                )
                        }
        
                        
                    }
                    .foregroundStyle(.secondary)
                }
            }
        }
    }
    
    func addAcronym() {
        
        if newAcronym.isEmpty { return }
        if standsFor.isEmpty { return }
        
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
