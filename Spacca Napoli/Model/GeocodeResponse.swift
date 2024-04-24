import Foundation

struct GeocodeResponse: Codable {
    let lat: String
    let lon: String
    
    var latDouble: Double {
        Double(lat) ?? 0.0
    }
    
    var lonDouble: Double {
        Double(lon) ?? 0.0
    }
}


