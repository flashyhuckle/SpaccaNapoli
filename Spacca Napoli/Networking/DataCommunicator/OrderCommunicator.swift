import Foundation

protocol OrderCommunicatorType {
    func place(_ order: Order) async throws
    func loadOrders() async throws -> [Order]
    func refresh(_ order: Order) async throws -> Order
    func observe(_ order: Order, receive: @escaping ((Order) -> Void))
    func stopObserving()
}

final class OrderCommunicator {
    private let handler: FirebaseHandlerType
    
    init(
        handler: FirebaseHandlerType = FirebaseHandler.shared
    ) {
        self.handler = handler
    }
}

extension OrderCommunicator: OrderCommunicatorType {
    func place(_ order: Order) async throws {
        try await handler.placeOrder(order)
    }
    
    func loadOrders() async throws -> [Order] {
        try await handler.loadOrders()
    }
    
    func refresh(_ order: Order) async throws -> Order {
        try await handler.refreshOrder(order)
    }
    
    func observe(_ order: Order, receive: @escaping ((Order) -> Void)) {
        handler.observeOrder(order) { order in
            receive(order)
        }
    }
    
    func stopObserving() {
        handler.stopObservingOrder()
    }
}
