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
        // Given
        let result = try await sut.getEvents(page: "1", limit: "1", period: "today")
        // Then
        #expect(repository.createRequestTimesCalled == 1)
        #expect(result.events.count == 1)
    }
    
    @Test
    func getEvents_withError_shouldThrowsTheError() async {
        // Given
        repository.error = .unknownNetworkError
        // Then
        await #expect(throws: HTTPError.unknownNetworkError) {
            try await sut.getEvents(page: "1", limit: "1", period: "today")
        }
        #expect(repository.createRequestTimesCalled == 1)
    }
    
    @Test
    func getEvents_withWrongData_shouldThrowsInvalidResponseError() async {
        // Given
        repository.data = Data()
        // Then
        await #expect(throws: EventError.invalidResponse) {
            try await sut.getEvents(page: "1", limit: "1", period: "today")
        }
        #expect(repository.createRequestTimesCalled == 1)
    }
    
    @Test
    func getEvents_withNilLimit_shouldReturnsDefaultPageLimitElements() async throws {
        // Given
        let result = try await sut.getEvents(page: "1", limit: nil, period: "today")
        // Then
        #expect(repository.createRequestTimesCalled == 1)
        #expect(result.events.count == Int(sut.defaultPageLimit))
    }
}
