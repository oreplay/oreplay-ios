import Testing

@testable import OReplay

struct RequestFactoryTests {
    @Test
    func createARequestWithoutParametersWorks() async {
        // Given
        let request = RequestFactory().create(path: "/path") as? HTTPRequest
        // Then
        #expect(await request?.url == "https://www.oreplay.es/api/v1/path")
    }
    
    @Test
    func createARequestWithOneParameterWorks() async {
        // Given
        let request = RequestFactory().create(path: "/path", parameters: ["key": "value"]) as? HTTPRequest
        // Then
        #expect(await request?.url == "https://www.oreplay.es/api/v1/path?key=value")
    }
    
    @Test
    func createARequestWithTwoParametersWorks() async {
        // Given
        let parameters = ["key1": "value1", "key2": "value2"]
        let request = RequestFactory().create(path: "/path", parameters: parameters) as? HTTPRequest
        // When
        let url = await request?.url
        // Then
        #expect(url == "https://www.oreplay.es/api/v1/path?key2=value2&key1=value1" ||
                url == "https://www.oreplay.es/api/v1/path?key1=value1&key2=value2")
    }
}
