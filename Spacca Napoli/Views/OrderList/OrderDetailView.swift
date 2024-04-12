import SwiftUI
import UserNotifications

struct OrderDetailView: View {
    @Binding var order: Order
    
    var body: some View {
        VStack {
            List {
                Section(content: {
                    ForEach(order.orderedItems, id: \.name) { item in
                        MenuItemView(menuItem: item)
                    }
                }, header: {
                    Text("Ordered items")
                        .font(.title)
                        .foregroundStyle(.blue)
                })
            }
            OrderProgressView(status: $order.status)
        }
        .onAppear {
            requestNotifications()
            observeOrder()
        }
        .refreshable {
            refreshOrder()
        }
        .onDisappear {
            stopObserving()
        }
    }
    
    private func refreshOrder() {
        Task {
            let refreshedOrder = try await FirebaseHandler.shared.refreshOrder(order)
            self.order.status = refreshedOrder.status
        }
    }
    
    private func observeOrder() {
            FirebaseHandler.shared.observeOrder(order) { order in
                withAnimation {
                    if self.order.status != order.status {
                        self.order.status = order.status
                        print("updated status")
                    }
                }
            }
    }
    
    private func stopObserving() {
        Task {
            FirebaseHandler.shared.stopObserving()
        }
    }
    
    private func requestNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func displayNotification(_ subtitle: String) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Order status updated"
        content.subtitle = "Your order is \(subtitle)"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)

        center.add(request)
        
        
    }
}

#Preview {
    OrderDetailView(
        order:
            .constant(Order(
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
}
