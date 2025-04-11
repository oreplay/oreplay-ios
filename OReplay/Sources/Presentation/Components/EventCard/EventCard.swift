import SwiftUI

struct EventCard: View {
    @ObservedObject var viewModel: EventCardViewModel
    var onTap: (() -> Void)? = nil

    var body: some View {
        ZStack(alignment: .topLeading) {
            cardBackground(.background95)
            content
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
            mediumText
                .padding(.top, 8)
                .padding(.horizontal, 8)
            bottomText
                .padding(.top, 4)
                .padding(.horizontal, 8)
        }
    }
    
    @ViewBuilder var topText: some View {
        Text(viewModel.dateText)
            .multilineTextAlignment(.center)
            .foregroundColor(.textPrimary)
            .font(.body2)
    }
    
    @ViewBuilder var mediumText: some View {
        Text(viewModel.eventNameText)
            .foregroundColor(.text0)
            .font(.body2)
            .multilineTextAlignment(.leading)
            .lineLimit(3)
            .truncationMode(.tail)
    }
    
    @ViewBuilder var bottomText: some View {
        Text(viewModel.clubNameText)
            .foregroundColor(Color(.text40))
            .font(.body3)
            .lineLimit(1)
    }
}

#Preview {
    HStack {
        EventCard(viewModel: EventCardViewModel(dateText: "15-05-2025",
                                                eventNameText: "VILLALGORDO- XVIII CIRCUITO PROVINCIAL DE ALBACETE DE CARRERAS DE ORIENTACION-XVII CIRCUITO PROVINCIAL DE CUENCA",
                                                clubNameText: "COAB")) {
            print("Tapped!")
        }
    }
}
