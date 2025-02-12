//
//  NoteMap.swift
//  PerfumeNotes
//
//  Created by Ismaïl on 12/02/2025.
//

import SwiftUI
import MapKit

struct NoteMap: View {
    let notes = Notes()
    
    @State var position: MapCameraPosition
    @State var isSatellite = false
    
    var body: some View {
        Map(position: $position) {
            ForEach(notes.allNotes) { note in
                Annotation(note.name,
                           coordinate: note.location) {
                    Image(note.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: Color(.label), radius: 3)
                }
            }
        }
        .mapStyle(isSatellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                isSatellite.toggle()
            } label: {
                Image(systemName: isSatellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 8)
                    .padding()
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NoteMap(position: .camera(MapCamera(
        centerCoordinate: Notes().notes[0].location,
        distance: 500,
        heading: 250,
        pitch: 80)))
}
