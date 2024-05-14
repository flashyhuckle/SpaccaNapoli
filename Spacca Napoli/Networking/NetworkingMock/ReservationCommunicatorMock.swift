import Foundation

final class ReservationCommunicatorMock: ReservationCommunicatorType {
    func place(_ reservation: Reservation) async throws {
        print("reservation placed")
    }
    
    func loadReservations() async throws -> [Reservation] {
        Reservation.mockReservationResponse()
    }
}
