import Foundation
@testable import Spacca_Napoli

final class FirebaseHandlerMock: FirebaseHandlerType {
    var orderPlaced = false
    
    func placeOrder(_ order: Spacca_Napoli.Order) async throws {
        orderPlaced = true
    }
    
    func loadOrders() async throws -> [Spacca_Napoli.Order] {
        Order.mockOrderResponse()
    }
    
    func refreshOrder(_ order: Spacca_Napoli.Order) async throws -> Spacca_Napoli.Order {
        order.advanceStatus()
    }
    
    var orderIsObserved = false
    
    func observeOrder(_ order: Spacca_Napoli.Order, onReceive: @escaping ((Spacca_Napoli.Order) -> Void)) {
        orderIsObserved = true
        onReceive(order.advanceStatus())
    }
    
    func stopObserving() {
        orderIsObserved = false
    }
    
    var reservationPlaced = false
    
    func placeReservation(_ reservation: Spacca_Napoli.Reservation) async throws {
        reservationPlaced = true
    }
    
    func loadReservations() async throws -> [Spacca_Napoli.Reservation] {
        Reservation.mockReservationResponse()
    }
    
    func loadMenu() async throws -> Spacca_Napoli.Menu {
        Menu.mockMenuResponse()
    }
    
    
}
