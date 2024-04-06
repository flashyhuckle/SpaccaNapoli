enum ApiError: Error {
    case noData
}

import Foundation

final class ApiCaller {
    
    let key = "660fef4eeebf7252862194rbxc97d25"
    let base = "https://geocode.maps.co/search?"
    
    func createURL(from address: Address) -> URL {
        var string = base
        string += "street=" + address.street + "+" + address.building
        string += "&city=" + address.city
        string += "&country=poland"
        string += "&postalcode=" + address.postalCode
        string += "&api_key=" + key
        let url = URL(string: string)!
        return url
    }
    
    func getCoordinates(for address: Address) async throws -> GeocodeResponse {
        let url = createURL(from: address)
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession(configuration: .default).data(for: request)
        
        let decoded = try JSONDecoder().decode([GeocodeResponse].self, from: data)
        
        return decoded[0]
    }
}
