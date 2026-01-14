import SwiftUI

class StartViewModel: ObservableObject {

    // MARK: - Data Models
    struct LanguageOption: Identifiable, Equatable {
        let id = UUID()
        let name: String
        let flagIcon: String
    }

    // MARK: - State
    @Published var selectedLanguage: LanguageOption?
    @Published var progress: Double = 0.1

    // TODO: MARK: - Mock Data
    let languages = [
        LanguageOption(name: "İngilizce", flagIcon: "flag_en"),
        LanguageOption(name: "Almanca", flagIcon: "flag_de"),
        LanguageOption(name: "İspanyolca", flagIcon: "flag_es"),
        LanguageOption(name: "Fransızca", flagIcon: "flag_fr"),
    ]

    //official short lang codes
    var countryData = [
        "English": "en",  // Language: English
        "USA": "us",  // Language: English
        "Turkish": "tr",  // Language: Turkish
        "Korea": "kr",  // Language: Korean
        "China": "cn",  // Language: Chinese
        "France": "fr",  // Language: French
        "Germany": "de",  // Language: German
        "Russia": "ru",  // Language: Russian
        "Africa": "za",  // Language: Swahili
        "Argentina": "ar",  // Language: Spanish
        "Australia": "au",  // Language: English
        "Brazil": "br",  // Language: Portuguese
        "Egypt": "eg",  // Language: Arabic
        "Greece": "gr",  // Language: Greek
        "India": "in",  // Language: Hindi
        "Ireland": "ie",  // Language: Irish / English
        "Italy": "it",  // Language: Italian
        "Japan": "jp",  // Language: Japanese
        "Mexico": "mx",  // Language: Spanish
        "Netherlands": "nl",  // Language: Dutch
        "Sweden": "se",  // Language: Swedish
        "Switzerland": "ch",  // Language: German / French
        "Thailand": "th",  // Language: Thai
    ]

    // MARK: - Logic
    func selectLanguage(_ language: LanguageOption) {
        withAnimation {
            selectedLanguage = language
        }
    }
}
