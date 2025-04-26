import SwiftUI

struct NowContent: View {
    @ObservedObject var viewModel: NowContentViewModel
    
    var body: some View {
        content
            .frame(maxWidth: .infinity, minHeight: 140)
    }
}

private extension NowContent {
    @ViewBuilder var content: some View {
        if viewModel.events.isEmpty {
            noItems
        } else {
            VStack {
                title
                    .padding(.horizontal, 16)
                HorizontalCarousel(viewModel: viewModel.carouselViewModel())
            }
        }
    }
    
    @ViewBuilder var noItems: some View {
        Text("today_events_empty")
            .font(.h1)
            .foregroundColor(.text40)
            .textShadow()
    }
    
    @ViewBuilder var title: some View {
        HStack {
            Text("today_events_title")
                .font(.h2)
                .foregroundColor(.text40)
                .multilineTextAlignment(.leading)
                .textShadow()
            Spacer()
        }
    }
}

#Preview {
    let title1 = "Lemoa - XI Circuito Popular de Orientación JDLF"
    let club1 = "COBI"
    let conf1 = EventCardViewModel.Configuration(style: .large(.orangeCard), eventNameText: title1, clubNameText: club1)
    let a11y1 = EventCardViewModel.Accesibility(identifier: "EventCard1", value: "\(title1) by \(club1)")
    let viewModel1 = EventCardViewModel(configuration: conf1, accesibility: a11y1)
    
    let title2 = "LIOM 2025- Longa CIM"
    let club2 = "COC"
    let conf2 = EventCardViewModel.Configuration(style: .large(.purpleCard), eventNameText: title2, clubNameText: club2)
    let a11y2 = EventCardViewModel.Accesibility(identifier: "EventCard2", value: "\(title2) by \(club2)")
    let viewModel2 = EventCardViewModel(configuration: conf2, accesibility: a11y2)
    
    VStack {
        Spacer()
        NowContent(viewModel: NowContentViewModel(events: []))
        Spacer()
        NowContent(viewModel: NowContentViewModel(events: [viewModel1, viewModel2, viewModel1, viewModel2]) { event in
            print("tapped event \(event.configuration.eventNameText)")
        })
        Spacer()
    }
        
    
}

