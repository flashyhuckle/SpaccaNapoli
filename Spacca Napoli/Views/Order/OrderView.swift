import SwiftUI

enum ButtonState {
    case unchecked
    case possible
    case notPossible
}

struct OrderView: View {
    
    @StateObject var vm: OrderViewModel
    
    @Binding var basketItems: [MenuItem]
    
    @State private var address = Address(
        street: "Chłodna",
        building: "51",
        apartment: "100",
        city: "Warszawa",
        postalCode: "00-867"
    )
    
    @State private var isDeliveryPossible = false
    @State private var deliveryCost = 0
    @State private var buttonState = ButtonState.unchecked
    
    @State private var isAlertVisible = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    ForEach(basketItems, id: \.name) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("\(item.price)")
                        }.padding(.horizontal)
                    }
                }
                VStack {
                    TextField("Street", text: $address.street)
                    TextField("Building", text: $address.building)
                    TextField("Apartment number", text: $address.apartment)
                    TextField("City", text: $address.city)
                    TextField("Postal Code", text: $address.postalCode)
                }
                .padding()
                
                
                Button(action: {
                    checkAddress()
                }, label: {
                    Text(getButtonText())
                        .foregroundStyle(.white)
                        .padding()
                        .background(getButtonColor())
                        .clipShape(Capsule())
                })
                
                HStack {
                    Image(systemName: "scooter")
                    Text("Delivery cost: \(deliveryCost),-")
                }.padding()
                
                HStack {
                    Image(systemName: "basket")
                    Text("Total: \(countPrice()),-")
                }.padding()
                
            }
            VStack {
                Spacer()
                Button(action: {
                    placeOrder()
                }, label: {
                    Text("Place an order")
                .foregroundStyle(.white)
                .padding()
                .background(isDeliveryPossible ? Color(red: 0.8, green: 0, blue: 0) : Color(red: 0.8, green: 0.8, blue: 0.8))
                .clipShape(Capsule())
                })
                .disabled(!isDeliveryPossible)
            }
        }
//        .alert("Your order has been placed!", isPresented: $isAlertVisible) {
//            Button(action: {
//                basketItems.removeAll()
//                NavigationPopper.popToRootView()
//            }, label: {
//                Text("Ok")
//            })
//        }
        .oneButtonAlert(
            title: "Your order has been placed!",
            message: "",
            isPresented: $isAlertVisible,
            action: {
                basketItems.removeAll()
                NavigationPopper.popToRootView()
            }
        )
        .onChange(of: address) {
            isDeliveryPossible = false
            deliveryCost = 0
            buttonState = .unchecked
        }
        .navigationTitle("Your order")
    }
    
    private func countPrice() -> Int {
        var price = deliveryCost
        for item in basketItems {
            price += item.price
        }
        return price
    }
    
    private func getButtonText() -> String {
        switch buttonState {
        case .unchecked:
            "Check address"
        case .possible:
            "Delivery possible"
        case .notPossible:
            "Delivery not possible"
        }
    }
    
    private func getButtonColor() -> Color {
        switch buttonState {
        case .unchecked:
            Color(red: 0, green: 0.4, blue: 0.8)
        case .possible:
            Color(red: 0, green: 0.8, blue: 0.4)
        case .notPossible:
            Color(red: 0.8, green: 0.0, blue: 0.2)
        }
    }
    
    private func checkAddress() {
        Task {
            let coordinates = try await ApiCaller().getCoordinates(for: address)
            let distance = DistanceCalculator.calculateDistance(from: coordinates).rounded()
            if distance < 2000 {
                isDeliveryPossible = true
                buttonState = .possible
            } else if distance < 10000 {
                isDeliveryPossible = true
                deliveryCost = 10
                buttonState = .possible
            } else {
                isDeliveryPossible = false
                buttonState = .notPossible
            }
        }
    }
    
    private func placeOrder() {
        let order = Order(address: address, deliveryCost: deliveryCost, orderedItems: basketItems)
        Task {
            try await FirebaseHandler.shared.placeOrder(order)
            self.isAlertVisible = true
        }
    }
}

#Preview {
    OrderView(vm: OrderViewModel(basketItems: .constant([
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
