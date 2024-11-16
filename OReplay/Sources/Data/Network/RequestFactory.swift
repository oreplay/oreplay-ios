final class RequestFactory: RequestFactoryContract {
    @MainActor
    func create(path: String, parameters: [String : String]? = nil) -> HttpRequestContract {
        HttpRequest("\(APIConstants.baseURL)\(path)", parameters: parameters)
    }
}
