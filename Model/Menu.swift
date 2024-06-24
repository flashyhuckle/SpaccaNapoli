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
