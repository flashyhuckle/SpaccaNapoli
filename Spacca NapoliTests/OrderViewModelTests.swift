import XCTest

@testable import Spacca_Napoli

final class OrderViewModelTests: XCTestCase {
    
    func testAlertActionButtonPressedOrderPossible() {
        let communicator = OrderCommunicatorMock()
        let vm = OrderViewModel(communicator: communicator, basket: .constant(Basket(items: Order.mockOrder().orderedItems)))
        XCTAssertFalse(vm.basket.items.isEmpty)
        
        vm.isDeliveryPossible = true
        vm.alertActionButtonPressed()
        
        XCTAssertTrue(vm.basket.items.isEmpty)
    }
    
    func testAlertActionButtonPressedOrderNotPossible() {
        let communicator = OrderCommunicatorMock()
        let vm = OrderViewModel(communicator: communicator, basket: .constant(Basket(items: Order.mockOrder().orderedItems)))
        XCTAssertFalse(vm.basket.items.isEmpty)
        
        vm.isDeliveryPossible = false
        vm.alertActionButtonPressed()
        
        XCTAssertFalse(vm.basket.items.isEmpty)
    }
    
    func testButtonPressedDeliveryNotPossible() async {
        let communicator = OrderCommunicatorMock()
        let vm = OrderViewModel(communicator: communicator, basket: .constant(Basket(items: Order.mockOrder().orderedItems)))
        
        await vm.buttonPressed()
        
        XCTAssertTrue(vm.isAlertVisible)
        XCTAssertFalse(communicator.orderPlaced)
    }
    
    func testButtonPressedDeliveryPossible() async {
        let communicator = OrderCommunicatorMock()
        let vm = OrderViewModel(communicator: communicator, basket: .constant(Basket(items: Order.mockOrder().orderedItems)))
        
        vm.isDeliveryPossible = true
        await vm.buttonPressed()
        
        XCTAssertTrue(vm.isAlertVisible)
        XCTAssertTrue(communicator.orderPlaced)
    }
    
    func testAlertTitle() {
        let communicator = OrderCommunicatorMock()
        let vm = OrderViewModel(communicator: communicator, basket: .constant(Basket(items: Order.mockOrder().orderedItems)))
        
        XCTAssertEqual(vm.alertTitle(), OrderAlertTitle.orderNotPossible)
        
        vm.isDeliveryPossible = true
        
        XCTAssertEqual(vm.alertTitle(), OrderAlertTitle.orderPlaced)
    }
    
    func testAlertMessage() {
        let communicator = OrderCommunicatorMock()
        let vm = OrderViewModel(communicator: communicator, basket: .constant(Basket(items: Order.mockOrder().orderedItems)))
        
        XCTAssertEqual(vm.alertMessage(), OrderAlertMessage.orderNotPossible)
        
        vm.isDeliveryPossible = true
        
        XCTAssertEqual(vm.alertMessage(), OrderAlertMessage.orderPlaced)
    }
    
    func testOnAppear() {
        let communicator = OrderCommunicatorMock()
        let vm = OrderViewModel(communicator: communicator, basket: .constant(Basket(items: Order.mockOrder().orderedItems)))
        
        vm.onAppear()
        
        XCTAssertFalse(vm.isDeliveryPossible)
        XCTAssertEqual(vm.deliveryCost, 0)
        
        vm.deliveryPossible = .free
        vm.onAppear()
        
        XCTAssertTrue(vm.isDeliveryPossible)
        XCTAssertEqual(vm.deliveryCost, 0)
        
        vm.deliveryPossible = .paid
        vm.onAppear()
        
        XCTAssertTrue(vm.isDeliveryPossible)
        XCTAssertEqual(vm.deliveryCost, 10)
    }
}
