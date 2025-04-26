import Combine

final class NowContentViewModel: ObservableObject {
    @Published var events: [EventCardViewModel]
    var eventTapped: ((EventCardViewModel) -> Void)?
    
    init(events: [EventCardViewModel] = [], eventTapped: ((EventCardViewModel) -> Void)? = nil) {
        self.events = events
        self.eventTapped = eventTapped
    }
    
    func carouselViewModel() -> HorizontalCarouselViewModel {
        HorizontalCarouselViewModel(events: events, eventTapped: eventTapped)
    }
}
