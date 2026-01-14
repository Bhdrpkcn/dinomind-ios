import SwiftUI

struct MapSectionHeaderView: View {
    let title: String
    let desc: String
    let isLocked: Bool
    let isCollapsed: Bool
    let isCurrent: Bool
    let colorIndex: Int
    let sectionIndex: Int
    let totalSections: Int

    var body: some View {
        let bgColor = AppTheme.Colors.getSectionColor(index: colorIndex)

        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title.uppercased())
                        .font(AppTheme.font(size: 18, weight: .bold))
                        .foregroundColor(isLocked ? .gray : .white)

                    Text("/ \(totalSections)")
                        .font(AppTheme.font(size: 18, weight: .bold))
                        .foregroundColor(isLocked ? .gray : .white.opacity(0.4))
                        .tracking(1.0)
                }

                Text(desc)
                    .font(AppTheme.font(size: 14, weight: .medium))
                    .foregroundColor(isLocked ? .gray : .white.opacity(0.8))
            }

            Spacer()

            if !isLocked {
                if !isCurrent {
                    Image(systemName: isCollapsed ? "chevron.down" : "chevron.up")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white.opacity(0.8))
                }
            } else {
                Image(systemName: "lock.fill")
                    .foregroundColor(.gray.opacity(0.5))
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(isLocked ? AppTheme.Colors.surface : bgColor)
        .cornerRadius(16)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .shadow(color: isLocked ? .clear : bgColor.opacity(0.4), radius: 8, y: 4)
    }
}
