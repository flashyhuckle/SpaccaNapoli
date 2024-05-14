import SwiftUI

struct BasketView: View {
    @StateObject var vm: BasketViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.basket.items, id: \.name) { item in
                    MenuItemView(menuItem: item)
                }.onDelete { indexSet in
                    vm.onDelete(indexSet)
                }
                Section(header: Text("")) {
                    EmptyView()
                }
            }
            .withBottomNavLink(
                vm.buttonText(),
                icon: "cart",
                visible: vm.orderPossible
            ) {
                OrderView(vm: OrderViewModel(basket: $vm.basket))
            }
            .withBottomButton(
                "Minimum 2 items",
                color: .neapolitanGray,
                visible: !vm.orderPossible
            ) {
                vm.buttonPressed()
            }
        }
        .customBackButton(color: .neapolitanRed)
        
        .onAppear {
            vm.onAppear()
        }
        
        .oneButtonAlert(
            title: "Basket too small",
            message: "You need to order at least 2 items",
            isPresented: $vm.alertShowing,
            action: {}
        )
    }
}

#Preview {
    PreviewBindingWrapper(wrappedBinding: Basket(items: Order.mockOrder().orderedItems)) { basketBinding in
        BasketView(vm: BasketViewModel(basket: basketBinding))
    }
}
