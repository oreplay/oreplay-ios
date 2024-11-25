import Foundation

enum Period: Hashable, Equatable {
    case past
    case today
    case future
    case range(start: Date, end: Date)
    
    @DataActor
    var toString: String {
        switch self {
        case .past: "past"
        case .today: "today"
        case .future: "future"
        case .range(start: _, end: _): ""
        }
    }
}
