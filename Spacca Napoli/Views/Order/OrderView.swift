import SwiftUI

struct OrderView: View {
    @StateObject var vm: OrderViewModel
    
    var body: some View {
        
        NavigationStack {
            ZStack {
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
                            AddressView(address: vm.address, isValidated: $vm.isDeliveryPossible)
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
                VStack {
                    Spacer()
                    Button(action: {
                        vm.placeOrder()
                    }, label: {
                        Text("Place an order")
                            .foregroundStyle(.white)
                            .padding()
                            .background(vm.isDeliveryPossible ? Color(red: 0.8, green: 0, blue: 0) : Color(red: 0.8, green: 0.8, blue: 0.8))
                            .clipShape(Capsule())
                    })
                    .disabled(!vm.isDeliveryPossible)
                }
            }
        }
        .contentShape(Rectangle())
        
        .oneButtonAlert(
            title: "Your order has been placed!",
            message: "",
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
