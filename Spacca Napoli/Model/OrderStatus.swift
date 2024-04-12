import Foundation

enum OrderStatus: String, Codable {
    case placed
    case accepted
    case inPreparation
    case inDelivery
    case delivered
    case cancelled
}
