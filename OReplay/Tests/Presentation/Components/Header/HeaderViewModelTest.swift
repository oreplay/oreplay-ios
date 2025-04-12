import SwiftUI
import Testing

@testable import OReplay

struct HeaderViewModelTests {
    @Test
    func init_withTextStyleAndA11yValue_shouldHaveThisValue() {
        let sut = HeaderViewModel(style: .text("text"), a11yValue: "a11Value")
        #expect(sut.a11yValue == "a11Value")
    }
    
    @Test
    func init_withImageStyleAndA11yValue_shouldHaveThisValue() {
        let sut = HeaderViewModel(style: .image(.logoDark), a11yValue: "a11Value")
        #expect(sut.a11yValue == "a11Value")
    }
    
    @Test
    func init_withTextStyleAndNilA11yValue_shouldHaveTextValue() {
        let sut = HeaderViewModel(style: .text("text"))
        #expect(sut.a11yValue == "text")
    }
    
    @Test
    func init_withImageStyleAndNilA11yValue_shouldHaveEmptyValue() {
        let sut = HeaderViewModel(style: .image(.logoDark))
        #expect(sut.a11yValue.isEmpty)
    }
}
