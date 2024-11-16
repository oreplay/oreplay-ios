import Foundation

protocol URLSessionContract {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionContract { }
