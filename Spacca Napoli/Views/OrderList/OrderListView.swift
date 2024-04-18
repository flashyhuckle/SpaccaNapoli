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
            if !vm.orders.isEmpty {
                List {
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
                }
            } else {
                VStack {
                    Image(systemName: "basket")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100)
                        .padding()
                    Text("You have no orders.")
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
