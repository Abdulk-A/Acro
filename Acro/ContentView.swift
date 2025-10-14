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
    @Query(sort: \Acronym.name) var acronyms: [Acronym]
    @State private var newAcronym: String = ""
    @State private var standsFor: String = ""
    
    @State private var showInput = false
    
    @State private var expandedAcronymID: PersistentIdentifier? = nil
    
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
                        withAnimation(.easeInOut(duration: 0.4)) {
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
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(acronym.name)
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            
                            Button {
                                if expandedAcronymID == acronym.persistentModelID {
                                    expandedAcronymID = nil
                                } else {
                                    expandedAcronymID = acronym.persistentModelID
                                }
                            } label: {
                                Image(systemName: "chevron.down.circle.fill")
                                    .font(.headline)
                                    .rotationEffect(.degrees(expandedAcronymID == acronym.persistentModelID ? 180 : 0))
                            }
                            .buttonStyle(.borderless)
                            .frame(width: 30, height: 30)
                            
                        }
                        
                        if expandedAcronymID == acronym.persistentModelID {
                            ListDefinitionsView(acronym: acronym)
                        }
                    }
                    .padding(4)
                    
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .listRowBackground(expandedAcronymID == acronym.persistentModelID ? Color.secondary.opacity(0.25) : Color.clear)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if expandedAcronymID == acronym.persistentModelID {
                            expandedAcronymID = nil
                        } else {
                            expandedAcronymID = acronym.persistentModelID
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            // action here
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .padding(.bottom)
            .scrollContentBackground(.hidden)
            .background(Color(.systemGray6))
            .navigationTitle("Acro")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 3) {
                        Button {
                            withAnimation(.easeInOut(duration: 0.4)) {
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

//                        
//                        Button {
//                            
//                        } label: {
//                            Image(systemName: "minus.circle")
//                                .padding(4)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .fill(.pink.opacity(0.3))
//                                )
//                        }
//        
                        
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
