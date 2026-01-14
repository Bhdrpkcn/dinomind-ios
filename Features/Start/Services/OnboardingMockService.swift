import Foundation

class OnboardingMockService {
    
    static func getSteps() -> [OnboardingStep] {
        return [
            // STEP 1: Language
            OnboardingStep(
                id: "language",
                type: .singleSelect,
                progress: 0.15,
                mascotImage: "happy",
                mascotMessage: "Ne öğrenmek istersin?",
                options: [
                    OnboardingOption(id: "en", title: "English", subtitle: nil, icon: "flag_en"),
                    OnboardingOption(id: "de", title: "Deutch", subtitle: nil, icon: "flag_de"),
                    OnboardingOption(id: "tr", title: "Turkce", subtitle: nil, icon: "flag_tr"),
                    OnboardingOption(id: "es", title: "Espanyol", subtitle: nil, icon: "flag_es"),
                    OnboardingOption(id: "fr", title: "French", subtitle: nil, icon: "flag_fr")
                ]
            ),
            
            // STEP 2: Proficiency
            OnboardingStep(
                id: "proficiency",
                type: .singleSelect,
                progress: 0.30,
                mascotImage: "thinking",
                mascotMessage: "Ne kadar İngilizce biliyorsun?",
                options: [
                    OnboardingOption(id: "level_1", title: "İngilizceye yeni başlıyorum", subtitle: nil, icon: "graph_1"),
                    OnboardingOption(id: "level_2", title: "Bazı yaygın kelimeleri biliyorum", subtitle: nil, icon: "graph_2"),
                    OnboardingOption(id: "level_3", title: "Basit konuşmalar yapabilirim", subtitle: nil, icon: "graph_3"),
                    OnboardingOption(id: "level_4", title: "Çoğu konuyu ayrıntılı tartışabilirim", subtitle: nil, icon: "graph_4")
                ]
            ),
            
            // STEP 3: Daily Goal
            OnboardingStep(
                id: "goal",
                type: .singleSelect,
                progress: 0.50,
                mascotImage: "energetic",
                mascotMessage: "Günlük öğrenme hedefin ne?",
                options: [
                    OnboardingOption(id: "5_min", title: "Günde 5 dakika", subtitle: "Rahat", icon: nil),
                    OnboardingOption(id: "10_min", title: "Günde 10 dakika", subtitle: "Orta", icon: nil),
                    OnboardingOption(id: "15_min", title: "Günde 15 dakika", subtitle: "Ciddi", icon: nil),
                    OnboardingOption(id: "20_min", title: "Günde 20 dakika", subtitle: "Yoğun", icon: nil)
                ]
            )
        ]
    }
}
