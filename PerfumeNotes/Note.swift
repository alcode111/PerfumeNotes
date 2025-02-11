//
//  Note.swift
//  PerfumeNotes
//
//  Created by Ismaïl on 11/02/2025.
//

import Foundation

struct Note: Decodable {
    let id: Int
    let name: String
    let family: String
    let position: String
    let latitude: Double
    let longitude: Double
    let description: String
    let origin: String
    let scientificName: String
    let characteristics: [String]
    let pairings: [String]
    let funFact: String
    let extraction: String
    let link: String
}
