import SwiftUI

struct VCarousel: View {
    @ObservedObject var viewModel: VCarouselViewModel
    private let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.events) { event in
                    EventCard(viewModel: event) {
                        viewModel.eventTapped?(event)
                    }
                }
                .padding(10)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    let title1 = "Lemoa - XI Circuito Popular de Orientación JDLF"
    let club1 = "COBI"
    let conf1 = EventCardViewModel.Configuration(style: .small, dateText: "15/05/2025", eventNameText: title1, clubNameText: club1)
    let a11y1 = EventCardViewModel.Accesibility(identifier: "EventCard1", value: "\(title1) by \(club1)")
    
    let title2 = "LIOM 2025- Longa CIM"
    let club2 = "COC"
    let conf2 = EventCardViewModel.Configuration(style: .small, dateText: "15/05/2025", eventNameText: title2, clubNameText: club2)
    let a11y2 = EventCardViewModel.Accesibility(identifier: "EventCard2", value: "\(title2) by \(club2)")
    var viewModel = [EventCardViewModel(configuration: conf1, accesibility: a11y1),
                     EventCardViewModel(configuration: conf2, accesibility: a11y2),
                     EventCardViewModel(configuration: conf1, accesibility: a11y1),
                     EventCardViewModel(configuration: conf2, accesibility: a11y2),
                     EventCardViewModel(configuration: conf1, accesibility: a11y1),
                     EventCardViewModel(configuration: conf2, accesibility: a11y2),
                     EventCardViewModel(configuration: conf1, accesibility: a11y1),
                     EventCardViewModel(configuration: conf2, accesibility: a11y2)]
    
    VCarousel(viewModel: VCarouselViewModel(events: viewModel) { event in
        print("tapped event \(event.configuration.eventNameText)")
    })
    .padding(.horizontal)
    .padding(.top, 150)
}
