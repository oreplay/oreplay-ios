import SwiftUI
import Testing

@testable import OReplay

struct FontsAdditionsTest {
    @Test
    func fonts_cases_exists() {
        #expect(Fonts.bold.rawValue == "Roboto-Bold")
        #expect(Fonts.light.rawValue == "Roboto-Light")
        #expect(Fonts.medium.rawValue == "Roboto-Medium")
        #expect(Fonts.regular.rawValue == "Roboto-Regular")
    }
    
    @Test
    func subscript_withValidValue_returnsFontWithThisSize() {
        // Given
        let expectedFont = Font.custom("Roboto-Medium", size: 12)
        // Then
        #expect(Fonts.medium.12 == expectedFont)
    }
    
    @Test
    func subscript_withInvalidValue_returnsFontWithDefaultSize() {
        // Given
        let expectedFont = Font.custom("Roboto-Medium", size: 5)
        // Then
        #expect(Fonts.medium.wrongValue == expectedFont)
    }
    
    @Test
    func check_customFonts_areCorrects() async throws {
        #expect(Font.h1 == Fonts.bold.24)
        #expect(Font.h2 == Fonts.medium.18)
        #expect(Font.h3 == Fonts.medium.14)
        #expect(Font.h4 == Fonts.regular.12)
        #expect(Font.h5 == Fonts.light.12)
        #expect(Font.body2 == Fonts.medium.14)
        #expect(Font.body3 == Fonts.medium.12)
    }
}
