import Foundation

@testable import OReplay

extension Event {
    static var dummy: Event {
        Event(id: "id",
              isHidden: false,
              description: "description",
              picture: "picture",
              website: URL(string: "https://www.oreplay.es"),
              scope: "scope",
              location: "location",
              countryCode: "countryCode",
              initialDate: "initialDate",
              finalDate: "finalDate",
              federationId: "federationId",
              created: Date(),
              modified: Date(),
              organizerId: "organizerId",
              organizer: Organizer.dummy)
    }
}
