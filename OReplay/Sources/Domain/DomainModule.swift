import Factory

extension Container {
    var eventsRepository: Factory<EventsRepositoryContract> {
        Factory(self) { EventsRepository() as EventsRepositoryContract }
    }
}
