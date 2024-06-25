import SwiftUI
import UserNotifications

struct OrderDetailView: View {
    @StateObject var vm: OrderDetailViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(content: {
                        OrderDetailSubview(items: vm.order.orderedItems, deliveryCost: vm.order.deliveryCost)
                    }, header: {
                        SectionHeaderView(text: "Order", color: .neapolitanRed)
                    })
                    
                    Section(content: {
                        NavigationLink {
                            AddressDetailView(vm: AddressDetailViewModel(order: vm.order))
                        } label: {
                            AddressView(address: vm.order.address)
                        }
                    }, header: {
                        SectionHeaderView(text: "Delivery", color: .neapolitanRed)
                    })
                    
                    Section(content: {
                        OrderProgressView(status: $vm.order.status)
                    }, header: {
                        SectionHeaderView(text: "Status", color: .neapolitanRed)
                    })
                }
            }
            .withBottomButton("Add to widget", color: .gray) {
                vm.widgetButtonPressed()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .customBackButton(color: .neapolitanRed)
        
        .onAppear {
            vm.onAppear()
        }
        .refreshable {
            Task {
                await vm.refresh()
            }
        }
        .onDisappear {
            vm.onDisappear()
        }
    }
}


#Preview {
    PreviewBindingWrapper(wrappedBinding: Order.mockOrder()) { orderBinding in
        OrderDetailView(vm: OrderDetailViewModel(order: orderBinding, communicator: OrderCommunicatorMock()))
    }
}
