import SwiftUI

struct StartView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator

    var body: some View {
        ZStack {
            AppTheme.Colors.background.ignoresSafeArea()

            VStack {
                Spacer()

                MascotView(
                    image: "energetic",
                    speechText: "Selamlar! Benim adım Dino!"
                )

                Spacer()

                VStack(spacing: 16) {
                    DinoButton(title: "BAŞLA", style: .primary) {
                        coordinator.navigate(to: .start(.wizard))
                    }

                    DinoButton(title: "ZATEN HESABIM VAR", style: .secondary) {
                        coordinator.navigate(to: .start(.auth))
                    }
                }
                .padding(.horizontal, AppTheme.Layout.standardPadding)
                .padding(.bottom, 40)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    StartView()
        .environmentObject(NavigationCoordinator())
}
