@testable import OReplay

extension EventList {
    static func dummy(_ eventCount: Int, total: Int = 0, limit: Int = 0) -> EventList {
        let limit = limit >= eventCount ? limit : eventCount
        let total = total >= limit ? total : limit
        let events = (0 ..< eventCount).map { _ in
            Event.dummy
        }
        
        return EventList(events: events, total: total, limit: limit)
    }
    
    static func emptyDummy() -> EventList {
        .dummy(0)
    }
}
