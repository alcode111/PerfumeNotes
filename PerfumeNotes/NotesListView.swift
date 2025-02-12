//
//  ContentView.swift
//  PerfumeNotes
//
//  Created by Ismaïl on 11/02/2025.
//

import SwiftUI
import MapKit

struct NotesListView: View {
    let notes = Notes()
    
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = Family.All
    
    var filteredNotes: [Note] {
        notes.filter(by: currentSelection)
        notes.sort(by: alphabetical)
        
        return notes.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredNotes) { note in
                NavigationLink {
                    NoteDetailView(note: note, position: .camera(
                        MapCamera(
                        centerCoordinate: note.location,
                        distance: 30000
                        )))
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
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentSelection.animation()) {
                            ForEach(Family.allCases) { family in
                                Label(family.rawValue, systemImage: family.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
    }
}

#Preview {
    NotesListView()
}
