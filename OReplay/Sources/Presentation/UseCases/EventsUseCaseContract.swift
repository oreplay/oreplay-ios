protocol EventsUseCaseContract {
    func run(page: Int, period: Period) async throws -> ([Event], Bool)
}
