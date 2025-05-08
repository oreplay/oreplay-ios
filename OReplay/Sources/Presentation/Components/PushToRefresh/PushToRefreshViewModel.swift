import Foundation
import Combine

final class PushToRefreshViewModel: ObservableObject {
    enum State {
        case hide
        case starting
        case refreshing
        case finishing
    }
    
    @Published var state: State = .hide {
        didSet {
            didChangeState(state)
        }
    }
    
    private let didChangeState: (State) -> Void
    let runnerWidth: CGFloat
    
    init(runnerWidth: CGFloat = 40, didChangeState: @escaping (State) -> Void) {
        self.runnerWidth = runnerWidth
        self.didChangeState = didChangeState
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
