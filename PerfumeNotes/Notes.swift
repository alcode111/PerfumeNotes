//
//  Notes.swift
//  PerfumeNotes
//
//  Created by Ismaïl on 11/02/2025.
//

import Foundation

class Notes {
    var notes: [Note] = []
    
    init() {
        decodePerfumeNotesData()
    }
    
    func decodePerfumeNotesData() {
        if let url = Bundle.main.url(forResource: "perfumeNotes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                notes = try decoder.decode([Note].self, from: data)
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [Note] {
        if searchTerm.isEmpty {
            return notes
        } else {
            return notes.filter { note in
                note.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        notes.sort {
            alphabetical ? $0.name < $1.name : $0.id < $1.id
        }
    }
}
