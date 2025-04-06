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
        let sut = HTTPResponse(400, dummyData)
        #expect(!sut.status(.ok))
    }
    
    @Test(.tags(.com_oreplay_response.status))
    func statusBadRequest_with200Code_returnsFalse() {
        #expect(!sut.status(.badRequest))
    }
    
    @Test(.tags(.com_oreplay_response.status))
    func statusBadRequest_with400Code_returnsTrue() {
        let sut = HTTPResponse(400, dummyData)
        #expect(sut.status(.badRequest))
    }
    
    @Test(.tags(.com_oreplay_response.ok))
    func ok_withStatusCodeOk_returnsTrue() {
        #expect(sut.ok())
    }
    
    @Test(.tags(.com_oreplay_response.ok))
    func ok_withStatusCodeBadRequest_returnsFalse() {
        let sut = HTTPResponse(400, dummyData)
        #expect(!sut.ok())
    }
    
    @Test(.tags(.com_oreplay_response.ifOk))
    func ifOk_withStatusCodeOk_returnsSelf() {
        let result: HTTPResponse? = sut.ifOk()
        #expect(result === sut)
    }
    
    @Test(.tags(.com_oreplay_response.ifOk))
    func ifOk_withStatusCodeBadRequest_returnsNil() {
        let sut = HTTPResponse(400, dummyData)
        let result: HTTPResponse? = sut.ifOk()
        #expect(result == nil)
    }
    
    @Test(.tags(.com_oreplay_response.as))
    func as_withCorrectModelData_ReturnsTheModel() {
        let result = sut.as(DummyModel.self)
        #expect(result != nil)
    }
    
    @Test(.tags(.com_oreplay_response.as))
    func as_withIncorrectModelData_ReturnsNil() {
        let sut = HTTPResponse(200, Data("invalid json".utf8))
        let result = sut.as(DummyModel.self)
        #expect(result == nil)
    }
    
    @Test(.tags(.com_oreplay_response.as))
    func as_withSnakeCaseData_ReturnsTheModelWithCamelCaseProperties() {
        let sut = HTTPResponse(200, snakeCaseDummyData)
        let result = sut.as(SnakeCaseDummyModel.self)
        #expect(result != nil)
    }
    
    @Test(.tags(.com_oreplay_response.as))
    func as_withDateData_ReturnsTheModelWithCorrectDateFormat() {
        let expectedDate = Date(timeIntervalSince1970: 979551796.911)
        let sut = HTTPResponse(200, snakeCaseDummyData)
        let result = sut.as(SnakeCaseDummyModel.self)
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
