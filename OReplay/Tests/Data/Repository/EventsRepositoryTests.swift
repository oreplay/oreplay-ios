import Foundation
import Testing

@testable import OReplay

struct EventsRepositoryTests {
    let repository: RequestFactoryMock!
    let sut: EventsRepository!
    
    init() async throws {
        repository = RequestFactoryMock()
        sut = EventsRepository(requestFactory: repository)
    }
    
    @Test
    func defaultPageLimit_shouldBe20() async throws {
        #expect(sut.defaultPageLimit == "20")
    }
    
    @Test
    func getEvents_shouldReturnsAnEventList() async throws {
        let result = try await sut.getEvents(page: "1", limit: "1", period: "today")
        #expect(result.events.count == 1)
    }
    
    @Test
    func getEvents_withError_shouldThrowsTheError() async {
        repository.error = .unknownNetworkError
        await #expect(throws: HTTPError.unknownNetworkError) {
            try await sut.getEvents(page: "1", limit: "1", period: "today")
        }
    }
    
    @Test
    func getEvents_withWrongData_shouldThrowsInvalidResponseError() async {
        repository.data = Data()
        await #expect(throws: EventError.invalidResponse) {
            try await sut.getEvents(page: "1", limit: "1", period: "today")
        }
    }
    
    @Test
    func getEvents_withNilLimit_shouldReturnsDefaultPageLimitElements() async throws {
        let result = try await sut.getEvents(page: "1", limit: nil, period: "today")
        #expect(result.events.count == Int(sut.defaultPageLimit))
    }
}
