import Foundation
import Factory

enum EventError: Error {
    case invalidResponse
    case invalidData
}

final class EventsRepository: EventsRepositoryContract {
    private let requestFactory: any RequestFactoryContract
    let defaultPageLimit = "20"
    
    convenience init() {
        @Injected(\.requestFactory) var requestFactory
        self.init(requestFactory: requestFactory)
    }
    init(requestFactory: any RequestFactoryContract) {
        self.requestFactory = requestFactory
    }
    
    func getEvents(page: String, limit: String?, period: String) async throws -> EventList {
        let limit = limit ?? defaultPageLimit
        let params: [String : String] = ["page" : page, "limit" : limit, "when" : period]
        let response = try await requestFactory
            .create(path: "/events", parameters: params)
            .connect()
        
        return try response.ifOk()?.as(EventList.self) ?? { throw EventError.invalidResponse }()
    }
    
}
