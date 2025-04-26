import SwiftUI

extension View {
    func cardBackground(_ color: Color) -> some View {
        modifier(CardBackground(color: color))
    }
    
    func cardShadow() -> some View {
        modifier(CardShadow())
    }
    
    func textShadow() -> some View {
        modifier(TextShadow())
    }
}

struct CardShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .shadow, radius: 2, x: 3, y: 3)
    }
}

struct CardBackground: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        color
            .cornerRadius(4)
            .cardShadow()
    }
}

struct TextShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.3), radius: 1, x: -1, y: -1)
    }
}
