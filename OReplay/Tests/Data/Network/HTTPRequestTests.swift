import Foundation
import Testing

@testable import OReplay

struct HTTPRequestTests {
    var sut: HTTPRequest!
    
    init() async throws {
        sut = HTTPRequest("https://example.com")
    }
    
    @Test
    func initRequestWithoutParametersShouldCreateRequestWithEmptyParameters() throws {
        let request = HTTPRequest("https://example.com")
        #expect(request.url == "https://example.com")
    }
    
    @Test
    func initRequestWithParametersShouldCreateRequestWithTheParameters() throws {
        let request = HTTPRequest("https://example.com", parameters: ["key": "value"])
        #expect(request.url == "https://example.com?key=value")
    }
    
    @Test
    func addHeaderShouldAddHeaderToRequest() throws {
        _ = sut.header("Content-Type", "application/json")
        #expect(sut.headers["Content-Type"] == "application/json")
    }
    
    @Test
    func addBodyShouldAddBodyToRequest() throws {
        let body = "body".data(using: .utf8)
        _ = sut.body(data: body)
        #expect(sut.body == body)
    }
}
