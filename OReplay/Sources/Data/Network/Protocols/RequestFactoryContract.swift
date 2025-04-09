protocol RequestFactoryContract {
    func create(path: String, parameters: [String : String]?) -> HTTPRequestContract
}

extension RequestFactoryContract {
    func create(path: String, parameters: [String : String]? = nil) -> HTTPRequestContract {
        create(path: path, parameters: parameters)
    }
}
