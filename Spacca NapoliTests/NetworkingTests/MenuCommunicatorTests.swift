import XCTest

@testable import Spacca_Napoli

final class MenuCommunicatorTests: XCTestCase {
    
    func testLoadMenu() async throws {
        let handler = FirebaseHandlerMock()
        let communicator = MenuCommunicator(handler: handler)
        
        let menu = try await communicator.loadMenu()
        
        XCTAssertEqual(menu.items.count, 59)
        XCTAssertEqual(menu.categories.count, 8)
    }
}
