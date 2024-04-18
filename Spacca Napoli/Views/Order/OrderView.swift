import SwiftUI

enum ButtonState {
    case unchecked
    case possible
    case notPossible
}

enum Field {
    case street, building, apartment, city, postal
}

struct OrderView: View {
    @StateObject var vm: OrderViewModel
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(vm.basket.items, id: \.name) { item in
                            HStack {
                                Text(item.name)
                                Spacer()
                                Text("\(item.price)")
                            }.padding(.horizontal)
                        }
                    }
                }
                VStack {
                    
                    TextField("Street", text: $vm.address.street)
                        .focused($focusedField, equals: .street)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .building
                        }
                    
                    TextField("Building", text: $vm.address.building)
                        .focused($focusedField, equals: .building)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .apartment
                        }
                    
                    TextField("Apartment number", text: $vm.address.apartment)
                        .focused($focusedField, equals: .apartment)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .city
                        }
                    
                    TextField("City", text: $vm.address.city)
                        .focused($focusedField, equals: .city)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .postal
                        }
                    
                    TextField("Postal Code", text: $vm.address.postalCode)
                        .focused($focusedField, equals: .postal)
                        .submitLabel(.go)
                        .onSubmit {
                            vm.checkAddress()
                            focusedField = nil
                        }
                }
                .padding()
                
                Button(action: {
                    vm.checkAddress()
                    focusedField = nil
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
