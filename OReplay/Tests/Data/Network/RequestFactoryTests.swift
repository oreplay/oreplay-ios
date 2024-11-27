import Testing

@testable import OReplay

@DataActor
struct RequestFactoryTests {
    @Test
    func createARequestWithoutParametersWorks() {
        let request = RequestFactory().create(path: "/path") as? HTTPRequest
        
        #expect(request?.url == "https://www.oreplay.es/api/v1/path")
    }
    
    @Test
    func createARequestWithOneParameterWorks() {
        let request = RequestFactory().create(path: "/path", parameters: ["key": "value"]) as? HTTPRequest
        
        #expect(request?.url == "https://www.oreplay.es/api/v1/path?key=value")
    }
    
    @Test
    func createARequestWithTwoParametersWorks() {
        let parameters = ["key1": "value1", "key2": "value2"]
        let request = RequestFactory().create(path: "/path", parameters: parameters) as? HTTPRequest
        
        #expect(request?.url == "https://www.oreplay.es/api/v1/path?key2=value2&key1=value1" ||
                request?.url == "https://www.oreplay.es/api/v1/path?key1=value1&key2=value2")
    }
}
