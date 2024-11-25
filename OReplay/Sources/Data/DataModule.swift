import Factory

extension Container {
    var requestFactory: Factory<RequestFactoryContract> {
        Factory(self) { RequestFactory() as RequestFactoryContract }
    }
    
    
}
