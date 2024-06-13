import Foundation
@testable import Spacca_Napoli

final class GeocodeAPIMock: GeocodeAPIType {
    var mockGeocodeResponse: GeocodeResponse? = GeocodeResponse.mockGeocodeResponse()
    var getCoordinatesCalled = false
    
    func getCoordinates(for address: Address, decoder: JSONDecoder, apiKey: String) async throws -> GeocodeResponse? {
        getCoordinatesCalled = true
        if let response = mockGeocodeResponse {
            return response
        } else {
            throw DecodeError.cannotDecodeData
        }
    }
}
