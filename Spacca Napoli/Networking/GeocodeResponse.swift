import Foundation

struct GeocodeResponse: Codable {
    let lat: String
    let lon: String
    
    var latFloat: Double {
        Double(lat) ?? 0.0
    }
    
    var lonFloat: Double {
        Double(lon) ?? 0.0
    }
}


