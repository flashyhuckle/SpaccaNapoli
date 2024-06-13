import XCTest
import SwiftUI

@testable import Spacca_Napoli

final class OrderDetailViewModelTests: XCTestCase {
    
    func testOnAppear() {
        let communicator = OrderCommunicatorMock()
        var order = Order.mockOrder()
        let bindingOrder = Binding(get: {order}, set: {order = $0})
        let vm = OrderDetailViewModel(order: bindingOrder, communicator: communicator)
        
        XCTAssertFalse(communicator.orderIsBeingObserved)
        
        vm.onAppear()
        
        XCTAssertTrue(communicator.orderIsBeingObserved)
    }
    
    func testRefresh() async {
        let communicator = OrderCommunicatorMock()
        var order = Order.mockOrder()
        let bindingOrder = Binding(get: {order}, set: {order = $0})
        let vm = OrderDetailViewModel(order: bindingOrder, communicator: communicator)
        
        let tempOrderStatus = order.status
        
        await vm.refresh()
        
        XCTAssertNotEqual(order.status, tempOrderStatus)
    }
    
    func testOnDisappear() {
        let communicator = OrderCommunicatorMock()
        var order = Order.mockOrder()
        let bindingOrder = Binding(get: {order}, set: {order = $0})
        let vm = OrderDetailViewModel(order: bindingOrder, communicator: communicator)
        
        communicator.orderIsBeingObserved = true
        
        XCTAssertTrue(communicator.orderIsBeingObserved)
        
        vm.onDisappear()
        
        XCTAssertFalse(communicator.orderIsBeingObserved)
    }
}
