import SwiftUI

struct OrderListView: View {
    
    @State private var orders = [Order]()
    
    var body: some View {
        List {
            ForEach(orders) { order in
                HStack {
                    Text(order.address.street)
                    Text(order.status.rawValue)
                }
            }
        }
        .onAppear(perform: {
            Task {
                orders = try await FirebaseHandler.shared.loadOrders()
            }
        })
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
