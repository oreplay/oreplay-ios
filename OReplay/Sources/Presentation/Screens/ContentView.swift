import SwiftUI

public struct ContentView: View {
    @State private var periodSelected: Period = .past
    @ObservedObject private var viewModel = EventListViewModel()

    public var body: some View {
        ZStack {
            Color(.background95)
                .ignoresSafeArea(edges: .all)
            
            VStack {
                let options = [ToolBarViewModel.Option(title: "FUTURE EVENTS"),
                               ToolBarViewModel.Option(title: "PAST EVENTS")]
                ToolBar(viewModel: ToolBarViewModel(options: options)) {
                    print("selected \($0)")
                }
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
