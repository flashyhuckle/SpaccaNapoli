import SwiftUI

struct ReservationListSubview: View {
    let reservation: Reservation
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(reservation.date.formatted())
                Text(reservation.restaurant.rawValue)
            }
            Spacer()
            ZStack {
                Circle()
                    .stroke(Color.neapolitanGray)
                    .frame(width: 30)
                    
                Text("\(reservation.numberOfPeople)")
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            Text(reservation.status.rawValue)
                .frame(maxWidth: 75, maxHeight: 15)
                .lineLimit(1)
                .padding()
                .background(statusColor().opacity(0.6))
                .clipShape(Capsule())
        }
        
    }
    
    private func statusColor() -> Color {
        switch reservation.status {
        case .placed:
                .neapolitanGray
        case .accepted:
                .neapolitanGreen
        case .cancelled:
                .neapolitanRed
        }
    }
}

#Preview {
    ReservationListSubview(
        reservation: Reservation(
            id: UUID(),
            name: "Adam",
            email: "adam@adam.com",
            phone: "123456789",
            numberOfPeople: 4,
            date: Date.now,
            status: .accepted,
            restaurant: .ludna
        )
    )
}
