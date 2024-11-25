protocol EventsRepositoryContract {
    func getEvents(page: String, limit: String?, period: String) async throws -> EventList
}
