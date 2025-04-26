import SwiftUI
import Combine

final class EventCardViewModel: ObservableObject, Identifiable {
    
    enum Style {
        case large(Color)
        case small
        
        var color: Color {
            switch self {
            case .large(let color):
                color
            case .small:
                .background95
            }
        }
        
        var width: CGFloat {
            switch self {
            case .large:
                return 150
            case .small:
                return 115
            }
        }
    }
    
    struct Configuration {
        var style: Style
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
    let id = UUID()
    
    init(configuration: Configuration, accesibility: Accesibility) {
        self.configuration = configuration
        self.accessibility = accesibility
    }
}
