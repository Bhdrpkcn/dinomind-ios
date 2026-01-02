import SwiftUI
//TODO: ADD AUTHENTICATION FLOW

// MARK: - The Routes
enum AppRoute: Hashable {
    case start(StartRoute)  // Welcoming Flow
    case home  // Main Game Map
    case session(levelId: String)  // Game Engine
}

// Sub-routes for the Welcoming Flow
enum StartRoute: Hashable {
    case intro
    case languageSelection
    case proficiency
    case auth
}

// MARK: - The Coordinator Logic
class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    @Published var currentRoot: AppRoot = .start

    enum AppRoot {
        case start
        case home
    }

    func navigate(to route: AppRoute) {
        path.append(route)
    }

    func goBack() {
        path.removeLast()
    }

    func finishOnboarding() {
        currentRoot = .home
        path = NavigationPath()
    }
}
