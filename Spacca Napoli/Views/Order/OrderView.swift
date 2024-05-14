import SwiftUI

struct OrderView: View {
    @StateObject var vm: OrderViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        AddressTextfieldView(
                            vm: AddressTextfieldViewModel(
                                address: $vm.address,
                                deliveryPossible: $vm.deliveryPossible
                            )
                        )
                    } label: {
                        AddressView(address: vm.address)
                            .indicated($vm.isDeliveryPossible)
                    }
                    
                } header: {
                    SectionHeaderView(text: "Address", color: .neapolitanGreen)
                }
                
                Section {
                    OrderDetailSubview(items: vm.basket.items, deliveryCost: vm.deliveryCost)
                } header: {
                    SectionHeaderView(text: "Summary", color: .neapolitanRed)
                }
            }
            .withBottomButton(
                "Place an order",
                color: vm.isDeliveryPossible ? .neapolitanRed : .neapolitanGray) {
                    vm.buttonPressed()
                }
        }
        .contentShape(Rectangle())
        .customBackButton(color: .neapolitanRed)
        
        .oneButtonAlert(
            title: vm.alertTitle(),
            message: vm.alertMessage(),
            isPresented: $vm.isAlertVisible
        ) {
            vm.alertActionButtonPressed()
        }
        
        .onAppear {
            vm.onAppear()
        }
        
        .navigationTitle("Your order")
    }
}

#Preview {
    PreviewBindingWrapper(wrappedBinding: Basket(items: Order.mockOrder().orderedItems)) { basketBinding in
        OrderView(vm: OrderViewModel(communicator: OrderCommunicatorMock(), basket: basketBinding, address: Order.mockOrder().address))
    }
}
