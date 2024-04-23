import SwiftUI

struct OrderListView: View {
    @StateObject var vm: OrderListViewModel
    
    init(
        vm: OrderListViewModel = OrderListViewModel()
    ) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        
#warning ("improve look of this view")
        
        NavigationStack {
            Group {
                if vm.orders.isEmpty {
                    EmptyListViewCreator.emptyOrderList()
                } else {
                    ScrollView {
                        ForEach($vm.orders) { $order in
                            NavigationLink {
                                OrderDetailView(vm: OrderDetailViewModel(order: $order))
                            } label: {
                                OrderListSubview(order: order)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Orders")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarColor(.neapolitanRed)
        }
        .navigationTitle("Orders")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarColor(.neapolitanRed)
        
        .customBackButton(color: .neapolitanRed)
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
