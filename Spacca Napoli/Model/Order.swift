import Foundation

@Observable
class Order: Codable, Identifiable {
    var id: UUID
    var status: OrderStatus
    var address: Address
    var deliveryCost: Int
    var orderedItems: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _status = "status"
        case _address = "address"
        case _deliveryCost = "deliveryCost"
        case _orderedItems = "orderedItems"
    }
    
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
