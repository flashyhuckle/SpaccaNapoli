import SwiftUI

struct OrderView: View {
    @StateObject var vm: OrderViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        AddressTextfieldView(
                            vm: AddressTextfieldViewModel(
                                address: $vm.address,
                                deliveryPossible: $vm.deliveryPossible
                            )
                        )
                    } label: {
                        AddressView(address: vm.address)
                            .indicated($vm.isDeliveryPossible)
                    }
                    
                } header: {
                    SectionHeaderView(text: "Address", color: .neapolitanGreen)
                }
                
                Section {
                    OrderDetailSubview(items: vm.basket.items, deliveryCost: vm.deliveryCost)
                } header: {
                    SectionHeaderView(text: "Summary", color: .neapolitanRed)
                }
            }
            .withBottomButton(
                "Place an order",
                color: vm.isDeliveryPossible ? .neapolitanRed : .neapolitanGray) {
                    vm.buttonPressed()
                }
        }
        .contentShape(Rectangle())
        .customBackButton(color: .neapolitanRed)
        
        .oneButtonAlert(
            title: vm.alertTitle(),
            message: vm.alertMessage(),
            isPresented: $vm.isAlertVisible
        ) {
            vm.alertActionButtonPressed()
        }
        
        .onAppear {
            vm.onAppear()
        }
        
        .navigationTitle("Your order")
    }
}

#Preview {
    OrderView(
        vm: OrderViewModel(
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
