@DataActor
protocol NetworkMonitorContract {
    var status: NetworkStatus { get }
    
    func start()
}
