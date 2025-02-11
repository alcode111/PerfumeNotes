//
//  ContentView.swift
//  PerfumeNotes
//
//  Created by Ismaïl on 11/02/2025.
//

import SwiftUI

struct NotesListView: View {
    let notes = Notes()
    
    @State var searchText = ""
    @State var alphabetical = false
    
    var filteredNotes: [Note] {
        notes.sort(by: alphabetical)
        
        return notes.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredNotes) { note in
                NavigationLink {
                    Image(note.image)
                        .resizable()
                        .scaledToFit()
                } label: {
                    HStack(spacing: 16) {
                        Image(note.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: Color(.label), radius: 2)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(note.name)
                                .fontWeight(.bold)
                            
                            Text(note.family.rawValue)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 4)
                                .background(note.family.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Notes")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "pyramid" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
            }
        }
    }
}

#Preview {
    NotesListView()
}
