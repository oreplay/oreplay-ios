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
        .accessibilityHidden(true)
    }
    
    @ViewBuilder func option(index: Int) -> some View {
        let option = viewModel.options[index]
        let selected = viewModel.selectedIndex == index
        
        Text(option.title)
            .font(.toolbar)
            .foregroundColor(selected ? .textPrimary : .text40)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .accessibilityIdentifier(option.a11yIdentifier)
            .accessibilityLabel(option.a11yLabel)
            .accessibilityAddTraits(addTraits(selected: selected))
            .accessibilityRemoveTraits(.isStaticText)
            .background(GeometryReader { geo in
                Color.clear.anchorPreference(key: TabPreferenceKey.self, value: .bounds) { [index: $0] }
            })
    }
    
    func addTraits(selected: Bool) -> AccessibilityTraits {
        var traits = AccessibilityTraits.isButton
        if selected {
            traits = traits.union(.isSelected)
        }
        return traits
    }
}

#Preview {
    let options = [ToolBarViewModel.Option(title: "FUTURE EVENTS"),
                   ToolBarViewModel.Option(title: "PAST EVENTS")]
    ToolBar(viewModel: ToolBarViewModel(options: options)) {
        print("selected \($0)")
    }
}
