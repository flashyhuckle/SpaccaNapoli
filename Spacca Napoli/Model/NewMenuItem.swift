import Foundation

struct NewMenu: Codable {
    let categories: [String]
    let menu: [NewMenuItem]
    
    init(
        categories: [String] = [],
        menu: [NewMenuItem] = []
    ) {
        self.categories = categories
        self.menu = menu
    }
}

struct NewMenuItem: Codable, Identifiable {
    let id = UUID()
    
    let name: String
    let price: Int
    let description: String
    let category: String
}
