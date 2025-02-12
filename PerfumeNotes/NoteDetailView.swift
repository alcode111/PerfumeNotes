//
//  NoteDetailView.swift
//  PerfumeNotes
//
//  Created by Ismaïl on 12/02/2025.
//

import SwiftUI

struct NoteDetailView: View {
    
    let note: Note
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(note.family.rawValue.lowercased())
                        .resizable()
                        .scaledToFit()
                    
                    Image(note.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/5)
                        .shadow(color: Color(.label), radius: 3)
                        .offset(y: 80)
                }
                
                // Note name + scientific name
                
                // location name + location
                
                // Characteristics X
                
                // Pairings X
                
                // Fun fact
                
                // Method of extraction
                
                // Link
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NoteDetailView(note: Notes().notes[1])
}
