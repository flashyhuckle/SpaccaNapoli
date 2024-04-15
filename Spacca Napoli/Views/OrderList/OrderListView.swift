import SwiftUI

struct OrderListView: View {
    @StateObject var vm: OrderListViewModel
    
    init(
        vm: OrderListViewModel = OrderListViewModel()
    ) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            List {
                if !vm.orders.isEmpty {
                    ForEach($vm.orders) { $order in
                        NavigationLink {
                            OrderDetailView(vm: OrderDetailViewModel(order: $order))
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
            vm.onAppear()
        }
        .refreshable {
            vm.refresh()
        }
    }
}

#Preview {
    OrderListView()
}
