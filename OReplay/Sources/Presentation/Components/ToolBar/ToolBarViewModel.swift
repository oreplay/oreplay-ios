import SwiftUI

final class ToolBarViewModel: ObservableObject {
    
    struct Option {
        let title: String
        let a11yLabel: String
        let a11yIdentifier: String
        
        init(title: String, a11yLabel: String? = nil, a11yIdentifier: String? = nil) {
            self.title = title
            self.a11yLabel = a11yLabel ?? title
            self.a11yIdentifier = a11yIdentifier ?? "Toolbar option \(title)"
        }
    }
    
    @Published var options: [Option]
    @Published var selectedIndex: Int

    init(options: [Option], defaultSelectedIndex: Int = 0) {
        self.options = options
        self.selectedIndex = defaultSelectedIndex
    }
}
