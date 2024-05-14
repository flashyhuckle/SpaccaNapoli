import Foundation
@testable import Spacca_Napoli

final class GeocodeAPIMock: GeocodeAPIType {
    var mockGeocodeResponse: GeocodeResponse? = GeocodeResponse.mockGeocodeResponse()
    
    func getCoordinates(for address: Address, decoder: JSONDecoder, apiKey: String) async throws -> GeocodeResponse? {
        if let response = mockGeocodeResponse {
            return response
        } else {
            throw DecodeError.cannotDecodeData
        }
    }
}
