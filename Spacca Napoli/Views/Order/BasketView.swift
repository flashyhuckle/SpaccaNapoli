import SwiftUI

struct BasketView: View {
    @StateObject var vm: BasketViewModel
    
    var body: some View {
        ZStack {
            List {
                ForEach(vm.basket.items, id: \.name) { item in
                    MenuItemView(menuItem: item)
                }.onDelete { indexSet in
                    vm.onDelete(indexSet)
                }
            }
            VStack {
                Spacer()
                NavigationLink {
                    OrderView(vm: OrderViewModel(basket: $vm.basket))
                } label: {
                    VStack {
                        HStack {
                            Image(systemName: "cart")
                            Text(vm.buttonText())
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
}

#Preview {
    BasketView(
        vm: BasketViewModel(
            basket: .constant(
                Basket(
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
                    ]
                )
            )
        )
    )
}
