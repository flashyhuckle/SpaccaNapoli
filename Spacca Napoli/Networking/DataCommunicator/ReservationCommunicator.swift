import Foundation

protocol ReservationCommunicatorType {
    func place(_ reservation: Reservation) async throws
    func loadReservations() async throws -> [Reservation]
}

final class ReservationCommunicator{
    private let handler: FirebaseHandlerType
    
    init(
        handler: FirebaseHandlerType = FirebaseHandler.shared
    ) {
        self.handler = handler
    }
}

extension ReservationCommunicator: ReservationCommunicatorType {
    func place(_ reservation: Reservation) async throws {
        try await handler.placeReservation(reservation)
    }
    
    func loadReservations() async throws -> [Reservation] {
        try await handler.loadReservations()
    }
}
