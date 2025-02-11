//
//  ContentView.swift
//  PerfumeNotes
//
//  Created by Ismaïl on 11/02/2025.
//

import SwiftUI

struct NotesListView: View {
    let notes = Notes()
    var body: some View {
        List(notes.notes) { note in
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
}

#Preview {
    NotesListView()
}
