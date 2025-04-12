import SwiftUI
import Combine

final class EventCardViewModel: ObservableObject {
    
    struct Configuration {
        var dateText: String = ""
        var eventNameText: String = ""
        var clubNameText: String = ""
    }
    
    struct Accesibility {
        var identifier: String = ""
        var value: String = ""
    }
    
    @Published var configuration: Configuration
    @Published var accessibility: Accesibility
    
    init(configuration: Configuration, accesibility: Accesibility) {
        self.configuration = configuration
        self.accessibility = accesibility
    }
}
