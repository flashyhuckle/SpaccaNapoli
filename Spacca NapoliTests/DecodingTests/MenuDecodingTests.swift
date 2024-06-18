import XCTest

@testable import Spacca_Napoli

final class MenuDecodingTests: XCTestCase {
    
    func testMenuDecodingFromJSON() throws {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(Menu.self, from: Menu.mockMenuData())
        
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
        
        for (number, category) in decoded.categories.enumerated() {
            XCTAssertEqual(category, categories[number])
        }
        
        XCTAssertEqual(decoded.items.count, 59)
    }
}
