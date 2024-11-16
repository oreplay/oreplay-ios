import Foundation

protocol HttpResponseContract: Sendable {
    var code: Int { get }
    var rawData: Data? { get }
    
    func `as`<T: Decodable>(_ type: T.Type) -> T?
}
