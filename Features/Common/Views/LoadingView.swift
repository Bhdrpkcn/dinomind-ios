import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator

    // Animation State
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            AppTheme.Colors.background.ignoresSafeArea()

            VStack(spacing: 30) {
                //  The Mascot (Floating)
                MascotView(image: "excited", speechText: nil)
                    .offset(y: isAnimating ? -10 : 10)
                    .animation(
                        Animation.easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true),
                        value: isAnimating
                    )

                // Text
                VStack(spacing: 12) {
                    Text("KURS YÜKLENİYOR...")
                        .font(AppTheme.font(size: 20, weight: .bold))
                        .foregroundColor(AppTheme.Colors.textSecondary)

                    Text("Dinomind ile yeni bir dil öğrenen\n32 milyon kişiye katılmaya hazır ol!")
                        .font(AppTheme.font(size: 16, weight: .medium))
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }

                // Simple Spinner (System Style for now)
                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(
                        CircularProgressViewStyle(tint: AppTheme.Colors.primaryAction)
                    )
            }
        }
        .onAppear {
            isAnimating = true

            // SIMULATE BACKEND DELAY
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                coordinator.finishOnboarding()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    LoadingView()
        .environmentObject(NavigationCoordinator())
}
