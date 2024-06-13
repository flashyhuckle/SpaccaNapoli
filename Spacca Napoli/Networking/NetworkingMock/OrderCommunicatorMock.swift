import Foundation

final class OrderCommunicatorMock: OrderCommunicatorType {
    var orderPlaced = false
    var orderIsBeingObserved = false
    
    func place(_ order: Order) async throws {
        orderPlaced = true
    }
    
    func loadOrders() async throws -> [Order] {
        Order.mockOrderResponse()
    }
    
    func refresh(_ order: Order) async throws -> Order {
        order.advanceStatus()
    }
    
    func observe(_ order: Order, receive: @escaping ((Order) -> Void)) {
        orderIsBeingObserved = true
        receive(order)
    }
    
    func stopObserving() {
        orderIsBeingObserved = false
    }
}
