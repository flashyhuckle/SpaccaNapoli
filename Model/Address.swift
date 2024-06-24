import Foundation

struct Address: Codable, Equatable {
    var street: String
    var building: String
    var apartment: String
    var city: String
    var postalCode: String
}

extension Address {
    var queryItems: [String: String] {
        var query = [String: String]()
        query["street"] = self.street + "+" + self.building
        query["city"] = self.city
        query["postalCode"] = self.postalCode
        return query
    }
}
