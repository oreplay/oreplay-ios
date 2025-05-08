import SwiftUI

struct RunnerAnimation: View {
    let state: PushToRefreshViewModel.State
    let onFinish: () -> Void
    
    @State private var runnerFrame = 0
    @State private var goalX: CGFloat
    @State private var runnerAnimated: Bool = true
    
    private let frameCount = 4
    private let timer = Timer.publish(every: 0.12, on: .main, in: .common).autoconnect()
    private let runnerWidth: CGFloat
    
    init(state: PushToRefreshViewModel.State, runnerWidth: CGFloat, onFinish: @escaping () -> Void) {
        self.state = state
        self.runnerWidth = runnerWidth
        self.onFinish = onFinish
        self.goalX = UIScreen.main.bounds.width + runnerWidth
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                runner("runner\(runnerFrame)")
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .onReceive(timer) { _ in
                        if runnerAnimated {
                            runnerFrame = (runnerFrame + 1) % frameCount
                        }
                    }
                    .onChange(of: state, initial: true) { _, newState in
                        handleStateChange(newState, in: geometry)
                    }
                
                if state == .finishing {
                    goal
                        .offset(x: goalX, y: 0)
                }
            }
        }
    }
    
    private func handleStateChange(_ state: PushToRefreshViewModel.State, in geometry: GeometryProxy) {
        switch state {
        case .starting:
            runnerAnimated = true
        case .refreshing:
            break
        case .finishing:
            withAnimation(.easeOut(duration: 0.8)) {
                goalX = runnerWidth / 2
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                runnerAnimated = false
                onFinish()
            }
        case .hide:
            runnerAnimated = false
            goalX = UIScreen.main.bounds.width + runnerWidth
        }
    }
}

private extension RunnerAnimation {
    @ViewBuilder func runner(_ name: String) -> some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: runnerWidth)
            .zIndex(0.5)
    }
    
    @ViewBuilder var goal: some View {
        Image("goal")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: runnerWidth / 4)
    }
}
