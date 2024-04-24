import SwiftUI

struct OrderDetailSubview: View {
    var items: [MenuItem]
    var deliveryCost: Int
    
    var body: some View {
        NavigationLink {
            OrderItemListView(items: items)
        } label: {
            OrderPriceListSubview(title: "Items", price: itemsTotal())
        }
        
        OrderPriceListSubview(title: "Delivery", price: deliveryCost)
        OrderPriceListSubview(title: "Total", price: orderTotal())
    }
    
    private func itemsTotal() -> Int {
        var total = 0
        for item in items {
            total += item.price
        }
        return total
    }
    
    private func orderTotal() -> Int {
        var total = 0
        for item in items {
            total += item.price
        }
        total += deliveryCost
        return total
    }
}

#Preview {
    OrderDetailSubview(
        items: [
            MenuItem(
                name: "PROSCIUTTO E MOZZARELLA",
                price: 36,
                description: "parma ham San Daniele D.O.P., buffalo mozzarella D.O.P. Served with focaccia",
                category: "Cold Apetizers and Salads"
            ),
            MenuItem(
                name: "CAPRICCIOSA",
                price: 36,
                description: "tomato sauce, mozzarella fiordilatte, black olives, mushrooms, ham, grana padano cheese D.O.P., basil",
                category: "Pizza Rosa"
            ),
            MenuItem(
                name: "FILETTO",
                price: 36,
                description: "cherry tomatoes, buffalo mozzarella D.O.P., mozzarella fiordilatte, basil, grana padano cheese D.O.P.",
                category: "Pizza Bianca"
            )
        ],
        deliveryCost: 10
    )
}
