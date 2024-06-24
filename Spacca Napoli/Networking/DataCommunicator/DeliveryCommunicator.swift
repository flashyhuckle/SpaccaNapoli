import Foundation

protocol DeliveryCommunicatorType {
    func observe(_ order: Order, receive: @escaping ((Delivery) -> Void))
    func stopObserving()
}

final class DeliveryCommunicator {
    private let handler: FirebaseHandlerType
    
    init(handler: FirebaseHandlerType = FirebaseHandler.shared) {
        self.handler = handler
    }
}

extension DeliveryCommunicator: DeliveryCommunicatorType {
    func observe(_ order: Order, receive: @escaping ((Delivery) -> Void)) {
        handler.observeDelivery(order) { delivery in
            receive(delivery)
        }
    }
    
    func stopObserving() {
        handler.stopObservingDelivery()
    }
}
