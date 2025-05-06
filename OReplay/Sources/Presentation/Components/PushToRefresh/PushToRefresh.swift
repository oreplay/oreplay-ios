import SwiftUI

struct PushToRefresh: View {
    @ObservedObject var viewModel: PushToRefreshViewModel
    @State private var offsetY: CGFloat = 0
    @State private var visible: Bool = true

    var body: some View {
        ZStack {
            if visible {
                RunnerAnimation(state: viewModel.state, runnerWidth: viewModel.runnerWidth) {
                    withAnimation(.easeInOut(duration: 0.33)) {
                        offsetY = -viewModel.runnerWidth // Se desplaza hacia arriba
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
                        visible = false
                        offsetY = 0 // Reset para la próxima vez
                        viewModel.state = .hide
                    }
                }
                .offset(y: offsetY)
                .clipped()
                .transition(.identity) // No fade ni scale
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.state)
        .onChange(of: viewModel.state, initial: true) { _, newState in
            if newState == .starting {
                visible = true
            }
        }
        .frame(height: viewModel.runnerWidth)
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @StateObject private var viewModel = PushToRefreshViewModel(runnerWidth: 40)
    
    var body: some View {
        Spacer()
        VStack(spacing: 20) {
            PushToRefresh(viewModel: viewModel)

            HStack {
                Button("Next State") {
                    viewModel.nextState()
                }
                .buttonStyle(.borderedProminent)

                Button("Cancel") {
                    viewModel.cancel()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
}
