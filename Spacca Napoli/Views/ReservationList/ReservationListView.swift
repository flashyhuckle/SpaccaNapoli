import SwiftUI

struct ReservationListView: View {
    @StateObject var vm: ReservationListViewModel
    
    init(
        vm: ReservationListViewModel = ReservationListViewModel()
    ) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        List {
            if !vm.reservations.isEmpty {
                ForEach(vm.reservations, id: \.id) { reservation in
                    HStack {
                        Text(reservation.date.formatted())
                        Text("\(reservation.status)")
                    }
                }
            } else {
                Text("You have no reservations yet.")
            }
        }
        .onAppear {
            vm.onAppear()
        }
        .refreshable {
            vm.refresh()
        }
    }
}

#Preview {
    ReservationListView()
}
