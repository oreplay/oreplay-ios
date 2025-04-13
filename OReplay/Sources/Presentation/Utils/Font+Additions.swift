import SwiftUI

@dynamicMemberLookup
enum Fonts: String {
    
    static let defaultFontSize = 5
    
    case bold = "Roboto-Bold"
    case light = "Roboto-Light"
    case medium = "Roboto-Medium"
    case regular = "Roboto-Regular"
    
    subscript(dynamicMember size: String) -> Font {
        let size = CGFloat(Int(size) ?? Fonts.defaultFontSize)
        return Font.custom(rawValue, size: size)
    }
}

extension Font {
    static var h1: Font { Fonts.bold.24 }
    static var h2: Font { Fonts.medium.18 }
    static var h3: Font { Fonts.medium.14 }
    static var h4: Font { Fonts.regular.12 }
    static var h5: Font { Fonts.light.12 }
    
    static var body2: Font { Fonts.medium.14 }
    static var body3: Font { Fonts.medium.12 }
    
    static var toolbar: Font { Fonts.medium.16 }
}
