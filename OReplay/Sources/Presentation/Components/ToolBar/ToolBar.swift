import SwiftUI

struct ToolBar: View {
    
    struct TabPreferenceKey: PreferenceKey {
        static let defaultValue: [Int: Anchor<CGRect>] = [:]

        static func reduce(value: inout [Int: Anchor<CGRect>], nextValue: () -> [Int: Anchor<CGRect>]) {
            value.merge(nextValue(), uniquingKeysWith: { $1 })
        }
    }
    
    @ObservedObject var viewModel: ToolBarViewModel
    @State private var tabFrames: [Int: Anchor<CGRect>] = [:]
    
    var onSelect: ((Int) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 4) {
            options
                .onPreferenceChange(TabPreferenceKey.self) { value in
                    tabFrames = value
                }

            lines
                .accessibilityHidden(true)
        }
    }
}

private extension ToolBar {
    @ViewBuilder var options: some View {
        HStack {
            ForEach(viewModel.options.indices, id: \.self) { index in
                option(index: index)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.33)) {
                            viewModel.selectedIndex = index
                            onSelect?(index)
                        }
                    }
            }
        }
    }
    
    @ViewBuilder var lines: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.background80)

            if let anchor = tabFrames[viewModel.selectedIndex] {
                GeometryReader { proxy in
                    let frame = proxy[anchor]
                    Rectangle()
                        .frame(width: frame.width, height: 2)
                        .foregroundColor(.accent)
                        .offset(x: frame.minX)
                        .animation(.easeInOut(duration: 0.33), value: viewModel.selectedIndex)
                }
            }
        }
        .frame(height: 2)
    }
    
    @ViewBuilder func option(index: Int) -> some View {
        Text(viewModel.options[index].title)
            .font(.toolbar)
            .foregroundColor(viewModel.selectedIndex == index ? .textPrimary : .text40)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(GeometryReader { geo in
                Color.clear.anchorPreference(key: TabPreferenceKey.self, value: .bounds) { [index: $0] }
            })
    }
}

#Preview {
    let options = [ToolBarViewModel.Option(title: "FUTURE EVENTS"),
                   ToolBarViewModel.Option(title: "PAST EVENTS")]
    ToolBar(viewModel: ToolBarViewModel(options: options)) {
        print("selected \($0)")
    }
}
