import Factory

extension Container {
    var eventsUseCase: Factory<EventsUseCaseContract> {
        Factory(self) { EventsUseCase() as EventsUseCaseContract }
    }
}
