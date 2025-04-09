import Foundation
import Testing

@testable import OReplay

struct PeriodTests {
    @Test
    func toString_ShouldReturnCorrectString() {
        #expect(Period.past.toString == "past")
        #expect(Period.today.toString == "today")
        #expect(Period.future.toString == "future")
        #expect(Period.range(start: Date(), end: Date()).toString == "")
    }
}
