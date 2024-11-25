struct EventList: Decodable {
    let events: [Event]
    let total: Int
    let limit: Int
    
    enum CodingKeys: String, CodingKey {
        case events = "data"
        case total
        case limit
    }
}
