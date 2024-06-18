import XCTest

@testable import Spacca_Napoli

final class DeliveryCheckerTests: XCTestCase {
    
    private let address = Order.mockOrder().address
    
    func testCheckGoodAddressFreeDelivery() async throws {
        let api = GeocodeAPIMock()
        let distanceCalculator = DistanceCalculatorMockFree()
        let deliveryChecker = DeliveryChecker(api: api, distanceCalculator: distanceCalculator)
        
        let deliveryOption = try await deliveryChecker.check(address)
        
        XCTAssertEqual(deliveryOption, .free)
    }
    
    func testCheckGoodAddressPaidDelivery() async throws {
        let api = GeocodeAPIMock()
        let distanceCalculator = DistanceCalculatorMockPaid()
        let deliveryChecker = DeliveryChecker(api: api, distanceCalculator: distanceCalculator)
        
        let deliveryOption = try await deliveryChecker.check(address)
        
        XCTAssertEqual(deliveryOption, .paid)
    }
    
    func testCheckGoodAddressDeliveryNotPossible() async throws {
        let api = GeocodeAPIMock()
        let distanceCalculator = DistanceCalculatorMockNotPossible()
        let deliveryChecker = DeliveryChecker(api: api, distanceCalculator: distanceCalculator)
        
        let deliveryOption = try await deliveryChecker.check(address)
        
        XCTAssertEqual(deliveryOption, .notPossible)
    }
    
    func testCheckBadAddress() async throws {
        let api = GeocodeAPIMock()
        let distanceCalculator = DistanceCalculatorMockFree()
        let deliveryChecker = DeliveryChecker(api: api, distanceCalculator: distanceCalculator)
        
        api.mockGeocodeResponse = nil
        
        let deliveryOption = try await deliveryChecker.check(address)
        
        XCTAssertEqual(deliveryOption, .notPossible)
    }
}
