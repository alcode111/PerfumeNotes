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
    
    var filteredNotes: [Note] {
        if searchText.isEmpty {
            return notes.notes
        } else {
            return notes.notes.filter { note in
                note.name.localizedCaseInsensitiveContains(searchText)
            }
        }
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
        }
    }
}

#Preview {
    NotesListView()
}
