import SwiftUI
import UserNotifications

struct OrderDetailView: View {
    @StateObject var vm: OrderDetailViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(content: {
                        OrderDetailSubview(items: vm.order.orderedItems, deliveryCost: vm.order.deliveryCost)
//                        NavigationLink {
//                            OrderItemListView(items: vm.order.orderedItems)
//                        } label: {
//                            OrderPriceListSubview(title: "Items", price: vm.itemsTotal())
//                        }
//                        
//                        OrderPriceListSubview(title: "Delivery", price: vm.order.deliveryCost)
//                        OrderPriceListSubview(title: "Total", price: vm.orderTotal())
                    }, header: {
                        SectionHeaderView(text: "Order", color: .neapolitanRed)
                    })
                    
                    Section(content: {
                        NavigationLink {
                            AddressDetailView(vm: AddressDetailViewModel(address: vm.order.address))
                        } label: {
                            AddressView(address: vm.order.address)
                        }
                    }, header: {
                        SectionHeaderView(text: "Delivery", color: .neapolitanRed)
                    })
                    
                    Section(content: {
                        OrderProgressView(status: $vm.order.status)
                    }, header: {
                        SectionHeaderView(text: "Status", color: .neapolitanRed)
                    })
                }
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .customBackButton(color: .neapolitanRed)
        
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
                    status: .inDelivery,
                    address: Address(
                        street: "Chłodna",
                        building: "51",
                        apartment: "100",
                        city: "Warszawa",
                        postalCode: "00-867"
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
