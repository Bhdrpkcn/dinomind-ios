import SwiftUI

struct WizardHeader: View {
    let progress: Double
    let backAction: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            // Back Button
            Button(action: backAction) {
                Image(systemName: "arrow.backward")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }

            // Progress Bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    // Track (Grey)
                    Capsule()
                        .fill(AppTheme.Colors.surfaceBorder)
                        .frame(height: 16)

                    // Fill (Green)
                    Capsule()
                        .fill(AppTheme.Colors.success)
                        .frame(width: geo.size.width * CGFloat(progress), height: 16)
                    // TODO: Add the "shine" effect later if needed ?
                }
            }
            .frame(height: 16)
        }
        .padding()
    }
}

// Selectable Option Row
struct SelectionRow: View {
    let title: String
    let subtitle: String?
    let iconName: String?
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: {
            HapticManager.shared.selection()
            action()
        }) {
            HStack(spacing: 16) {
                if let icon = iconName {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                }

                // Text
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(AppTheme.font(size: 17, weight: .bold))
                        .foregroundColor(AppTheme.Colors.textPrimary)

                    if let sub = subtitle {
                        Text(sub)
                            .font(AppTheme.font(size: 14, weight: .medium))
                            .foregroundColor(AppTheme.Colors.textSecondary)
                    }
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(AppTheme.Colors.primaryAction)
                        .font(.system(size: 24))
                } else {
                    Circle()
                        .stroke(AppTheme.Colors.surfaceBorder, lineWidth: 2)
                        .frame(width: 24, height: 24)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: AppTheme.Layout.cornerRadius)
                    .fill(
                        isSelected
                            ? AppTheme.Colors.primaryAction.opacity(0.1) : AppTheme.Colors.surface
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.Layout.cornerRadius)
                    .stroke(
                        isSelected ? AppTheme.Colors.primaryAction : AppTheme.Colors.surfaceBorder,
                        lineWidth: 2
                    )
            )
            // 3D Bottom Card Lip
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.Layout.cornerRadius)
                    .stroke(
                        isSelected ? AppTheme.Colors.primaryAction : AppTheme.Colors.surfaceBorder,
                        lineWidth: 2
                    )
                    .offset(y: 2)
                    .mask(Rectangle().offset(y: 2))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
