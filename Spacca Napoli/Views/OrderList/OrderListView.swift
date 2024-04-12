import SwiftUI

struct OrderListView: View {
    @StateObject var vm: OrderListViewModel
    @State private var orders = [Order]()
    
    init(
        vm: OrderListViewModel = OrderListViewModel()
    ) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            List {
                if !orders.isEmpty {
                    ForEach($orders) { $order in
                        NavigationLink {
                            OrderDetailView(order: $order)
                        } label: {
                            HStack {
                                Text(order.address.street)
                                Text(order.status.rawValue)
                            }
                        }
                    }
                } else {
                    Text("You have no order history.")
                }
            }
        }
        .onAppear {
            Task {
                orders = try await FirebaseHandler.shared.loadOrders()
            }
        }
        .refreshable {
            Task {
                orders = try await FirebaseHandler.shared.loadOrders()
            }
        }
    }
}

#Preview {
    OrderListView()
}
