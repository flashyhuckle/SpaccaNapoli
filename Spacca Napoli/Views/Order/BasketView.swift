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
                Section(header: Text("")) {
                    EmptyView()
                }
            }
            VStack {
                Spacer()
                ZStack {
                    if vm.orderPossible {
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
                            .background(Color.basketButtonActive)
                            .clipShape(Capsule())
                        }
                    } else {
                        Button(action: {
                            vm.buttonPressed()
                        }, label: {
                            Text("Minimum 2 items")
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.basketButtonDisabled)
                                .clipShape(Capsule())
                        })
                    }
                }
            }
        }
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
