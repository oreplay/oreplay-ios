import Testing

@testable import OReplay

struct RequestFactoryTests {
    @Test
    func createARequestWithoutParametersWorks() async {
        let request = RequestFactory().create(path: "/path") as? HTTPRequest
        
        #expect(await request?.url == "https://www.oreplay.es/api/v1/path")
    }
    
    @Test
    func createARequestWithOneParameterWorks() async {
        let request = RequestFactory().create(path: "/path", parameters: ["key": "value"]) as? HTTPRequest
        
        #expect(await request?.url == "https://www.oreplay.es/api/v1/path?key=value")
    }
    
    @Test
    func createARequestWithTwoParametersWorks() async {
        let parameters = ["key1": "value1", "key2": "value2"]
        let request = RequestFactory().create(path: "/path", parameters: parameters) as? HTTPRequest
        let url = await request?.url
        
        #expect(url == "https://www.oreplay.es/api/v1/path?key2=value2&key1=value1" ||
                url == "https://www.oreplay.es/api/v1/path?key1=value1&key2=value2")
    }
}
