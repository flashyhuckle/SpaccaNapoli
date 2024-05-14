import Foundation

class Order2: Codable, Identifiable {
    var id: UUID
    var placedDateInt: Int
    var status: OrderStatus
    var address: Address
    var deliveryCost: Int
    var orderedItems: [MenuItem]
    
    var placedDate: Date {
        Date(timeIntervalSince1970: TimeInterval(placedDateInt))
    }
}

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
