import Foundation

@Observable
class Order: Codable, Identifiable {
    var id: UUID
    var placedDateInt: Int
    var status: OrderStatus
    var address: Address
    var deliveryCost: Int
    var orderedItems: [MenuItem]
    
    var placedDate: Date {
        Date(timeIntervalSince1970: TimeInterval(placedDateInt))
    }
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _placedDateInt = "placedDateInt"
        case _status = "status"
        case _address = "address"
        case _deliveryCost = "deliveryCost"
        case _orderedItems = "orderedItems"
    }
    
    init(
        id: UUID = UUID(),
        placedDate: Date = Date(),
        status: OrderStatus = .placed,
        address: Address,
        deliveryCost: Int,
        orderedItems: [MenuItem]
    ) {
        self.id = id
        self.placedDateInt = Int(placedDate.timeIntervalSince1970)
        self.status = status
        self.address = address
        self.deliveryCost = deliveryCost
        self.orderedItems = orderedItems
    }
}

extension Order {
    func advanceStatus() -> Self {
        var order = self
        switch order.status {
        case .placed:
            order.status = .accepted
        case .accepted:
            order.status = .inPreparation
        case .inPreparation:
            order.status = .ready
        case .ready:
            order.status = .inDelivery
        case .inDelivery:
            order.status = .delivered
        case .delivered:
            order.status = .placed
        case .cancelled:
            order.status = .accepted
        }
        return order
    }
}
