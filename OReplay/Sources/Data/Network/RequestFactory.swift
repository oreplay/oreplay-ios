final class RequestFactory: RequestFactoryContract {
    
    func create(path: String, parameters: [String : String]? = nil) -> HTTPRequestContract {
        HTTPRequest("\(APIConstants.baseURL)\(path)", parameters: parameters)
    }
    
}
