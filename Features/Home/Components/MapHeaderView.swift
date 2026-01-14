import SwiftUI

struct MapHeaderView: View {
    var body: some View {
        HStack {
            Image("flag_us")
                .resizable().frame(width: 48, height: 48).cornerRadius(4)
            Spacer()
            Label("1", systemImage: "flame.fill").foregroundColor(AppTheme.Colors.streak)
            Spacer()
            Label("500", systemImage: "gem.fill").foregroundColor(AppTheme.Colors.gem)
            Spacer()
            Label("5", systemImage: "heart.fill").foregroundColor(AppTheme.Colors.heart)
        }
        .padding(.vertical)
        .padding(.horizontal, 24)
        .font(.title2)
        .background(AppTheme.Colors.background)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}
