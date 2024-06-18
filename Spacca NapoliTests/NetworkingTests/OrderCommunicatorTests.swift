import XCTest

@testable import Spacca_Napoli

final class OrderCommunicatorTests: XCTestCase {
    
    func testPlaceOrder() async throws {
        let handler = FirebaseHandlerMock()
        let communicator = OrderCommunicator(handler: handler)
        
        let order = Order.mockOrder()
        
        try await communicator.place(order)
        
        XCTAssertTrue(handler.orderPlaced)
    }
    
    func testLoadOrders() async throws {
        let handler = FirebaseHandlerMock()
        let communicator = OrderCommunicator(handler: handler)
        
        let orders = try await communicator.loadOrders()
        
        XCTAssertFalse(orders.isEmpty)
    }
    
    func testRefreshOrder() async throws {
        let handler = FirebaseHandlerMock()
        let communicator = OrderCommunicator(handler: handler)
        
        let order = Order.mockOrder()
        let tempOrderStatus = order.status
        
        let refreshed = try await communicator.refresh(order)
        
        XCTAssertNotEqual(tempOrderStatus, refreshed.status)
    }
    
    func testObserveOrderAndStopObserving() {
        let handler = FirebaseHandlerMock()
        let communicator = OrderCommunicator(handler: handler)
        
        let order = Order.mockOrder()
        let tempOrderStatus = order.status
        
        XCTAssertFalse(handler.orderIsObserved)
        
        communicator.observe(order) { refreshed in
            XCTAssertNotEqual(tempOrderStatus, refreshed.status)
        }
        XCTAssertTrue(handler.orderIsObserved)
        
        communicator.stopObserving()
        XCTAssertFalse(handler.orderIsObserved)
        
    }
}
