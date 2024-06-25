import SwiftUI

struct OrderListSubview: View {
    @Environment(\.colorScheme) var colorScheme
    
    let order: Order
    var body: some View {
        VStack {
            HStack {
                if let firstItem = order.orderedItems.first {
                    Image(firstItem.name)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.leading)
                }
                
                VStack(alignment: .leading) {
                    Text(order.address.street + " " + order.address.building)
                    Text(order.placedDate.formatted())
                    Text("PLN \(calculatePrice())")
                }
                Spacer()
                
                Text(order.status.rawValue)
                    .frame(maxWidth: 80, maxHeight: 25)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                    .padding()
                    .background(statusColor())
                    .clipShape(Capsule())
                    .padding()
            }
            
            Divider()
        }
        .contentShape(Rectangle())
        .foregroundStyle(colorScheme == .dark ? .white : .black)
    }
    
    private func statusColor() -> Color {
        switch order.status {
        case .placed, .accepted, .inPreparation, .ready, .inDelivery:
                .green
        case .delivered:
                .gray
        case .cancelled:
                .red
        }
    }
    
    private func calculatePrice() -> Int {
        var price = 0
        for item in order.orderedItems {
            price += item.price
        }
        price += order.deliveryCost
        return price
    }
}

#Preview {
    OrderListSubview(
        order: Order(
            status: .cancelled,
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
}
