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
}
