import Network
import Combine

@testable import OReplay

@DataActor
final class NetworkMonitorMock: NetworkMonitorContract, ObservableObject {
    @Published var status: NetworkStatus = .connected
    var startCalled = false
    
    func start() {
        startCalled = true
    }
    
    func updateStatus(_ status: NetworkStatus) {
        self.status = status
    }
}
