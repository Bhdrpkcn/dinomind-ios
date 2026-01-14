import SwiftUI

struct DinoButton: View {

    enum Style {
        case primary  // Green "Continue"
        case secondary  // Grey "Skip"
        case danger  // Red "Quit"
        case locked  // Greyed out
        case outline  // Transparent with border
    }

    let title: String
    let style: Style
    let action: () -> Void

    // Animation State
    @State private var isPressed = false

    var body: some View {
        Button(action: {
            HapticManager.shared.impact(style: .medium)
            action()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: AppTheme.Layout.cornerRadius)
                    .fill(shadowColor)
                    .offset(y: isPressed ? 0 : 4)

                RoundedRectangle(cornerRadius: AppTheme.Layout.cornerRadius)
                    .fill(faceColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppTheme.Layout.cornerRadius)
                            .stroke(borderColor, lineWidth: style == .outline ? 2 : 0)
                    )
                    .offset(y: isPressed ? 4 : 0)

                // 3. The Text
                Text(title.uppercased())
                    .font(AppTheme.font(size: 17, weight: .bold))
                    .foregroundColor(textColor)
                    .offset(y: isPressed ? 4 : 0)
            }
        }
        .frame(height: AppTheme.Layout.buttonHeight)
        .buttonStyle(DinoButtonStyle(isPressed: $isPressed))
    }

    // MARK: - Style Logic
    private var faceColor: Color {
        switch style {
        case .primary: return AppTheme.Colors.primaryAction
        case .secondary: return AppTheme.Colors.secondaryAction
        case .danger: return AppTheme.Colors.error
        case .locked: return Color.gray.opacity(0.3)
        case .outline: return Color.clear
        }
    }

    private var shadowColor: Color {
        switch style {
        case .primary: return AppTheme.Colors.primaryActionShadow
        case .secondary: return AppTheme.Colors.secondaryActionShadow
        case .danger: return AppTheme.Colors.errorShadow
        case .locked: return Color.clear
        case .outline: return AppTheme.Colors.surfaceBorder
        }
    }

    private var textColor: Color {
        switch style {
        case .primary, .danger, .locked: return AppTheme.Colors.textOnPrimary
        case .secondary: return AppTheme.Colors.textPrimary
        case .outline: return AppTheme.Colors.primaryAction
        }
    }

    private var borderColor: Color {
        switch style {
        case .outline: return AppTheme.Colors.surfaceBorder
        default: return .clear
        }
    }
}

// "Pressed" state
struct DinoButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { _, pressed in
                withAnimation(.linear(duration: 0.1)) {
                    isPressed = pressed
                }
            }
    }
}

#Preview {
    VStack(spacing: 20) {
        DinoButton(title: "Check", style: .primary, action: {})
        DinoButton(title: "Skip", style: .secondary, action: {})
        DinoButton(title: "Quit", style: .danger, action: {})
        DinoButton(title: "I have an account", style: .outline, action: {})
    }
    .padding()
    .background(AppTheme.Colors.background)
}
