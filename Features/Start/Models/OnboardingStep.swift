import Foundation

// type of question
enum OnboardingStepType {
    case singleSelect
    case info
}

struct OnboardingStep: Identifiable {
    let id: String
    let type: OnboardingStepType
    let progress: Double

    let mascotImage: String
    let mascotMessage: String

    let options: [OnboardingOption]
}

struct OnboardingOption: Identifiable, Equatable {
    let id: String
    let title: String
    let subtitle: String?
    let icon: String?
}
