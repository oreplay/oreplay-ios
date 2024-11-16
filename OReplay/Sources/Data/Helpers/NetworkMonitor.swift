import Network
import Combine

enum NetworkStatus: String {
    case connected
    case disconnected
}

@MainActor
final class Monitor: ObservableObject {
    
    static let shared = Monitor()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    
    @Published var status: NetworkStatus = .connected
    
    private init() {
        
        monitor.pathUpdateHandler = { [weak self] path in
            
            Task { @MainActor in
                self?.status = path.status == .satisfied ? .connected : .disconnected
            }
            
        }
        
    }
    
    public func start() {
        monitor.start(queue: queue)
    }
    
}
