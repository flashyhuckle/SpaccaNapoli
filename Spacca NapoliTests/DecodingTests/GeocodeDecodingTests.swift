import XCTest

@testable import Spacca_Napoli

final class GeocodeDecodingTests: XCTestCase {
    
    func testGeocodeDecodingFromJSON() throws {
        let decoder = JSONDecoder()
        let decodedArray = try decoder.decode([GeocodeResponse].self, from: GeocodeResponse.mockGeocodeData())
        guard let decoded = decodedArray.first else {
            throw DecodeError.cannotDecodeData
        }
        
        XCTAssertEqual(decoded.lat, "52.235400350000006")
        XCTAssertEqual(decoded.lon, "20.982455207962907")
    }
}
