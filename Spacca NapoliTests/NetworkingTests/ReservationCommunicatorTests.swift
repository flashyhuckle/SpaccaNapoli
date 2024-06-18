import XCTest

@testable import Spacca_Napoli

final class ReservationCommunicatorTests: XCTestCase {
    
    func testPlaceReservation() async throws {
        let handler = FirebaseHandlerMock()
        let communicator = ReservationCommunicator(handler: handler)
        
        let reservation = Reservation.mockReservationResponse()[0]
        
        XCTAssertFalse(handler.reservationPlaced)
        
        try await communicator.place(reservation)
        
        XCTAssertTrue(handler.reservationPlaced)
    }
    
    func testLoadReservations() async throws {
        let handler = FirebaseHandlerMock()
        let communicator = ReservationCommunicator(handler: handler)
        
        let reservations = try await communicator.loadReservations()
        
        XCTAssertFalse(reservations.isEmpty)
    }
}
