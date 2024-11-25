protocol RequestFactoryContract {
    @DataActor
    func create(path: String, parameters: [String : String]?) -> HTTPRequestContract
}

extension RequestFactoryContract {
    @DataActor
    func create(path: String, parameters: [String : String]? = nil) -> HTTPRequestContract {
        create(path: path, parameters: parameters)
    }
    
}
