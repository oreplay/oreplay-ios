import SwiftUI

extension View {
    func cardBackground(_ color: Color) -> some View {
        modifier(CardBackground(color: color))
    }
    
    func cardShadow() -> some View {
        modifier(CardShadow())
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
