import Foundation

@DataActor
protocol URLSessionContract {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

@DataActor
extension URLSessionContract {
    func data(for request: URLRequest,
              delegate: (any URLSessionTaskDelegate)? = nil) async throws -> (Data, URLResponse) {
        try await data(for: request, delegate: delegate)
    }
}

extension URLSession: URLSessionContract { }
