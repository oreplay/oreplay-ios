import Combine
import Factory

@MainActor
final class EventListViewModel: ObservableObject {
    @Injected(\.eventsUseCase) var useCase
    @Published var eventList: [Event] = []
    
    var page: Int = 0
    var hasMorePages = true
    
    func fetchEvents(period: Period) {
        guard hasMorePages else { return }
        page += 1
        Task { [useCase, page] in
            do {
                let (events, hasMorePages) = try await useCase.run(page: page, period: period)
                Task { @MainActor [weak self] in
                    self?.eventList.append(contentsOf: events)
                    self?.hasMorePages = hasMorePages
                }
            } catch {
                print(error)
            }
        }
    }
    
    func reset() {
        page = 0
        eventList.removeAll()
        hasMorePages = true
    }
    
}
