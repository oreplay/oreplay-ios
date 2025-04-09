import Testing

@testable import OReplay

struct APIConstantsTests {
    @Test
    func baseURL() {
        #expect(APIConstants.baseURL == "https://www.oreplay.es/api/v1")
    }
}
