import SwiftUI

struct MapNodeView: View {
    let level: MapLevel
    let action: () -> Void

    // MARK: - Perspective Constants
    private let nodeWidth: CGFloat = 85
    private let nodeHeight: CGFloat = 60
    // Depth of 3D lip
    private let shadowOffset: CGFloat = 7

    // Animation State for Active Node
    @State private var isBreathing = false

    var body: some View {
        Button(action: {
            if level.state == .locked { return }
            HapticManager.shared.impact(style: .medium)
            action()
        }) {
            ZStack {
                // Glow Ring
                if level.state == .active {
                    Ellipse()
                        .stroke(AppTheme.Colors.primaryAction.opacity(0.5), lineWidth: 14)
                        .frame(width: nodeWidth + 6, height: nodeHeight + 6)
                        .scaleEffect(isBreathing ? 1.1 : 1.0)
                        .opacity(isBreathing ? 0.0 : 1.0)
                        .animation(
                            Animation.easeOut(duration: 1.5).repeatForever(autoreverses: false),
                            value: isBreathing
                        )
                        .offset(y: shadowOffset + 1)
                }

                // 3D Shadow
                Ellipse()
                    .fill(shadowColor)
                    .frame(width: nodeWidth, height: nodeHeight)
                    // Push it down to create the perspective lip
                    .offset(y: shadowOffset)

                // Top Layer Face
                Ellipse()
                    .fill(faceColor)
                    .frame(width: nodeWidth, height: nodeHeight)

                // Icon
                Image(systemName: level.iconName)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(iconColor)
            }
            .frame(height: nodeHeight + shadowOffset)
        }
        .buttonStyle(ScaleButtonStyle())
        .onAppear {
            if level.state == .active {
                isBreathing = true
            }
        }
    }

    // MARK: - Color Logic
    private var faceColor: Color {
        switch level.state {
        case .locked: return AppTheme.Colors.surfaceBorder
        case .active: return AppTheme.Colors.primaryAction
        case .completed: return AppTheme.Colors.gem
        }
    }

    private var shadowColor: Color {
        switch level.state {
        case .locked: return Color.gray.opacity(0.5)
        case .active: return AppTheme.Colors.primaryActionShadow
        case .completed: return AppTheme.Colors.gem.opacity(0.6)
        }
    }

    private var iconColor: Color {
        switch level.state {
        case .locked: return Color.gray.opacity(0.6)
        case .active: return .white
        case .completed: return .white.opacity(0.9)
        }
    }
}

// Simple bounce animation on press
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}
