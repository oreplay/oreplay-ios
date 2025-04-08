import Foundation

@testable import OReplay

final class RequestFactoryMock: RequestFactoryContract {
    var createRequestTimesCalled = 0
    var totalEvents: Int?
    var error: HTTPError?
    var data: Data?
    
    func create(path: String, parameters: [String : String]?) -> HTTPRequestContract {
        createRequestTimesCalled += 1
        guard let parameters, let limitString = parameters["limit"], let limit = Int(limitString) else {
            fatalError("Parameter 'limit' is required")
        }
        let data = self.data ?? getDataFor(eventsNumber: limit)
        return HTTPRequestMock(data: data, error: error)
    }
    
    func getDataFor(eventsNumber: Int) -> Data {
        EventListMock.dummyData(numberOfEvents: eventsNumber)
    }
}
