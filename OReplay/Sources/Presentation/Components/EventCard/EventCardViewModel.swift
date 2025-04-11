import SwiftUI
import Combine

final class EventCardViewModel: ObservableObject {
    @Published var dateText: String = ""
    @Published var eventNameText: String = ""
    @Published var clubNameText: String = ""
    
    init(dateText: String, eventNameText: String, clubNameText: String) {
        self.dateText = dateText
        self.eventNameText = eventNameText
        self.clubNameText = clubNameText
    }
}
