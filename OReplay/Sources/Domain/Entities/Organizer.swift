struct Organizer: Decodable, Identifiable {
    let id: String
    let name: String
    let country: String
    let region: String?
}
