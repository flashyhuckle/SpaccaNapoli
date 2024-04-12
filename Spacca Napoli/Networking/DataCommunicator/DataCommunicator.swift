import Foundation

protocol DataCommunicatorType {
    func place(_ order: Order) async throws
    func loadOrders() async throws -> [Order]
    func refresh(_ order: Order) async throws -> Order
    func observe(_ order: Order, receive: @escaping ((Order) -> Void))
    func stopObserving()
    
    //Separate entity?
    func place(_ reservation: Reservation) async throws
    func loadReservations() async throws -> [Reservation]
}

final class DataCommunicator: DataCommunicatorType {
    private let communicator = FirebaseHandler.shared
}

//Order communication
extension DataCommunicator {
    func place(_ order: Order) async throws {
        try await communicator.placeOrder(order)
    }
    
    func loadOrders() async throws -> [Order] {
        try await communicator.loadOrders()
    }
    
    //replace with observe?
    func refresh(_ order: Order) async throws -> Order {
        try await communicator.refreshOrder(order)
    }
    
    func observe(_ order: Order, receive: @escaping ((Order) -> Void)) {
        communicator.observeOrder(order) { order in
            receive(order)
        }
    }
    
    func stopObserving() {
        communicator.stopObserving()
    }
}

//Reservation communication
extension DataCommunicator {
    func place(_ reservation: Reservation) async throws {
        try await communicator.placeReservation(reservation)
    }
    
    func loadReservations() async throws -> [Reservation] {
        try await communicator.loadReservations()
    }
}
