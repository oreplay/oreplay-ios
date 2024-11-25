import Foundation

@DataActor
protocol HTTPResponseContract: Sendable {
    var code: Int { get }
    var rawData: Data? { get }
    
    func ifOk() -> Self?
    func `as`<T: Decodable>(_ type: T.Type) -> T?
}
