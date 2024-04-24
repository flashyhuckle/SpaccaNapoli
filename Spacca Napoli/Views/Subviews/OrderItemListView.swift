import SwiftUI

struct OrderItemListView: View {
    let items: [MenuItem]
    var body: some View {
        List {
            ForEach(items, id: \.name) { item in
                MenuItemView(menuItem: item)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .customBackButton(color: .neapolitanRed)
    }
}

#Preview {
    OrderItemListView(items: [
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
    ])
}
