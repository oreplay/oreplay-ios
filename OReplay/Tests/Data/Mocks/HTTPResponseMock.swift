import Foundation

@testable import OReplay

final class HTTPResponseMock: HTTPResponseContract {
    var code: Int
    
    var rawData: Data?
    
    func ifOk() -> Self? {
        <#code#>
    }
    
    func `as`<T>(_ type: T.Type) -> T? where T : Decodable {
        <#code#>
    }
}
