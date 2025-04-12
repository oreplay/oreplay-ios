import Foundation
import SwiftUI

final class HeaderViewModel: ObservableObject {
    
    enum Style {
        case text(String)
        case image(ImageResource)
    }
    
    @Published var style: Style
    @Published var a11yValue: String
    @Published var backButton: (() -> Void)?
    
    init(style: Style, a11yValue: String? = nil, backButton: (() -> Void)? = nil) {
        self.style = style
        self.backButton = backButton
        self.a11yValue = if let a11yValue {
            a11yValue
        } else {
            if case .text(let text) = style {
                text
            } else {
                ""
            }
        }
    }
}
