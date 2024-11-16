protocol RequestFactoryContract {
    @MainActor
    func create(path: String, parameters: [String : String]?) -> HttpRequestContract
}

extension RequestFactoryContract {
    @MainActor
    func create(path: String, parameters: [String : String]? = nil) -> HttpRequestContract {
        create(path: path, parameters: parameters)
    }
    
}
