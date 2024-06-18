import XCTest

@testable import Spacca_Napoli

final class OrderMenuViewModelTests: XCTestCase {
    
    func testOnLoad() async {
        let communicator = MenuCommunicatorMock()
        let vm = OrderMenuViewModel(communicator: communicator)
        
        XCTAssertTrue(vm.menu.items.isEmpty)
        XCTAssertTrue(vm.menu.categories.isEmpty)
        
        await vm.onLoad()
        
        sleep(1)
        
        XCTAssertFalse(vm.menu.items.isEmpty)
        XCTAssertFalse(vm.menu.categories.isEmpty)
    }
    
    func testMenuFilteredBy() async {
        let communicator = MenuCommunicatorMock()
        let vm = OrderMenuViewModel(communicator: communicator)
        let categories = [
            "Cold Apetizers and Salads",
            "Hot Apetizers",
            "Pizza Rosa",
            "Pizza Bianca",
            "Pizza Special",
            "Calzoni",
            "Pasta Fresca",
            "Desserts"
        ]
        
        await vm.onLoad()
        
        sleep(1)
        
        for category in categories {
            let filteredItems = vm.menuFilteredBy(category)
            for item in filteredItems {
                XCTAssertEqual(item.category, category)
            }
        }
    }
    
    func testOnAppear() {
        let communicator = MenuCommunicatorMock()
        let vm = OrderMenuViewModel(communicator: communicator)
        
        vm.onAppear()
        
        XCTAssertTrue(vm.basket.items.isEmpty)
        XCTAssertTrue(vm.basketButtonDisabled)
        
        vm.basket.items = Order.mockOrder().orderedItems
        
        vm.onAppear()
        
        XCTAssertFalse(vm.basket.items.isEmpty)
        XCTAssertFalse(vm.basketButtonDisabled)
    }
    
    func testTappedOn() {
        let communicator = MenuCommunicatorMock()
        let vm = OrderMenuViewModel(communicator: communicator)
        
        let testMenuItem = MenuItem(name: "Test item", price: 10, description: "Test item description", category: "Test category")
        
        XCTAssertTrue(vm.basket.items.isEmpty)
        XCTAssertTrue(vm.basketButtonDisabled)
        XCTAssertTrue(vm.toBasketViews.isEmpty)
        XCTAssertFalse(vm.animation)
        
        vm.tappedOn(testMenuItem, in: CGPoint(x: 0, y: 0))
        
        XCTAssertFalse(vm.basket.items.isEmpty)
        XCTAssertFalse(vm.basketButtonDisabled)
        XCTAssertFalse(vm.toBasketViews.isEmpty)
        XCTAssertTrue(vm.animation)
    }
}
