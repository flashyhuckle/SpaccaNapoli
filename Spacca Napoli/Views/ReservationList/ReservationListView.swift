import SwiftUI

struct ReservationListView: View {
    @StateObject var vm: ReservationListViewModel
    
    init(
        vm: ReservationListViewModel = ReservationListViewModel()
    ) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        
    #warning ("improve look of this view")
        
        NavigationStack {
            if vm.reservations.isEmpty {
                EmptyListViewCreator.emptyReservationList()
            } else {
                List {
                    ForEach(vm.reservations, id: \.id) { reservation in
                        HStack {
                            Text(reservation.date.formatted())
                            Text("\(reservation.status)")
                        }
                    }
                }
            }
        }
        .customBackButton(color: .neapolitanGray)
        .onAppear {
//            vm.onAppear()
        }
        .refreshable {
            vm.refresh()
        }
    }
}

#Preview {
    ReservationListView()
}
