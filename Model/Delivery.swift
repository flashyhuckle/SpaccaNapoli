import CoreLocation

@Observable
class Delivery: Codable, Identifiable {
    var id: UUID
    var latDouble: Double
    var lonDouble: Double
    
    var CLLC2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latDouble, longitude: lonDouble)
    }
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _latDouble = "latDouble"
        case _lonDouble = "lonDouble"
    }
    
    init(id: UUID, latDouble: Double, lonDouble: Double) {
        self.id = id
        self.latDouble = latDouble
        self.lonDouble = lonDouble
    }
}


