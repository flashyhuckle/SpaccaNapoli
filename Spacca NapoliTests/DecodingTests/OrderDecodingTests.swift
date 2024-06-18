import XCTest

@testable import Spacca_Napoli

final class OrderDecodingTests: XCTestCase {
    
    func testOrderDecodingFromJSON() throws {
        let decoder = JSONDecoder()
        let decodedArray = try decoder.decode([Order].self, from: Order.mockOrderData())
        guard let decoded = decodedArray.first else {
            throw DecodeError.cannotDecodeData
        }
        
        XCTAssertEqual(decoded.orderedItems.count, 3)
        XCTAssertEqual(decoded.deliveryCost, 10)
        XCTAssertEqual(decoded.status, .placed)
        XCTAssertEqual(decoded.placedDateInt, 1715077502)
    }
}
