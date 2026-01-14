import SwiftUI

struct ContentView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator

    var body: some View {
        Group {
            switch coordinator.currentRoot {
            case .start:
                // THE ONBOARDING FLOW
                NavigationStack(path: $coordinator.path) {
                    StartView()
                        .navigationDestination(for: AppRoute.self) { route in
                            switch route {
                            case .start(let startRoute):
                                startDestination(for: startRoute)
                            case .home:
                                EmptyView()  //TODO: Should not happen via push, handled by root switch
                            case .session:
                                EmptyView()  //TODO: Handled later
                            }
                        }
                }

            case .home:
                MainMapView()
            }
        }
    }

    // MARK: - Start Flow Factory
    @ViewBuilder
    func startDestination(for route: StartRoute) -> some View {
        switch route {
        case .intro:
            StartView()
        case .wizard:
            GenericWizardView()
        case .loading:
            LoadingView()
        case .auth:
            Text("Login Screen")
        }
    }
}
