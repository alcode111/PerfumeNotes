//
//  NoteDetailView.swift
//  PerfumeNotes
//
//  Created by Ismaïl on 12/02/2025.
//

import SwiftUI
import MapKit

struct NoteDetailView: View {
    let note: Note
    
    @State var position: MapCameraPosition
    @Namespace var namespace
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(note.family.rawValue.lowercased())
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.8),
                                Gradient.Stop(color: Color(.systemBackground), location: 1)
                            ], startPoint: .top, endPoint: .bottom)
                        }
                    
                    Image(note.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/5)
                        .shadow(color: Color(.label), radius: 3)
                        .offset(y: 50)
                }
                
                // Note name + scientific name
                VStack(alignment: .leading) {
                    Text(note.name)
                        .font(.title)
                        .bold()
                    +
                    Text("(\(note.scientificName))")
                        .italic()
                        .font(.title3)
                        .bold()
                    
                    // Description
                    Text(note.description)
                        .font(.title3)
                        .padding(.bottom, 32)
                    
                    // location name + location
                    NavigationLink {
                        NoteMap(position: .camera(MapCamera(
                            centerCoordinate: note.location,
                            distance: 500,
                            heading: 250,
                            pitch: 80))
                        )
                        .navigationTransition(.zoom(sourceID: 1, in: namespace))
                    } label: {
                        Map(position: $position) {
                            Annotation(note.name, coordinate: note.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.breathe)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .clipShape(.rect(cornerRadius: 16))
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 4)
                        }
                    }
                    .matchedTransitionSource(id: 1, in: namespace)
                    
                    HStack {
                        Spacer()
                        
                        Text(note.origin).fontWeight(.semibold)
                        
                        Spacer()
                    }
                    .padding(.bottom, 32)

                    
                    // Characteristics X
                    Text("Main characteristics:")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    ForEach(note.characteristics, id: \.self) { characteristic in
                        Text("• \(characteristic)")
                            .font(.subheadline)
                    }
                    
                    // Pairings X
                    Text("Usually paired with:")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.top, 16)
                    
                    ForEach(note.pairings, id: \.self) { pairing in
                        Text("• \(pairing)")
                            .font(.subheadline)
                    }
                    
                    // Fun fact
                    HStack {
                        Spacer()
                        
                        Text(note.funFact)
                            .italic()
                            .padding(16)
                            .background(.gray.opacity(0.3))
                            .clipShape(.rect(topLeadingRadius: 16, bottomTrailingRadius: 16))
                            .padding(.vertical, 24)
                        
                        Spacer()
                    }
                    
                    // Method of extraction
                    Text("Method of extraction:")
                        .underline()
                        .fontWeight(.semibold)
                    +
                    Text(" \(note.extraction)")
                    
                    Text("Read more:")
                        .font(.caption)
                        .padding(.top, 16)
                    
                    // Link
                    Link(note.link, destination: URL(string: note.link) ?? URL(string: "https://www.wikipedia.org/")!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding(.top, 32)
                .padding(16)
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
            }
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
    }
}

#Preview {
    let note = Notes().notes[2]
    
    NavigationStack {
        NoteDetailView(note: note,
                       position: .camera(
                        MapCamera(
                            centerCoordinate: note.location,
                            distance: 30000
                        )))
    }
}
