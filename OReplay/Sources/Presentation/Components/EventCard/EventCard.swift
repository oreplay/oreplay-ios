import SwiftUI

struct EventCard: View {
    @ObservedObject var viewModel: EventCardViewModel
    var onTap: (() -> Void)? = nil

    var body: some View {
        ZStack(alignment: .topLeading) {
            cardBackground(.background95)
            content
                .accessibilityIdentifier(viewModel.accessibility.identifier)
                .accessibilityValue(viewModel.accessibility.value)
                .accessibilityAddTraits(.isButton)
        }
        .frame(width: 120, height: 120)
        .contentShape(Rectangle())
        .onTapGesture {
            self.onTap?()
        }
    }
}

private extension EventCard {
    @ViewBuilder var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            topText
                .padding(.top, 12)
                .frame(maxWidth: .infinity, alignment: .center)
                .accessibilityHidden(true)
            mediumText
                .padding(.top, 8)
                .padding(.horizontal, 8)
                .accessibilityHidden(true)
            bottomText
                .padding(.top, 4)
                .padding(.horizontal, 8)
                .accessibilityHidden(true)
        }
    }
    
    @ViewBuilder var topText: some View {
        Text(viewModel.configuration.dateText)
            .multilineTextAlignment(.center)
            .foregroundColor(.textPrimary)
            .font(.body2)
    }
    
    @ViewBuilder var mediumText: some View {
        Text(viewModel.configuration.eventNameText)
            .foregroundColor(.text0)
            .font(.body2)
            .multilineTextAlignment(.leading)
            .lineLimit(3)
            .truncationMode(.tail)
    }
    
    @ViewBuilder var bottomText: some View {
        Text(viewModel.configuration.clubNameText)
            .foregroundColor(Color(.text40))
            .font(.body3)
            .lineLimit(1)
    }
}

#Preview {
    let name = "VILLALGORDO- XVIII CIRCUITO PROVINCIAL DE ALBACETE DE CARRERAS DE ORIENTACION-XVII CIRCUITO PROVINCIAL DE CUENCA"
    let configuration = EventCardViewModel
        .Configuration(dateText: "15-05-2025",
                       eventNameText: name,
                       clubNameText: "COAB")
    let value = "Event May 15th. \(name) by COAB"
    let accesibilidad = EventCardViewModel.Accesibility(identifier: "EventCard",
                                                        value: value)
    HStack {
        EventCard(viewModel: EventCardViewModel(configuration: configuration,
                                                accesibility: accesibilidad)) {
            print("Tapped!")
        }
    }
}
