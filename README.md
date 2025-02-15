# Perfume Notes

![Show Image](readme-mockup.gif)  
**Note:** The GIF showcasing the project is a demonstration created with Rotato, highlighting the app’s key features and interactions.  

## Description  
**Perfume Notes** is an iOS app that provides detailed information about various perfume ingredients, their origins, and characteristics. Built with **SwiftUI**, it offers an interactive way to explore and learn about different fragrance notes, their geographical origins, and how they pair with other scents.  

## Features  

- **Interactive List View:** Browse through perfume notes with beautiful visuals and quick access to key information  
- **Detailed Information:** Access comprehensive details about each note, including:  
  - Scientific names  
  - Geographic origins  
  - Extraction methods  
  - Traditional uses and pairings  
  - Fun facts and historical significance  
- **Interactive Maps:** Explore the geographical origins of perfume ingredients using **MapKit** integration  
- **Advanced Filtering:** Filter notes by family (*Citrus, Floral, Oriental, Spicy, Woody*)  
- **Search Functionality:** Quickly find specific perfume notes  
- **Sorting Options:** Toggle between alphabetical and categorical organization
- **Support for Light and Dark mode:** Seamless transition between the two modes for an optimal user experience

## Technologies Used  

- **SwiftUI:** Modern declarative UI framework  
- **MapKit:** Interactive mapping and geographical visualization  
- **JSON:** Data storage and management  

## Implementation Details  
The app follows a **clean architecture** with:  

- Structured data models for perfume notes  
- Reusable **SwiftUI** views  
- Efficient **state management**  
- **MapKit** integration for geographical visualization  
- Custom UI elements and animations 

## Code snippets
The efficient data management and filtering system: the app uses a clean architecture to load and filter perfume notes, making it easy to maintain and extend. Here's how it works:

### Data Management Class
```swift
class Notes {
    var notes: [Note]
    var allNotes: [Note]
    
    init() {
        let filename = "perfumeNotes"
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                notes = try decoder.decode([Note].self, from: data)
                allNotes = notes
            } catch {
                print("Error decoding JSON data: \(error)")
                notes = []
                allNotes = []
            }
        } else {
            print("Error finding JSON file")
            notes = []
            allNotes = []
        }
    }
    
    func filter(by family: Family) -> [Note] {
        if family == .All {
            notes = allNotes
        } else {
            notes = allNotes.filter { $0.family == family }
        }
        return notes
    }
    
    func sort(by alphabetical: Bool) -> [Note] {
        notes = alphabetical ? notes.sorted { $0.name < $1.name } : allNotes
        return notes
    }
    
    func search(for text: String) -> [Note] {
        if text.isEmpty {
            return notes
        } else {
            return notes.filter { $0.name.localizedCaseInsensitiveContains(text) }
        }
    }
}
```

### Integration in NotesListView
```swift
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
    
    // View body implementation...
}
```

This implementation:

- Uses Swift's Codable protocol for clean JSON parsing
- Provides efficient filtering and sorting methods
- Maintains a clean separation of concerns
- Offers flexible search functionality

### Using GeometryReader for Responsive Layout

The app utilizes **GeometryReader** to create a dynamic and responsive layout for displaying perfume note images. This ensures images scale properly across different screen sizes while maintaining visual balance.
```swift
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
                .frame(width: geo.size.width / 1.5, height: geo.size.height / 5)
                .shadow(color: Color(.label), radius: 3)
                .offset(y: 50)
        }
    }
}
```

## Credits  

Project inspired by the app *JPApexPredators* from **Kenneth Jones' Udemy Course**: [iOS 18, SwiftUI 6, & Swift 6: Build iOS Apps From Scratch](https://www.udemy.com/course/ios-15-app-development-with-swiftui-3-and-swift-5/?couponCode=ST9MT120225A)  

**Visual Assets:**  

- App mockups created with [Rotato](https://rotato.app/)  
- Images sourced from [Unsplash](https://unsplash.com/) and [Pixabay](https://pixabay.com/)  
- Perfume notes PNGs with transparent background from [CleanPNG](https://www.cleanpng.com/)  
