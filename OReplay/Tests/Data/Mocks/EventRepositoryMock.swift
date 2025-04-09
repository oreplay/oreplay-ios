@testable import OReplay

final class EventRepositoryMock: EventsRepositoryContract {
    var getEventsCalled = 0
    var eventList: EventList?
    var error: Error?
    
    func getEvents(page: String, limit: String?, period: String) async throws -> EventList {
        getEventsCalled += 1
        
        if let error {
            throw error
        } else if let eventList {
            return eventList
        } else {
            fatalError("Should provide error or event list")
        }
    }
}
