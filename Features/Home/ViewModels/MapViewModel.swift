//import SwiftUI
//
//class MapViewModel: ObservableObject {
//    @Published var sections: [MapSection] = []
//
//    init() {
//        loadData()
//    }
//
//    private func loadData() {
//        // 1. Try to load from Bundle
//        if let url = Bundle.main.url(forResource: "sections", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let rawSections = try decoder.decode([MapSection].self, from: data)
//
//                // Success! Run the engine.
//                self.sections = MapLayoutEngine.process(rawSections)
//                return  // Exit early
//            } catch {
//                print("⚠️ JSON Error: \(error). Falling back to Mock Data.")
//            }
//        } else {
//            print("⚠️ 'sections.json' not found. Falling back to Mock Data.")
//        }
//
//        // 2. FALLBACK: Load Manual Mock Data (Fixes Preview Crash)
//        self.sections = MapLayoutEngine.process(generateFallbackData())
//    }
//
//    // Hardcoded data just for Previews/Safety
//    private func generateFallbackData() -> [MapSection] {
//        return [
//            MapSection(
//                id: "sec-1",
//                title: "FALLBACK 1",
//                description: "Preview Mode Active",
//                isLocked: false,
//                levels: [
//                    MapLevel(id: 1, type: .star, state: .completed),
//                    MapLevel(id: 2, type: .book, state: .active),
//                    MapLevel(id: 3, type: .chest, state: .locked),
//                ]
//            ),
//            MapSection(
//                id: "sec-2",
//                title: "FALLBACK 2",
//                description: "Locked Area",
//                isLocked: true,
//                levels: [
//                    MapLevel(id: 4, type: .dumbbell, state: .locked),
//                    MapLevel(id: 5, type: .speaking, state: .locked),
//                ]
//            ),
//        ]
//    }
//}
//extension MapViewModel {
//    func toggleCollapse(sectionId: String) {
//        if let index = sections.firstIndex(where: { $0.id == sectionId }) {
//            sections[index].isCollapsed.toggle()
//        }
//    }
//}
//

import SwiftUI

class MapViewModel: ObservableObject {
    @Published var sections: [MapSection] = []

    init() {
        loadData()
    }

    private func loadData() {
        // 1. Locate & Decode
        guard let url = Bundle.main.url(forResource: "sections", withExtension: "json") else {
            fatalError("❌ FATAL ERROR: 'sections.json' not found.")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let rawSections = try decoder.decode([MapSection].self, from: data)

            // 2. Position Engine (Layout)
            var processedSections = MapLayoutEngine.process(rawSections)

            // 3. State Engine (Collapsing & Fog)
            processedSections = applyStateLogic(sections: processedSections)

            self.sections = processedSections

        } catch {
            print("❌ JSON Error: \(error)")
        }
    }

    // MARK: - The New Logic Brain
    private func applyStateLogic(sections: [MapSection]) -> [MapSection] {
        var result = sections

        // A. Find the index of the "Current" section (The one with the active level)
        // If no active level found, assume the first unlocked section is current.
        let activeSectionIndex =
            result.firstIndex { section in
                section.levels.contains { $0.state == .active }
            } ?? 0

        // B. Loop and apply rules based on distance from Active Index
        for i in 0..<result.count {
            let distance = i - activeSectionIndex

            // Visibility Logic - Show Past, Current, and Immediate Next
            if distance > 1 {
                result[i].shouldRender = false
            } else {
                result[i].shouldRender = true
            }

            // Collapsing Logic
            if distance == 0 {
                result[i].isCurrentSection = true
                result[i].isCollapsed = false
            } else if distance == -1 {
                result[i].isCurrentSection = false
                result[i].isCollapsed = false
            } else if distance < -1 {
                result[i].isCurrentSection = false
                result[i].isCollapsed = true
            } else {
                result[i].isCurrentSection = false
                result[i].isCollapsed = false
            }
        }

        return result
    }

    // Helper for Toggling
    func toggleCollapse(sectionId: String) {
        guard let index = sections.firstIndex(where: { $0.id == sectionId }) else { return }

        // Rule: User cannot collapse the Current Section
        if !sections[index].isCurrentSection {
            sections[index].isCollapsed.toggle()
        }
    }
}
