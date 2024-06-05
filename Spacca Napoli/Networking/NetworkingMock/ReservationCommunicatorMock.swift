import Foundation

final class ReservationCommunicatorMock: ReservationCommunicatorType {
    var reservationPlaced = false
    
    func place(_ reservation: Reservation) async throws {
        reservationPlaced = true
    }
    
    func loadReservations() async throws -> [Reservation] {
        Reservation.mockReservationResponse()
    }
}
