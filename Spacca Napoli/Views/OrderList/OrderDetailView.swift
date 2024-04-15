import SwiftUI
import UserNotifications

struct OrderDetailView: View {
    @StateObject var vm: OrderDetailViewModel
    
    var body: some View {
        VStack {
            List {
                Section(content: {
                    ForEach(vm.order.orderedItems, id: \.name) { item in
                        MenuItemView(menuItem: item)
                    }
                }, header: {
                    Text("Ordered items")
                        .font(.title)
                        .foregroundStyle(.blue)
                })
            }
            OrderProgressView(status: $vm.order.status)
        }
        .onAppear {
            vm.onAppear()
        }
        .refreshable {
            vm.refresh()
        }
        .onDisappear {
            vm.onDisappear()
        }
    }
}

#Preview {
    OrderDetailView(
        vm: OrderDetailViewModel(
            order: .constant(
                Order(
                    address: Address(
                        street: "Towarowa",
                        building: "10",
                        apartment: "100",
                        city: "Warsaw",
                        postalCode: "01-016"
                    ),
                    deliveryCost: 10,
                    orderedItems: [
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
