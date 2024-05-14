import CoreLocation

struct GeocodeResponse: Codable {
    let lat: String
    let lon: String
    
    var latDouble: Double {
        Double(lat) ?? 0.0
    }
    
    var lonDouble: Double {
        Double(lon) ?? 0.0
    }
    
    var CLLC2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latDouble, longitude: lonDouble)
    }
}


