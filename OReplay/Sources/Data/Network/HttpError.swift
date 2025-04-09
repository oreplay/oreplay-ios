import Foundation

enum HTTPError: Error {
    case invalidUrl
    case unknownNetworkError
    case noNetworkError
}
