import Foundation

final class OtherContentViewModel: ObservableObject {
    var toolBarViewModel: ToolBarViewModel
    var vCarouselViewModel: VCarouselViewModel
    var loadContent: ((Int) -> [EventCardViewModel])?

    init(toolBarViewModel: ToolBarViewModel) {
        self.toolBarViewModel = toolBarViewModel
        self.vCarouselViewModel = VCarouselViewModel()
    }

    func onAppear() {

    }
}
