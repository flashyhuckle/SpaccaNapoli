import SwiftUI

struct BasketView: View {
    @StateObject var vm: BasketViewModel
    @Binding var basketItems: [MenuItem]
    
    var body: some View {
        ZStack {
            List {
                ForEach(basketItems, id: \.name) { item in
                    MenuItemView(menuItem: item)
                }.onDelete { indexSet in
                    deleteItem(at: indexSet)
                }
            }
            VStack {
                Spacer()
                NavigationLink {
                    OrderView(vm: OrderViewModel(basketItems: $basketItems),basketItems: $basketItems)
                } label: {
                    VStack {
                        HStack {
                            Image(systemName: "cart")
                            Text("Basket: \(countPrice()) PLN")
                        }
                        Text("Checkout")
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color(red: 0.8, green: 0, blue: 0))
                    .clipShape(Capsule())
                }
            }
        }
    }
    
    private func countPrice() -> Int {
        var price = 0
        for item in basketItems {
            price += item.price
        }
        return price
    }
    
    private func deleteItem(at index: IndexSet) {
        basketItems.remove(atOffsets: index)
    }
}

#Preview {
    BasketView(vm: BasketViewModel(basketItems: .constant([
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
    ])),
        basketItems: .constant([
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
    ]))
}
