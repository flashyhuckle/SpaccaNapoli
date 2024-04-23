import Foundation

@Observable
class Order: Codable, Identifiable {
    var id: UUID
    var placedDate: Date
    var status: OrderStatus
    var address: Address
    var deliveryCost: Int
    var orderedItems: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _placedDate = "placedDate"
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
        self.placedDate = placedDate
        self.status = status
        self.address = address
        self.deliveryCost = deliveryCost
        self.orderedItems = orderedItems
    }
}
