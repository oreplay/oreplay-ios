import Foundation

extension String {
    var localized: String {
        String(localized: LocalizedStringResource(stringLiteral: self))
    }
}
