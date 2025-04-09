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
        // Given
        let request = HTTPRequest("https://example.com")
        // Then
        #expect(await request.url == "https://example.com")
    }
    
    @Test
    func initRequestWithParametersShouldCreateRequestWithTheParameters() async throws {
        // Given
        let request = HTTPRequest("https://example.com", parameters: ["key": "value"])
        // Then
        #expect(await request.url == "https://example.com?key=value")
    }
    
    @Test
    func addHeaderShouldAddHeaderToRequest() async throws {
        // When
        _ = await sut.header("Content-Type", "application/json")
        // Then
        #expect(await sut.headers["Content-Type"] == "application/json")
    }
    
    @Test
    func addBodyShouldAddBodyToRequest() async throws {
        // Given
        let body = "body".data(using: .utf8)
        // When
        _ = await sut.body(data: body)
        // Then
        #expect(await sut.body == body)
    }
}
