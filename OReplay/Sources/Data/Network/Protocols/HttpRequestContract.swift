protocol HttpRequestContract {
    func connect() async throws -> HttpResponseContract
}
