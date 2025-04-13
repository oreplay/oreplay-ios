import Testing

@testable import OReplay

struct ToolBarViewModelTests {
    @Test
    func option_withA11yLabel_shouldKeepThisValue() {
        let sut = ToolBarViewModel.Option(title: "title", a11yLabel: "a11yLabel")
        #expect(sut.a11yLabel == "a11yLabel")
    }
    
    @Test
    func option_withNilA11yLabel_shouldHaveTitleAsValue() {
        let sut = ToolBarViewModel.Option(title: "title")
        #expect(sut.a11yLabel == "title")
    }
    
    @Test
    func option_withA11yIdentifier_shouldKeepThisValue() {
        let sut = ToolBarViewModel.Option(title: "title", a11yIdentifier: "a11yIdentifier")
        #expect(sut.a11yIdentifier == "a11yIdentifier")
    }
    
    @Test
    func option_withNilA11yIdentifier_shouldHaveCustomValue() {
        let sut = ToolBarViewModel.Option(title: "title")
        #expect(sut.a11yIdentifier == "Toolbar_option_title")
    }
}
