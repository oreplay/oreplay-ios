import SwiftUI

struct PushToRefresh: View {
    @ObservedObject var viewModel: PushToRefreshViewModel
    @State private var offsetY: CGFloat = 0
    @State private var visible: Bool = false

    var body: some View {
        ZStack {
            if visible {
                RunnerAnimation(state: viewModel.state, runnerWidth: viewModel.runnerWidth) {
                    hideWithAnimation()
                }
                .offset(y: offsetY)
                .clipped()
                .transition(.identity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.state)
        .onChange(of: viewModel.state, initial: true) { _, newState in
            onChange(newState)
        }
        .frame(height: viewModel.runnerWidth)
    }
    
    private func onChange(_ newState: PushToRefreshViewModel.State) {
        switch newState {
        case .starting:
            offsetY = -viewModel.runnerWidth
            visible = true
            withAnimation(.easeInOut(duration: 0.33)) {
                offsetY = 0
            }
        case .refreshing, .finishing:
            break
        case .hide:
            if visible {
                hideWithAnimation()
            }
        }
    }
    
    private func hideWithAnimation() {
        withAnimation(.easeInOut(duration: 0.33)) {
            offsetY = -viewModel.runnerWidth
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
            visible = false
            offsetY = -viewModel.runnerWidth
            viewModel.state = .hide
        }
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @StateObject private var viewModel = PushToRefreshViewModel(runnerWidth: 40) {
        print("newState: \($0)")
    }
    
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
