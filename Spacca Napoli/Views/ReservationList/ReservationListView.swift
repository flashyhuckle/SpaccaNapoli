import SwiftUI

struct ReservationListView: View {
    @StateObject var vm: ReservationListViewModel
    
    init(
        vm: ReservationListViewModel = ReservationListViewModel()
    ) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            if vm.reservations.isEmpty {
                EmptyListViewCreator.emptyReservationList()
            } else {
                List {
                    if !vm.upcomingReservations().isEmpty {
                        Section {
                            ForEach(vm.upcomingReservations(), id: \.id) { reservation in
                                ReservationListSubview(reservation: reservation)
                            }
                        } header: {
                            SectionHeaderView(text: "Upcoming", color: .neapolitanGreen)
                        }
                    }

                    if !vm.pastReservations().isEmpty {
                        Section {
                            ForEach(vm.pastReservations(), id: \.id) { reservation in
                                ReservationListSubview(reservation: reservation)
                            }
                        } header: {
                            SectionHeaderView(text: "Past", color: .neapolitanGray)
                        }
                    }
                }
            }
        }
        .customBackButton(color: .neapolitanGray)
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
