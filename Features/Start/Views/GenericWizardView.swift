import SwiftUI

struct GenericWizardView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    // The Data
    private let steps = OnboardingMockService.getSteps()
    
    // The State
    @State private var currentStepIndex = 0
    @State private var userAnswers: [String: String] = [:]
    
    // Computed Properties
    private var currentStep: OnboardingStep {
        steps[currentStepIndex]
    }
    
    private var selectedOptionId: String? {
        userAnswers[currentStep.id]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Header (Dynamic Progress Bar)
            WizardHeader(progress: currentStep.progress) {
                goBack()
            }
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Dynamic Mascot
                    MascotView(
                        image: currentStep.mascotImage,
                        speechText: currentStep.mascotMessage
                    )
                    .padding(.top, 20)
                    .id("mascot_\(currentStep.id)") // Force animation redraw
                    
                    // Dynamic List
                    VStack(spacing: 12) {
                        ForEach(currentStep.options) { option in
                            SelectionRow(
                                title: option.title,
                                subtitle: option.subtitle,
                                iconName: option.icon,
                                isSelected: selectedOptionId == option.id,
                                action: {
                                    userAnswers[currentStep.id] = option.id
                                }
                            )
                        }
                    }
                    .padding(.horizontal, AppTheme.Layout.standardPadding)
                }
                .padding(.bottom, 100)
            }
            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            .animation(.easeInOut, value: currentStepIndex)
            
            VStack {
                DinoButton(
                    title: "DEVAM ET",
                    style: selectedOptionId != nil ? .primary : .locked,
                    action: goNext
                )
            }
            .padding(AppTheme.Layout.standardPadding)
        }
        .background(AppTheme.Colors.background.ignoresSafeArea())
        .navigationBarHidden(true)
    }
    
    // MARK: - Navigation Logic
    private func goNext() {
        guard selectedOptionId != nil else { return }
        
        if currentStepIndex < steps.count - 1 {
            // Go to next step
            withAnimation {
                currentStepIndex += 1
            }
        } else {
            //TODO: Look here
            // FINISHED! Logic determines where to go next
            // e.g., if Proficiency is high -> Placement Test
            // e.g., if Proficiency is low -> Auth / Home
            finishWizard()
        }
    }
    
    private func goBack() {
        if currentStepIndex > 0 {
            withAnimation {
                currentStepIndex -= 1
            }
        } else {
            coordinator.goBack()
        }
    }
    
    private func finishWizard() {
        print("Wizard Complete! Answers: \(userAnswers)")
        // TODO: Decide next route based on answers
        coordinator.navigate(to: .start(.loading))
        // coordinator.navigate(to: .start(.auth))
    }
}
