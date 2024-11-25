import Factory

final class EventsUseCase: EventsUseCaseContract {
    @Injected(\.eventsRepository) var repository
    
    func run(page: Int, period: Period) async throws -> ([Event], Bool) {
        switch period {
        case .past:
            try await fetchPastEvents(page: page)
        case .today:
            try await fetchTodayEvents()
        case .future:
            try await fetchUpcomingEvents(page: page)
        case .range(start: _, end: _):
            ([], false)
        }
    }
    
    private func fetchPastEvents(page: Int) async throws -> ([Event], Bool) {
        let list = try await repository.getEvents(page: String(page), limit: nil, period: Period.past.toString)
        return (list.events, list.total == list.limit)
    }
    
    private func fetchTodayEvents() async throws -> ([Event], Bool) {
        let list = try await repository.getEvents(page: "1", limit: "100", period: Period.today.toString)
        return (list.events, list.total == list.limit)
    }
    
    private func fetchUpcomingEvents(page: Int) async throws -> ([Event], Bool) {
        let list = try await repository.getEvents(page: String(page), limit: nil, period: Period.future.toString)
        return (list.events, list.total == list.limit)
    }
}
