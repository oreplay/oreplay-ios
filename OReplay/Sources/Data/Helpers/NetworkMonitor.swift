import Network
import Combine

enum NetworkStatus: String {
    case connected
    case disconnected
}

@globalActor
actor DataActor {
    static let shared = DataActor()
}

@DataActor
final class Monitor: ObservableObject {
    
    static let shared = Monitor()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    
    @Published var status: NetworkStatus = .connected
    
    private init() {
        monitor.pathUpdateHandler = { path in
            Task { [weak self] in
                await self?.updateStatus(path.status == .satisfied ? .connected : .disconnected)
            }
        }
    }
    
    public func start() {
        monitor.start(queue: queue)
    }
    
    private func updateStatus(_ status: NetworkStatus) {
        self.status = status
    }
    
}
