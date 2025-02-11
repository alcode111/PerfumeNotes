//
//  Note.swift
//  PerfumeNotes
//
//  Created by Ismaïl on 11/02/2025.
//

import SwiftUI

struct Note: Decodable, Identifiable {
    let id: Int
    let name: String
    let family: Family
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
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    enum Family: String, Decodable {
        case Citrus
        case Floral
        case Oriental
        case Spicy
        case Woody
        
        var background: Color {
            switch self {
            case .Citrus:
                .yellow
            case .Floral:
                .green
            case .Oriental:
                .orange
            case .Spicy:
                .red
            case .Woody:
                .brown
            }
        }
    }
}
