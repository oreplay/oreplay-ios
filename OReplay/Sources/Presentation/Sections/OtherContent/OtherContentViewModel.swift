import Foundation

final class OtherContentViewModel: ObservableObject {
    @Published var toolBarViewModel: ToolBarViewModel
    @Published var vCarouselViewModel: VCarouselViewModel?
    var loadContent: ((Int) -> [EventCardViewModel])?

    init(options: [ToolBarViewModel.Option]) {
        self.toolBarViewModel = ToolBarViewModel(options: options)
    }

    func onAppear() {
        loadContent(for: toolBarViewModel.selectedIndex)
    }
    
    func loadContent(for index: Int) {
        
    }
}
