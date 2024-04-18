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
            if !vm.reservations.isEmpty {
                List {
                    ForEach(vm.reservations, id: \.id) { reservation in
                        HStack {
                            Text(reservation.date.formatted())
                            Text("\(reservation.status)")
                        }
                    }
                }
            } else {
                VStack {
                    Image(systemName: "list.bullet.clipboard")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100)
                        .padding()
                    Text("You have no reservations.")
                }
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
