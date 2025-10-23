//
//  ListAcronymsView.swift
//  Acro
//
//  Created by Abdullah on 10/15/25.
//

import SwiftData
import SwiftUI

struct ListAcronymsView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Acronym.name) var acronyms: [Acronym]
    @State private var expandedAcronymID: PersistentIdentifier? = nil
    
    @Binding var showInput: Bool
    
    var body: some View {
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
                            Image(systemName: expandedAcronymID == acronym.persistentModelID ? "" : "chevron.down.circle.fill")
                                .font(.headline)
                                .rotationEffect(.degrees(expandedAcronymID == acronym.persistentModelID ? 180 : 0))
                        }
                        .buttonStyle(.borderless)
                        .frame(width: 30, height: 30)
                        
                    }
                    
                    if expandedAcronymID == acronym.persistentModelID {
                        ListDefinitionsView(viewModel: .init(acronym: acronym))
                    }
                }
                .padding(4)
                
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .listRowBackground(expandedAcronymID == acronym.persistentModelID ? Color(red: 0.424, green: 0.388, blue: 1).opacity(0.25) : Color.clear)
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
                        if let index = acronyms.firstIndex(of: acronym) {
                            modelContext.delete(acronyms[index])
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .onDelete(perform: deleteAcronym)
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
                        Image(systemName: "plus")
                            .padding(4)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(red: 0.424, green: 0.388, blue: 1).opacity(0.3))
                            )
                            .font(.footnote)
                    }
                }
                .foregroundStyle(.secondary)
            }
        }

    }
    func deleteAcronym(_ indexSet: IndexSet) {
        for index in indexSet {
            let acronym = acronyms[index]
            modelContext.delete(acronym)
        }
        try? modelContext.save()
    }
}

#Preview {
    ListAcronymsView(showInput: .constant(false))
        .modelContainer(for: Acronym.self, inMemory: true)
}
