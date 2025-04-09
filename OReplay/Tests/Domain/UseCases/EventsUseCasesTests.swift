import Testing

@testable import OReplay

struct EventsUseCasesTests {
    var repository: EventRepositoryMock!
    var sut: EventsUseCase!
    
    init() async throws {
        repository = EventRepositoryMock()
        sut = EventsUseCase(repository: repository)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.past))
    func run_pastEvents_withNoResults_shouldReturnEmptyEventList() async throws {
        // Given
        repository.eventList = EventList.emptyDummy()
        // When
        let (events, hasMorePages) = try await sut.run(page: 1, period: .past)
        // Then
        #expect(repository.getEventsCalled == 1)
        #expect(events.isEmpty)
        #expect(!hasMorePages)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.past))
    func run_pastEvents_withLessEventsThanTotal_shouldReturnLimitNumberEventsAndHasMorePages() async throws {
        // Given
        repository.eventList = EventList.dummy(10, total: 20, limit: 10)
        // When
        let (events, hasMorePages) = try await sut.run(page: 1, period: .past)
        // Then
        #expect(repository.getEventsCalled == 1)
        #expect(events.count == 10)
        #expect(hasMorePages)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.past))
    func run_pastEvents_withEqualEventsThanTotal_shouldReturnAllEventsAndNotHasMorePages() async throws {
        // Given
        repository.eventList = EventList.dummy(6, total: 6, limit: 10)
        // When
        let (events, hasMorePages) = try await sut.run(page: 1, period: .past)
        // Then
        #expect(repository.getEventsCalled == 1)
        #expect(events.count == 6)
        #expect(!hasMorePages)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.past))
    func run_pastEvents_withHTTPError_shouldReturnTheError() async throws {
        // Given
        repository.error = HTTPError.noNetworkError
        // Then
        await #expect(throws: HTTPError.noNetworkError) {
            // When
            try await sut.run(page: 1, period: .past)
        }
        #expect(repository.getEventsCalled == 1)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.past))
    func run_pastEvents_withEventError_shouldReturnTheError() async throws {
        // Given
        repository.error = EventError.invalidResponse
        // Then
        await #expect(throws: EventError.invalidResponse) {
            // When
            try await sut.run(page: 1, period: .past)
        }
        #expect(repository.getEventsCalled == 1)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.today))
    func run_todayEvents_withNoResults_shouldReturnEmptyEventList() async throws {
        // Given
        repository.eventList = EventList.emptyDummy()
        // When
        let (events, hasMorePages) = try await sut.run(page: 1, period: .today)
        // Then
        #expect(repository.getEventsCalled == 1)
        #expect(events.isEmpty)
        #expect(!hasMorePages)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.today))
    func run_todayEvents_withLessEventsThanTotal_shouldReturnLimitNumberEventsAndHasMorePages() async throws {
        // Given
        repository.eventList = EventList.dummy(10, total: 20, limit: 10)
        // When
        let (events, hasMorePages) = try await sut.run(page: 1, period: .today)
        // Then
        #expect(repository.getEventsCalled == 1)
        #expect(events.count == 10)
        #expect(hasMorePages)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.today))
    func run_todayEvents_withEqualEventsThanTotal_shouldReturnAllEventsAndNotHasMorePages() async throws {
        // Given
        repository.eventList = EventList.dummy(6, total: 6, limit: 10)
        // When
        let (events, hasMorePages) = try await sut.run(page: 1, period: .today)
        // Then
        #expect(repository.getEventsCalled == 1)
        #expect(events.count == 6)
        #expect(!hasMorePages)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.today))
    func run_todayEvents_withHTTPError_shouldReturnTheError() async throws {
        // Given
        repository.error = HTTPError.noNetworkError
        // Then
        await #expect(throws: HTTPError.noNetworkError) {
            // When
            try await sut.run(page: 1, period: .today)
        }
        #expect(repository.getEventsCalled == 1)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.today))
    func run_todayEvents_withEventError_shouldReturnTheError() async throws {
        // Given
        repository.error = EventError.invalidResponse
        // Then
        await #expect(throws: EventError.invalidResponse) {
            // When
            try await sut.run(page: 1, period: .today)
        }
        #expect(repository.getEventsCalled == 1)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.future))
    func run_futureEvents_withNoResults_shouldReturnEmptyEventList() async throws {
        // Given
        repository.eventList = EventList.emptyDummy()
        // When
        let (events, hasMorePages) = try await sut.run(page: 1, period: .future)
        // Then
        #expect(repository.getEventsCalled == 1)
        #expect(events.isEmpty)
        #expect(!hasMorePages)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.future))
    func run_futureEvents_withLessEventsThanTotal_shouldReturnLimitNumberEventsAndHasMorePages() async throws {
        // Given
        repository.eventList = EventList.dummy(10, total: 20, limit: 10)
        // When
        let (events, hasMorePages) = try await sut.run(page: 1, period: .future)
        // Then
        #expect(repository.getEventsCalled == 1)
        #expect(events.count == 10)
        #expect(hasMorePages)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.future))
    func run_futureEvents_withEqualEventsThanTotal_shouldReturnAllEventsAndNotHasMorePages() async throws {
        // Given
        repository.eventList = EventList.dummy(6, total: 6, limit: 10)
        // When
        let (events, hasMorePages) = try await sut.run(page: 1, period: .future)
        // Then
        #expect(repository.getEventsCalled == 1)
        #expect(events.count == 6)
        #expect(!hasMorePages)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.future))
    func run_futureEvents_withHTTPError_shouldReturnTheError() async throws {
        // Given
        repository.error = HTTPError.noNetworkError
        // Then
        await #expect(throws: HTTPError.noNetworkError) {
            // When
            try await sut.run(page: 1, period: .future)
        }
        #expect(repository.getEventsCalled == 1)
    }
    
    @Test(.tags(.com_oreplay_events_use_case.future))
    func run_futureEvents_withEventError_shouldReturnTheError() async throws {
        // Given
        repository.error = EventError.invalidResponse
        // Then
        await #expect(throws: EventError.invalidResponse) {
            // When
            try await sut.run(page: 1, period: .future)
        }
        #expect(repository.getEventsCalled == 1)
    }
}

extension Tag {
    enum com_oreplay_events_use_case {
        @Tag static var past: Tag
        @Tag static var today: Tag
        @Tag static var future: Tag
    }
}
