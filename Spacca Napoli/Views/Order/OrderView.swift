import SwiftUI

enum ButtonState {
    case unchecked
    case possible
    case notPossible
}

struct OrderView: View {
    @StateObject var vm: OrderViewModel
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    ForEach(vm.basket.items, id: \.name) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("\(item.price)")
                        }.padding(.horizontal)
                    }
                }
                VStack {
                    TextField("Street", text: $vm.address.street)
                    TextField("Building", text: $vm.address.building)
                    TextField("Apartment number", text: $vm.address.apartment)
                    TextField("City", text: $vm.address.city)
                    TextField("Postal Code", text: $vm.address.postalCode)
                }
                .padding()
                
                
                Button(action: {
                    vm.checkAddress()
                }, label: {
                    Text(vm.getButtonText())
                        .foregroundStyle(.white)
                        .padding()
                        .background(vm.getButtonColor())
                        .clipShape(Capsule())
                })
                
                HStack {
                    Image(systemName: "scooter")
                    Text("Delivery cost: \(vm.deliveryCost),-")
                }.padding()
                
                HStack {
                    Image(systemName: "basket")
                    Text("Total: \(vm.countPrice()),-")
                }.padding()
                
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
        .oneButtonAlert(
            title: "Your order has been placed!",
            message: "",
            isPresented: $vm.isAlertVisible
        ) {
            vm.alertActionButtonPressed()
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
