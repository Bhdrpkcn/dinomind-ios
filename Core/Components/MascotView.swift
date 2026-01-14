import SwiftUI

struct MascotView: View {
    let image: String
    let speechText: String?

    var body: some View {
        VStack(spacing: 8) {
            // Speech Bubble (Only if text exists)
            if let text = speechText {
                SpeechBubble(text: text)
                    .transition(.scale.combined(with: .opacity))
            }

            // The Mascot
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 280)
        }
    }
}

// Helper: The Bubble Shape
private struct SpeechBubble: View {
    let text: String

    var body: some View {
        Text(text)
            .font(AppTheme.font(size: 19, weight: .semibold))
            .foregroundColor(AppTheme.Colors.textPrimary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(AppTheme.Colors.surfaceBorder)
            .cornerRadius(16)
            .overlay(
                
                Triangle()
                    .fill(AppTheme.Colors.surfaceBorder)
                    .frame(width: 20, height: 10)
                    .offset(y: 5)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            )
            .overlay(
                
                RoundedRectangle(cornerRadius: 16)
                    .stroke(AppTheme.Colors.surfaceBorder.opacity(0.5), lineWidth: 2)
            )
            
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
            .padding(.bottom, 8)
    }
}


struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    ZStack {
        AppTheme.Colors.background.ignoresSafeArea()
        MascotView(image: "excited", speechText: "Selamlar! Benim adım Dinomind!")
    }
}
