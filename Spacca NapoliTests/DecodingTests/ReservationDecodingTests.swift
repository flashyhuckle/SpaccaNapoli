import XCTest

@testable import Spacca_Napoli

final class ReservationDecodingTests: XCTestCase {
    
    func testReservationDecodingFromJSON() throws {
        let decoder = JSONDecoder()
        let decodedArray = try decoder.decode([Reservation].self, from: Reservation.mockReservationData())
        
        XCTAssertEqual(decodedArray[0].name, "Adam Kowalski")
        XCTAssertEqual(decodedArray[0].email, "adam@kowalski.com")
        XCTAssertEqual(decodedArray[0].numberOfPeople, 4)
        XCTAssertEqual(decodedArray[0].status, .placed)
        
        XCTAssertEqual(decodedArray[1].name, "Adam Nowak")
        XCTAssertEqual(decodedArray[1].email, "adam@nowak.com")
        XCTAssertEqual(decodedArray[1].numberOfPeople, 5)
        XCTAssertEqual(decodedArray[1].status, .accepted)
        
        XCTAssertEqual(decodedArray[2].name, "Karol Krawczyk")
        XCTAssertEqual(decodedArray[2].email, "karol@krawczyk.com")
        XCTAssertEqual(decodedArray[2].numberOfPeople, 9)
        XCTAssertEqual(decodedArray[2].status, .cancelled)
    }
}
