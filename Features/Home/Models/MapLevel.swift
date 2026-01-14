import Foundation

// MARK: - Lesson Types
enum LessonType: String, Codable {
    case star  // General Lesson
    case book  // Reading
    case dumbbell  // Practice
    case chest  // Reward
    case speaking  // Microphone
    case listening  // Headphones
}

// MARK: - Level State
enum LevelState: String, Codable {
    case locked
    case active
    case completed
}

// MARK: - API Model
struct MapLevel: Identifiable, Codable {
    let id: Int
    let type: LessonType
    let state: LevelState

    // injected by the Layout Engine (Client Side Logic)
    var pathIndex: Int? = nil  // Global position on the "S" wave
    var sidecarImage: String? = nil  // Calculated based on curve
    var sidecarOffset: Double = 0.0  // -1 (Left) or 1 (Right)

    var iconName: String {
        switch type {
        case .star: return "star.fill"
        case .book: return "book.closed.fill"
        case .dumbbell: return "dumbbell.fill"
        case .chest: return "gift.fill"
        case .speaking: return "mic.fill"
        case .listening: return "headphones"
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id, type, state
    }
}

struct MapSection: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let isLocked: Bool
    var levels: [MapLevel]

    // Client Side State
    var isCollapsed: Bool = false
    var assignedColorIndex: Int = 0
    var isCurrentSection: Bool = false
    var shouldRender: Bool = true
    
    private enum CodingKeys: String, CodingKey {
        case id, title, description, isLocked, levels
    }
}
