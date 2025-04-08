final class RequestFactory: RequestFactoryContract {
    
    func create(path: String, parameters: [String : String]?) -> HTTPRequestContract {
        HTTPRequest("\(APIConstants.baseURL)\(path)", parameters: parameters)
    }
    
}
