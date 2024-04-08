import Foundation

struct Menu: Codable {
    let categories: [String]
    let items: [MenuItem]
    
    init(
        categories: [String] = [],
        items: [MenuItem] = []
    ) {
        self.categories = categories
        self.items = items
    }
}

struct MenuItem: Codable, Identifiable {
    let id = UUID()
    
    let name: String
    let price: Int
    let description: String
    let category: String
}
