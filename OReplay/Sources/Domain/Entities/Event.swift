import Foundation

struct Event: Decodable, Identifiable {
    let id: String
    let isHidden: Bool
    let description: String
    let picture: String?
    let website: URL?
    let scope: String?
    let location: String?
    let countryCode: String?
    let initialDate: String
    let finalDate: String
    let federationId: String?
    let created: Date
    let modified: Date
    let organizer: String?
}
