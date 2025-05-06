import Foundation
import Combine

final class PushToRefreshViewModel: ObservableObject {
    enum State {
        case hide
        case starting
        case refreshing
        case finishing
    }
    
    @Published var state: State = .hide
    var runnerWidth: CGFloat
    
    init(runnerWidth: CGFloat = 40) {
        self.runnerWidth = runnerWidth
    }
    
    func nextState() {
        switch state {
        case .hide:
            state = .starting
        case .starting:
            state = .refreshing
        case .refreshing:
            state = .finishing
        case .finishing:
            state = .hide
        }
    }
    
    func cancel() {
        state = .hide
    }
}
