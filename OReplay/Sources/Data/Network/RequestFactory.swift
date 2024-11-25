final class RequestFactory: RequestFactoryContract {
    @DataActor
    func create(path: String, parameters: [String : String]? = nil) -> HTTPRequestContract {
        HTTPRequest("\(APIConstants.baseURL)\(path)", parameters: parameters)
    }
}
