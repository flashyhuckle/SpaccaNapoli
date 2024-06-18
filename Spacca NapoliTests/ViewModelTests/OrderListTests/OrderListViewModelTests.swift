import XCTest

@testable import Spacca_Napoli

final class OrderListViewModelTests: XCTestCase {
    
    func testOnAppear() async {
        let communicator = OrderCommunicatorMock()
        let vm = OrderListViewModel(communicator: communicator)
        
        await vm.onAppear()
        
        XCTAssertFalse(vm.orders.isEmpty)
    }
    
    func testRefresh() async {
        let communicator = OrderCommunicatorMock()
        let vm = OrderListViewModel(communicator: communicator)
        
        await vm.refresh()
        
        XCTAssertFalse(vm.orders.isEmpty)
    }
}
