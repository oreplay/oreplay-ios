import SwiftUI
import Testing

@testable import OReplay

struct HeaderViewModelTests {
    @Test
    func init_withTextStyleAndA11yValue_shouldHaveThisValue() {
        // Given
        let sut = HeaderViewModel(style: .text("text"), a11yValue: "a11Value")
        // Then
        #expect(sut.a11yValue == "a11Value")
    }
    
    @Test
    func init_withImageStyleAndA11yValue_shouldHaveThisValue() {
        // Given
        let sut = HeaderViewModel(style: .image(.logoDark), a11yValue: "a11Value")
        // Then
        #expect(sut.a11yValue == "a11Value")
    }
    
    @Test
    func init_withTextStyleAndNilA11yValue_shouldHaveTextValue() {
        // Given
        let sut = HeaderViewModel(style: .text("text"))
        // Then
        #expect(sut.a11yValue == "text")
    }
    
    @Test
    func init_withImageStyleAndNilA11yValue_shouldHaveEmptyValue() {
        // Given
        let sut = HeaderViewModel(style: .image(.logoDark))
        // Then
        #expect(sut.a11yValue.isEmpty)
    }
}
