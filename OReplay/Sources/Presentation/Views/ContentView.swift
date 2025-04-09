import SwiftUI

public struct ContentView: View {
    @State private var periodSelected: Period = .past
    @ObservedObject private var viewModel = EventListViewModel()

    public var body: some View {
        VStack {
            
            Picker("Filtrar eventos", selection: $periodSelected) {
                Text("Pasado").tag(Period.past)
                Text("Hoy").tag(Period.today)
                Text("Futuros").tag(Period.future)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: periodSelected, initial: true) { (oldPeriod, newPeriod) in
                viewModel.reset()
                viewModel.fetchEvents(period: newPeriod)
            }
            
            List(viewModel.eventList) { event in
                Text(event.description)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
