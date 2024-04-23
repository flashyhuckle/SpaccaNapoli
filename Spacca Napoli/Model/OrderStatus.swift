import Foundation

enum OrderStatus: String, Codable, CaseIterable {
    case placed = "placed"
    case accepted = "accepted"
    case inPreparation = "in preparation"
    case inDelivery = "in delivery"
    case delivered = "delivered"
    case cancelled = "cancelled"
}
