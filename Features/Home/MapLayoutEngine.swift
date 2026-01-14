import Foundation

class MapLayoutEngine {

    private static let amplitude: Double = 75.0
    private static let frequency: Double = 0.6

    // Available mascots
    private static let sidecarImages = [
        "angry", "bored", "energetic", "happy", "lowenergy", "thinking",
    ]

    static func process(_ sections: [MapSection]) -> [MapSection] {
        var processed = sections
        var globalIndex = 0

        for i in 0..<processed.count {
            processed[i].assignedColorIndex = i
            globalIndex += 1  // Header gap

            let levelCount = processed[i].levels.count

            for j in 0..<levelCount {
                var level = processed[i].levels[j]

                // Assign Path Index
                level.pathIndex = globalIndex

                // Calculate Current X
                let currentX = getXOffset(index: globalIndex)

                // Peak Detection
                let prevX = getXOffset(index: globalIndex - 1)
                let nextX = getXOffset(index: globalIndex + 1)

                let isPeak = abs(currentX) > abs(prevX) && abs(currentX) > abs(nextX)
                let isWideEnough = abs(currentX) > 60.0

                if isPeak && isWideEnough {
                    // Pick random img
                    let imgIndex = level.id % sidecarImages.count
                    level.sidecarImage = sidecarImages[imgIndex]

                    // FIXED POSITIONING
                    let safeDistance: Double = 140.0
                    level.sidecarOffset = currentX > 0 ? -safeDistance : safeDistance
                } else {
                    level.sidecarImage = nil
                    level.sidecarOffset = 0
                }

                processed[i].levels[j] = level
                globalIndex += 1
            }
        }

        return processed
    }

    static func getXOffset(index: Int) -> Double {
        return sin(Double(index) * frequency) * amplitude
    }
}
