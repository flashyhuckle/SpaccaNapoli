import XCTest

@testable import Spacca_Napoli

final class MenuViewModelTests: XCTestCase {
    
    func testOnLoad() async {
        let communicator = MenuCommunicatorMock()
        let vm = MenuViewModel(communicator: communicator)
        
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
        
        for category in categories {
            let filteredItems = vm.menuFilteredBy(category)
            for item in filteredItems {
                XCTAssertEqual(item.category, category)
            }
        }
    }
}
