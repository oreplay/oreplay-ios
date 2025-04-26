import Combine

final class HorizontalCarouselViewModel: ObservableObject {
    @Published var events: [EventCardViewModel]
    var eventTapped: ((EventCardViewModel) -> Void)?
    
    init(events: [EventCardViewModel] = [], eventTapped: ((EventCardViewModel) -> Void)? = nil) {
        self.events = events
        self.eventTapped = eventTapped
    }
}
