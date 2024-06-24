import Foundation

protocol BasketType {
    func addToBasket(_ item: MenuItem)
    func getItems() -> [MenuItem]
    func remove(at: IndexSet)
    func removeAllItems()
}

@Observable
class Basket: BasketType {
    var items: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case _items = "items"
    }
    
    init(
        items: [MenuItem] = []
    ) {
        self.items = items
    }
    
    func addToBasket(_ item: MenuItem) {
        items.append(item)
    }
    
    func getItems() -> [MenuItem] {
        items
    }
    
    func removeAllItems() {
        items.removeAll()
    }
    
    func remove(at: IndexSet) {
        items.remove(atOffsets: at)
    }
}
