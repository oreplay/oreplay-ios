@DataActor
protocol HTTPRequestContract {
    func connect() async throws -> HTTPResponseContract
}
