import SwiftUI

struct MainMapView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @StateObject private var viewModel = MapViewModel()
    @State private var hasScrolledToCurrent = false

    var body: some View {
        ZStack {
            AppTheme.Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                MapHeaderView()
                    .padding(.bottom, 10)
                    .zIndex(2)

                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(Array(viewModel.sections.enumerated()), id: \.element.id) { index, section in
                                if section.shouldRender {
                                    VStack(spacing: 0) {
                                        MapSectionHeaderView(
                                            title: section.title,
                                            desc: section.description,
                                            isLocked: section.isLocked,
                                            isCollapsed: section.isCollapsed,
                                            isCurrent: section.isCurrentSection,
                                            colorIndex: section.assignedColorIndex,
                                            sectionIndex: index + 1,
                                            totalSections: viewModel.sections.count
                                        )
                                        .onTapGesture {
                                            if !section.isCurrentSection {
                                                withAnimation(.spring()) {
                                                    viewModel.toggleCollapse(sectionId: section.id)
                                                }
                                            }
                                        }
                                        .zIndex(2)

                                        if !section.isCollapsed {
                                            LazyVStack(spacing: 0) {
                                                ForEach(
                                                    Array(section.levels.enumerated()),
                                                    id: \.element.id
                                                ) { lvlIndex, level in
                                                    renderLevelRow(level: level)
                                                        .id(level.id)
                                                }
                                            }
                                            .transition(.opacity)
                                        }
                                    }
                                    // FIXED BLUR
                                    .opacity(section.isLocked ? 0.6 : 1.0)
                                    .blur(radius: section.isLocked ? 3 : 0)
                                    .overlay(
                                        Group {
                                            if section.isLocked {
                                                LockOverlay()
                                            }
                                        }
                                    )
                                    .allowsHitTesting(!section.isLocked)
                                }
                            }
                        }
                        .padding(.bottom, 100)
                        .onAppear {
                            if !hasScrolledToCurrent {
                                if let activeId = findActiveLevelID() {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        withAnimation {
                                            proxy.scrollTo(activeId, anchor: .center)
                                        }
                                        hasScrolledToCurrent = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    func renderLevelRow(level: MapLevel) -> some View {
        let pathIndex = level.pathIndex ?? 0
        let xOffset = CGFloat(MapLayoutEngine.getXOffset(index: pathIndex))

        ZStack {
            // Sidecar
            if let sidecar = level.sidecarImage {
                Image(sidecar)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 175)
                    .offset(x: CGFloat(level.sidecarOffset) * 0.6, y: 0)
            }

            // Node
            MapNodeView(level: level) {
                print("Tapped \(level.id)")
            }
            .offset(x: xOffset)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
    }

    func findActiveLevelID() -> Int? {
        for section in viewModel.sections {
            if let active = section.levels.first(where: { $0.state == .active }) {
                return active.id
            }
        }
        return nil
    }
}

// Subcomponents
struct LockOverlay: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "lock.fill")
                .font(.largeTitle)
                .foregroundColor(AppTheme.Colors.textSecondary)
            Text("Complete previous section")
                .font(AppTheme.font(size: 16, weight: .bold))
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
    }
}

#Preview {
    MainMapView()
        .environmentObject(NavigationCoordinator())
}
