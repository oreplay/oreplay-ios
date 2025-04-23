import Testing

@testable import OReplay

struct ToolBarViewModelTests {
    @Test
    func option_withA11yLabel_shouldKeepThisValue() {
        // Given
        let sut = ToolBarViewModel.Option(title: "title", a11yLabel: "a11yLabel")
        // Then
        #expect(sut.a11yLabel == "a11yLabel")
    }
    
    @Test
    func option_withNilA11yLabel_shouldHaveTitleAsValue() {
        // Given
        let sut = ToolBarViewModel.Option(title: "title")
        // Then
        #expect(sut.a11yLabel == "title")
    }
    
    @Test
    func option_withA11yIdentifier_shouldKeepThisValue() {
        // Given
        let sut = ToolBarViewModel.Option(title: "title", a11yIdentifier: "a11yIdentifier")
        // Then
        #expect(sut.a11yIdentifier == "a11yIdentifier")
    }
    
    @Test
    func option_withNilA11yIdentifier_shouldHaveCustomValue() {
        // Given
        let sut = ToolBarViewModel.Option(title: "title")
        // Then
        #expect(sut.a11yIdentifier == "Toolbar_option_title")
    }
}
