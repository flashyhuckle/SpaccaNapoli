import XCTest

@testable import Spacca_Napoli

final class DistanceCalculatorTests: XCTestCase { 
    
    func testCalculateDistance() {
        let distanceCalculator = DistanceCalculator()
        let base = GeocodeResponse(lat: "52.235400350000006", lon: "20.982455207962907")
        
        let distance = distanceCalculator.calculateDistance(from: base)
        
        XCTAssertEqual(distance, 1580.217047470842)
    }
}

