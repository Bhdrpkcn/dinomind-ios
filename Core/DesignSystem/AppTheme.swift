import SwiftUI

// MARK: - App Theme Source of Truth
struct AppTheme {
    
    // MARK: - Semantic Colors
    struct Colors {
        
        // MARK: - Brand & Actions
        /// The main "Call to Action" color (e.g., Continue buttons, Correct Answer)
        /// Light: #58CC02 | Dark: #58CC02
        static let primaryAction = Color("PrimaryAction")
        
        /// The 3D shadow/bottom lip of the main button
        /// Light: #58A700 | Dark: #58A700
        static let primaryActionShadow = Color("PrimaryActionShadow")
        
        /// Secondary buttons (e.g., "Skip", "Not Now", Unselected Options)
        /// Light: #E5E5E5 | Dark: #37464F
        static let secondaryAction = Color("SecondaryAction")
        
        /// The 3D shadow for secondary buttons
        /// Light: #CECECE | Dark: #28363D
        static let secondaryActionShadow = Color("SecondaryActionShadow")
        
        // MARK: - Backgrounds
        /// The main screen background
        /// Light: #FAFAFA | Dark: #131F24
        static let background = Color("AppBackground")
        
        /// Used for Cards, List Items, or Grouped Content
        /// Light: #FAFAFA (with border) | Dark: #15202B
        static let surface = Color("SurfaceBackground")
        
        /// The outline/stroke color for cards
        /// Light: #E5E5E5 | Dark: #3E4D59
        static let surfaceBorder = Color("SurfaceBorder")
        
        // MARK: - Text
        /// Main headings and body text
        /// Light: #3C3C3C | Dark: #FAFAFA
        static let textPrimary = Color("TextPrimary")
        
        /// Subtitles, placeholder text
        /// Light: #AFAFAF | Dark: #777777
        static let textSecondary = Color("TextSecondary")
        
        /// Text sitting on top of a Primary Action (Green) button
        /// Light: #FAFAFA | Dark: #131F24 (or White, depending on contrast preference)
        static let textOnPrimary = Color("TextOnPrimary")
        
        // MARK: - Feedback States
        /// Success / Correct Answer (Often same as Primary)
        /// Light: #58CC02 | Dark: #58CC02
        static let success = Color("Success")
        
        /// Error / Wrong Answer
        /// Light: #FF4B4B | Dark: #FF4B4B
        static let error = Color("Error")
        
        /// Shadow for the Error state
        /// Light: #EA2B2B | Dark: #EA2B2B
        static let errorShadow = Color("ErrorShadow")
        
        /// Warning / Notification
        /// Light: #FF9600 | Dark: #FF9600
        static let warning = Color("Warning")
        
        /// Information / Links
        /// Light: #1CB0F6 | Dark: #1CB0F6
        static let info = Color("Info")
        
        // MARK: - Gamification
        /// Gems / Diamonds
        /// Light: #1CB0F6 | Dark: #1CB0F6
        static let gem = Color("GemBlue")
        
        /// Streak Fire / Energy
        /// Light: #FF9600 | Dark: #FF9600
        static let streak = Color("StreakOrange")
        
        /// Hearts / Lives
        /// Light: #FF4B4B | Dark: #FF4B4B
        static let heart = Color("HeartRed")
        
        /// Legendary / Super State
        /// Light: #A56EFF | Dark: #A56EFF
        static let legendary = Color("LegendaryPurple")
    }
    
    // MARK: - Layout Constants
    struct Layout {
        static let cornerRadius: CGFloat = 16
        static let buttonHeight: CGFloat = 50
        static let standardPadding: CGFloat = 20
        static let smallPadding: CGFloat = 12
        static let borderWidth: CGFloat = 2
    }
    
    // MARK: - Typography
    // Note: We will eventually swap .system for the custom "Feather" rounded font
    static func font(size: CGFloat, weight: Font.Weight = .bold) -> Font {
        return .system(size: size, weight: weight, design: .rounded)
    }
}

// MARK: - Extension
extension Color {
    static let theme = AppTheme.Colors.self
}
