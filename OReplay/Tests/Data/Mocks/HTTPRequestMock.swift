import Foundation

@testable import OReplay

final class HTTPRequestMock: HTTPRequestContract {
    var error: HTTPError?
    var data: Data
    
    init(data: Data, error: HTTPError? = nil) {
        self.data = data
        self.error = error
    }
    
    func connect() async throws -> any HTTPResponseContract {
        guard error == nil else {
            throw error!
        }
        
        return HTTPResponse(200, data)
    }
}
