import SwiftUI

struct OtherContent: View {
    @ObservedObject private var viewModel: OtherContentViewModel

    var body: some View {
        VStack(spacing: 0) {
            ToolBar(viewModel: viewModel.toolBarViewModel)
            
            VCarousel(viewModel: viewModel.vCarouselViewModel)
                .clipped()
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}
