import Foundation

struct Order: Codable, Identifiable {
    let id: UUID
    var status: OrderStatus
    var address: Address
    var deliveryCost: Int
    var orderedItems: [MenuItem]
    
    init(
        id: UUID = UUID(),
        status: OrderStatus = .placed,
        address: Address,
        deliveryCost: Int,
        orderedItems: [MenuItem]
    ) {
        self.id = id
        self.status = status
        self.address = address
        self.deliveryCost = deliveryCost
        self.orderedItems = orderedItems
    }
}

enum OrderStatus: String, Codable {
    case placed
    case accepted
    case inPreparation
    case inDelivery
    case delivered
    case cancelled
}

extension UUID {
    func string() -> String {
        "\(self)"
    }
}

struct Address: Codable {
    let street: String
    let building: String
    let city: String
    let postalCode: String
}
