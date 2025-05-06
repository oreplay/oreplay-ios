import SwiftUI

struct RunnerAnimation: View {
    let state: PushToRefreshViewModel.State
    let onFinish: () -> Void
    
    @State private var runnerFrame = 0
    @State private var runnerX: CGFloat = 0
    @State private var goalX: CGFloat = UIScreen.main.bounds.width + 150
    @State private var showCurtain = false
    @State private var obstacles: [Obstacle] = []
    @State private var stopObstacles = false
    
    private let frameCount = 4
    private let timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
//    private let obstacleFrameTimer = Timer.publish(every: 0.12, on: .main, in: .common).autoconnect()
    private let runnerWidth: CGFloat
    
    init(state: PushToRefreshViewModel.State, runnerWidth: CGFloat, onFinish: @escaping () -> Void) {
        self.state = state
        self.runnerWidth = runnerWidth
        self.onFinish = onFinish
        runnerX = -runnerWidth
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Image("runner\(runnerFrame)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: runnerWidth)
                    .offset(x: runnerX, y: 0)
                    .zIndex(0.5)
                    .onReceive(timer) { _ in
                        runnerFrame = (runnerFrame + 1) % frameCount
                    }
                    .onChange(of: state, initial: true) { _, newState in
                        handleStateChange(newState, in: geometry)
                    }
                
                if state == .finishing {
                    Image("goal")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: runnerWidth / 4)
                        .offset(x: goalX, y: 0)
                }
                
                ForEach(obstacles) { obstacle in
                    let width = obstacle.width * runnerWidth
                    Image(obstacle.type.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: width)
                        .offset(x: obstacle.x, y: 0)
                        .zIndex(obstacle.zIndex)
                }
            }
        }
        .onReceive(timer) { value in
            guard !stopObstacles else { return }
            for index in obstacles.indices {
                obstacles[index].x -= obstacles[index].speed
            }
            obstacles.removeAll { $0.x < -100 }
        }
    }
    
    private func handleStateChange(_ state: PushToRefreshViewModel.State, in geometry: GeometryProxy) {
        switch state {
        case .starting:
            withAnimation(.easeInOut(duration: 0.5)) {
                runnerX = geometry.size.width / 3 - runnerWidth / 2
            }
        case .refreshing:
            startObstacles(in: geometry)
        case .finishing:
            withAnimation(.easeInOut(duration: 1.0)) {
                goalX = runnerX + runnerWidth / 2
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                onFinish()
            }
        case .hide:
            stopObstacles = true
            obstacles.removeAll()
            runnerX = -runnerWidth
            goalX = UIScreen.main.bounds.width + runnerWidth
            showCurtain = false
        }
    }
}

extension RunnerAnimation {
    enum ObstacleType: String {
        case stone
        case tree
        case bush
    }
    
    struct Obstacle: Identifiable {
        let id = UUID()
        let type: ObstacleType
        var x: CGFloat
        let zIndex: Double
        let speed: CGFloat
        
        var width: CGFloat {
            switch type {
            case .stone:
                0.8
            case .tree:
                1
            case .bush:
                0.6
            }
        }
    }
    
    private func startObstacles(in geometry: GeometryProxy) {
        stopObstacles = false
        let types: [ObstacleType] = [.stone, .tree, .bush]
        
        func scheduleNext() {
            guard !stopObstacles else { return }
            let delay = Double.random(in: 0.5...1.5)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                guard !stopObstacles, let type = types.randomElement() else { return }
                let z = Bool.random() ? 0.4 : 0.6
                let x = geometry.size.width + 100
                let new = Obstacle(type: type, x: x, zIndex: z, speed: (x + 200) / 90)
                obstacles.append(new)
//                animateObstacle(id: new.id, to: -100, duration: 2.0)
                scheduleNext()
            }
        }
        
        scheduleNext()
    }

    private func animateObstacle(id: UUID, to x: CGFloat, duration: Double) {
        guard let index = obstacles.firstIndex(where: { $0.id == id }) else { return }
        
        withAnimation(.linear(duration: duration)) {
            obstacles[index].x = x
        }
        
        // Retirar de la lista después de la animación
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            obstacles.removeAll { $0.id == id }
        }
    }

}
