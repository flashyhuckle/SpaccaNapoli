import SwiftUI

struct OrderListView: View {
    @StateObject var vm: OrderListViewModel
    
    init(
        vm: OrderListViewModel = OrderListViewModel()
    ) {
        _vm = StateObject(wrappedValue: vm)
        navigationBarColor(.neapolitanRed)
    }
    
    var body: some View {
        
        NavigationStack {
            if vm.isFirstLoading {
                EmptyListViewCreator.loadingOrderList()
            } else {
                if vm.orders.isEmpty {
                    EmptyListViewCreator.emptyOrderList()
                } else {
                    ScrollView {
                        ForEach($vm.orders, id: \.placedDate) { $order in
                            NavigationLink {
                                OrderDetailView(vm: OrderDetailViewModel(order: $order))
                            } label: {
                                OrderListSubview(order: order)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Orders")
        .navigationBarTitleDisplayMode(.large)
        
        .customBackButton(color: .neapolitanRed)
        
        .onAppear {
            Task {
                await vm.onAppear()
            }
        }
        .refreshable {
            Task {
                await vm.refresh()
            }
        }
    }
}



#Preview {
    OrderListView(vm: OrderListViewModel(communicator: OrderCommunicatorMock()))
}
