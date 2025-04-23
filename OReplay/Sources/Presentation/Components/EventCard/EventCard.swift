import SwiftUI

struct EventCard: View {
    @ObservedObject var viewModel: EventCardViewModel
    var onTap: (() -> Void)? = nil

    var body: some View {
        ZStack(alignment: .topLeading) {
            cardBackground(viewModel.configuration.style.color)
            content
                .accessibilityIdentifier(viewModel.accessibility.identifier)
                .accessibilityValue(viewModel.accessibility.value)
                .accessibilityAddTraits(.isButton)
        }
        .frame(width: viewModel.configuration.style.width, height: 120)
        .contentShape(Rectangle())
        .onTapGesture {
            self.onTap?()
        }
    }
}

private extension EventCard {
    @ViewBuilder var content: some View {
        switch viewModel.configuration.style {
        case .large:
            large
        case .small:
            small
        }
    }
    
    @ViewBuilder var small: some View {
        VStack(alignment: .leading, spacing: 0) {
            topText
                .padding(.top, 12)
                .frame(maxWidth: .infinity, alignment: .center)
                .accessibilityHidden(true)
            mediumText(lines: 3)
                .padding(.top, 8)
                .padding(.horizontal, 8)
                .accessibilityHidden(true)
            bottomText()
                .padding(.top, 4)
                .padding(.horizontal, 8)
                .accessibilityHidden(true)
        }
    }
    
    @ViewBuilder var large: some View {
        VStack(alignment: .leading, spacing: 0) {
            mediumText(color: .text100, lines: 4)
                .padding(.top, 12)
                .padding(.horizontal, 8)
                .accessibilityHidden(true)
            Spacer(minLength: 8)
            bottomText(color: .text100)
                .padding(.bottom, 12)
                .padding(.horizontal, 8)
                .accessibilityHidden(true)
        }
    }
}
    
private extension EventCard {
    @ViewBuilder var topText: some View {
        Text(viewModel.configuration.dateText)
            .multilineTextAlignment(.center)
            .foregroundColor(.textPrimary)
            .font(.body2)
    }
    
    @ViewBuilder func mediumText(color: Color = .text0, font: Font = .body2, lines: Int = 1) -> some View {
        Text(viewModel.configuration.eventNameText)
            .foregroundColor(color)
            .font(font)
            .lineLimit(lines)
            .truncationMode(.tail)
    }
    
    @ViewBuilder func bottomText(color: Color = .text40, font: Font = .body3) -> some View {
        Text(viewModel.configuration.clubNameText)
            .foregroundColor(color)
            .font(font)
            .lineLimit(1)
            .truncationMode(.tail)
    }
}

#Preview {
    let name = "VILLALGORDO- XVIII CIRCUITO PROVINCIAL DE ALBACETE DE CARRERAS DE ORIENTACION-XVII CIRCUITO PROVINCIAL DE CUENCA"
    let smallConfiguration = EventCardViewModel
        .Configuration(style: .small,
                       dateText: "15-05-2025",
                       eventNameText: name,
                       clubNameText: "COAB")
    let largeConfiguration1 = EventCardViewModel
        .Configuration(style: .large(.orangeCard),
                       dateText: "15-05-2025",
                       eventNameText: name,
                       clubNameText: "COAB")
    let largeConfiguration2 = EventCardViewModel
        .Configuration(style: .large(.purpleCard),
                       dateText: "15-05-2025",
                       eventNameText: name,
                       clubNameText: "COAB")
    
    let value = "Event May 15th. \(name) by COAB"
    let accesibilidad = EventCardViewModel.Accesibility(identifier: "EventCard",
                                                        value: value)
    VStack {
        Spacer()
        HStack {
            EventCard(viewModel: EventCardViewModel(configuration: largeConfiguration1,
                                                    accesibility: accesibilidad)) {
                print("Tapped!")
            }
            EventCard(viewModel: EventCardViewModel(configuration: largeConfiguration2,
                                                    accesibility: accesibilidad)) {
                print("Tapped!")
            }
        }
        Spacer()
        EventCard(viewModel: EventCardViewModel(configuration: smallConfiguration,
                                                accesibility: accesibilidad)) {
            print("Tapped!")
        }
        Spacer()
    }
}
