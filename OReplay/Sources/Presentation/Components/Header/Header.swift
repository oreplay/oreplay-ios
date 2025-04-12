import SwiftUI

struct Header: View {
    @ObservedObject var viewModel: HeaderViewModel
    
    var body: some View {
        content
            .frame(height: 80)
    }
}

private extension Header {
    @ViewBuilder var content: some View {
        ZStack {
            Color(.background95)
                .ignoresSafeArea(edges: .top)
            
            HStack {
                backButton
                    .padding(.leading, 16)
                    .accessibilityLabel("a11y_header_back_button")
                Spacer()
            }
            
            title
                .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder var backButton: some View {
        if let action = viewModel.backButton {
            Button(action: action) {
                Image(.back)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.text0)
            }
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder var title: some View {
        switch viewModel.style {
        case .text(let text):
            Text(text)
                .font(.h1)
                .foregroundColor(.text0)
            case .image(let image):
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 25)
                .accessibilityLabel(viewModel.a11yValue)
        }
    }
}

#Preview {
    VStack {
        Header(viewModel: HeaderViewModel(style: .image(.logoDark)) {
            print("Back with Image")
        })
        .padding(.bottom, 24)
        
        Header(viewModel: HeaderViewModel(style: .text("Hello world!")) {
            print("Back with Text")
        })
        .padding(.bottom, 24)
        
        Header(viewModel: HeaderViewModel(style: .image(.logoDark)))
        .padding(.bottom, 24)
        
        Header(viewModel: HeaderViewModel(style: .text("Hello world!")))
        
        Spacer()
    }
}
