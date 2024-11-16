import Foundation

enum HttpError: Error {
    case invalidUrl
    case unknownNetworkError
    case noNetworkError
}
