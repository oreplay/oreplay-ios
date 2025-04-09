import Foundation
import Testing

@testable import OReplay

struct HTTPResponseTests {
    var sut: HTTPResponse!
    
    init() async throws {
        sut = HTTPResponse(200, dummyData)
    }
    
    @Test(.tags(.com_oreplay_response.status))
    func statusOk_with200Code_returnsTrue() {
        #expect(sut.status(.ok))
    }
    
    @Test(.tags(.com_oreplay_response.status))
    func statusOk_with400Code_returnsFalse() {
        // Given
        let sut = HTTPResponse(400, dummyData)
        // Then
        #expect(!sut.status(.ok))
    }
    
    @Test(.tags(.com_oreplay_response.status))
    func statusBadRequest_with200Code_returnsFalse() {
        #expect(!sut.status(.badRequest))
    }
    
    @Test(.tags(.com_oreplay_response.status))
    func statusBadRequest_with400Code_returnsTrue() {
        // Given
        let sut = HTTPResponse(400, dummyData)
        // Then
        #expect(sut.status(.badRequest))
    }
    
    @Test(.tags(.com_oreplay_response.ok))
    func ok_withStatusCodeOk_returnsTrue() {
        #expect(sut.ok())
    }
    
    @Test(.tags(.com_oreplay_response.ok))
    func ok_withStatusCodeBadRequest_returnsFalse() {
        // Given
        let sut = HTTPResponse(400, dummyData)
        // Then
        #expect(!sut.ok())
    }
    
    @Test(.tags(.com_oreplay_response.ifOk))
    func ifOk_withStatusCodeOk_returnsSelf() {
        let result: HTTPResponse? = sut.ifOk()
        // Then
        #expect(result === sut)
    }
    
    @Test(.tags(.com_oreplay_response.ifOk))
    func ifOk_withStatusCodeBadRequest_returnsNil() {
        // Given
        let sut = HTTPResponse(400, dummyData)
        // When
        let result: HTTPResponse? = sut.ifOk()
        // Then
        #expect(result == nil)
    }
    
    @Test(.tags(.com_oreplay_response.as))
    func as_withCorrectModelData_ReturnsTheModel() {
        // When
        let result = sut.as(DummyModel.self)
        // Then
        #expect(result != nil)
    }
    
    @Test(.tags(.com_oreplay_response.as))
    func as_withIncorrectModelData_ReturnsNil() {
        // Given
        let sut = HTTPResponse(200, Data("invalid json".utf8))
        // When
        let result = sut.as(DummyModel.self)
        // Then
        #expect(result == nil)
    }
    
    @Test(.tags(.com_oreplay_response.as))
    func as_withSnakeCaseData_ReturnsTheModelWithCamelCaseProperties() {
        // Given
        let sut = HTTPResponse(200, snakeCaseDummyData)
        // When
        let result = sut.as(SnakeCaseDummyModel.self)
        // Then
        #expect(result != nil)
    }
    
    @Test(.tags(.com_oreplay_response.as))
    func as_withDateData_ReturnsTheModelWithCorrectDateFormat() {
        // Given
        let expectedDate = Date(timeIntervalSince1970: 979551796.911)
        let sut = HTTPResponse(200, snakeCaseDummyData)
        // When
        let result = sut.as(SnakeCaseDummyModel.self)
        // Then
        #expect(result?.eventDate == expectedDate)
    }
}

extension HTTPResponseTests {
    
    var dummyData: Data {
    """
    {
    "name": "dummyName"
    }
    """.toData
    }
    
    var snakeCaseDummyData: Data {
    """
    {
    "event_date": "2001-01-15T09:43:16.911+00:00"
    }
    """.toData
    }
    
    struct DummyModel: Decodable {
        let name: String
    }
    
    struct SnakeCaseDummyModel: Decodable {
        let eventDate: Date
    }
    
}

extension Tag {
    enum com_oreplay_response {
        @Tag static var status: Tag
        @Tag static var ok: Tag
        @Tag static var ifOk: Tag
        @Tag static var `as`: Tag
    }
}
