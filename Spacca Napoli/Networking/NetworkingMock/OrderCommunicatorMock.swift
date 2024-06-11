import Foundation

final class OrderCommunicatorMock: OrderCommunicatorType {
    var orderPlaced = false
    
    func place(_ order: Order) async throws {
        orderPlaced = true
    }
    
    func loadOrders() async throws -> [Order] {
        Order.mockOrderResponse()
    }
    
    func refresh(_ order: Order) async throws -> Order {
        order
    }
    
    func observe(_ order: Order, receive: @escaping ((Order) -> Void)) {
        receive(order)
    }
    
    func stopObserving() {
        print("stopped observing")
    }
}
