import Foundation
import Factory

enum EventError: Error {
    case invalidResponse
    case invalidData
}

final class EventsRepository: EventsRepositoryContract {
    @Injected(\.requestFactory) var requestFactory
    let defaultPageLimit = "20"
    
    @DataActor
    func getEvents(page: String, limit: String?, period: String) async throws -> EventList {
        let limit = limit ?? defaultPageLimit
        let params: [String : String] = ["page" : page, "limit" : limit, "when" : period]
        let response = try await requestFactory
            .create(path: "/events", parameters: params)
            .connect()
        
        return try response.ifOk()?.as(EventList.self) ?? { throw EventError.invalidResponse }()
    }
    
}
