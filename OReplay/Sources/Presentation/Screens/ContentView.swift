import SwiftUI

public struct ContentView: View {
    @State private var periodSelected: Period = .past
    @ObservedObject private var viewModel = EventListViewModel()

    public var body: some View {
        ZStack {
            Color(.background95)
                .ignoresSafeArea(edges: .all)
            
            VStack {
                Header(viewModel: HeaderViewModel(style: .image(.logoDark), a11yValue: "a11y_header_logo") {
                    print("back tapped")
                })
                Spacer()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
