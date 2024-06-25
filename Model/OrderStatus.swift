import Foundation

enum OrderStatus: String, Codable, CaseIterable {
    case placed = "placed"
    case accepted = "accepted"
    case inPreparation = "in preparation"
    case ready = "ready for delivery"
    case inDelivery = "in delivery"
    case delivered = "delivered"
    case cancelled = "cancelled"
}
