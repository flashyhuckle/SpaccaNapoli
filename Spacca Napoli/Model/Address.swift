import Foundation

struct Address: Codable, Equatable {
    var street: String
    var building: String
    var apartment: String
    var city: String
    var postalCode: String
}
