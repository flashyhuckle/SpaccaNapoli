import SwiftUI

struct ReservationListView: View {
    @State private var reservations = [Reservation]()
    
    var body: some View {
        List {
            if !reservations.isEmpty {
                ForEach(reservations, id: \.date) { reservation in
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
            getReservations()
        }
        .refreshable {
            getReservations()
        }
    }
    
    private func getReservations() {
        Task {
            reservations = try await FirebaseHandler.shared.loadReservations()
        }
    }
}

#Preview {
    ReservationListView()
}
