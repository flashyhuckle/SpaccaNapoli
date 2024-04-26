import SwiftUI

struct BasketView: View {
    @StateObject var vm: BasketViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.basket.items, id: \.name) { item in
                    MenuItemView(menuItem: item)
                }.onDelete { indexSet in
                    vm.onDelete(indexSet)
                }
                Section(header: Text("")) {
                    EmptyView()
                }
            }
            .withBottomNavLink(
                vm.buttonText(),
                icon: "cart",
                visible: vm.orderPossible
            ) {
                OrderView(vm: OrderViewModel(basket: $vm.basket))
            }
            .withBottomButton(
                "Minimum 2 items",
                color: .neapolitanGray,
                visible: !vm.orderPossible
            ) {
                vm.buttonPressed()
            }
        }
        .customBackButton(color: .neapolitanRed)
        
        .onAppear {
            vm.onAppear()
        }
        
        .oneButtonAlert(
            title: "Basket too small",
            message: "You need to order at least 2 items",
            isPresented: $vm.alertShowing,
            action: {}
        )
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
