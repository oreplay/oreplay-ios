import Network
import Combine
import Factory

enum NetworkStatus: String {
    case connected
    case disconnected
}

@globalActor
actor DataActor {
    static let shared = DataActor()
}

@DataActor
final class NetworkMonitor: NetworkMonitorContract, ObservableObject {
    
    static let shared = NetworkMonitor()
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
