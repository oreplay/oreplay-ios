import Foundation
import Testing

@testable import OReplay

struct HTTPRequestTests {
    var sut: HTTPRequest!
    
    init() async throws {
        sut = HTTPRequest("https://example.com")
    }
    
    @Test
    func initRequestWithoutParametersShouldCreateRequestWithEmptyParameters() async throws {
        let request = HTTPRequest("https://example.com")
        #expect(await request.url == "https://example.com")
    }
    
    @Test
    func initRequestWithParametersShouldCreateRequestWithTheParameters() async throws {
        let request = HTTPRequest("https://example.com", parameters: ["key": "value"])
        #expect(await request.url == "https://example.com?key=value")
    }
    
    @Test
    func addHeaderShouldAddHeaderToRequest() async throws {
        _ = await sut.header("Content-Type", "application/json")
        #expect(await sut.headers["Content-Type"] == "application/json")
    }
    
    @Test
    func addBodyShouldAddBodyToRequest() async throws {
        let body = "body".data(using: .utf8)
        _ = await sut.body(data: body)
        #expect(await sut.body == body)
    }
}
