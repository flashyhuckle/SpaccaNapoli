import Foundation

protocol GeocodeAPIType {
    func getCoordinates(
        for address: Address,
        decoder: JSONDecoder,
        apiKey: String
    ) async throws -> GeocodeResponse?
}

extension GeocodeAPIType {
    func getCoordinates(
        for address: Address,
        decoder: JSONDecoder = JSONDecoder(),
        apiKey: String = Bundle.main.apiKey
    ) async throws -> GeocodeResponse? {
        try await getCoordinates(for: address, decoder: decoder, apiKey: apiKey)
    }
}

class GeocodeAPI: GeocodeAPIType {
    private let handler: URLSessionHandlerType
    
    init(
        handler: URLSessionHandlerType = URLSessionHandler()
    ) {
        self.handler = handler
    }
    
    func getCoordinates(
        for address: Address,
        decoder: JSONDecoder,
        apiKey: String
    ) async throws -> GeocodeResponse? {
        let query = [
            "street": (address.street + "+" + address.building),
            "city": address.city,
            "postalCode": address.postalCode,
            "api_key": apiKey
        ]
        
        let data = try await handler.performRequest(query: query)
        
        do {
            let decoded = try decoder.decode([GeocodeResponse].self, from: data)
            return decoded.first
        } catch {
            throw DecodeError.cannotDecodeData
        }
    }
}

