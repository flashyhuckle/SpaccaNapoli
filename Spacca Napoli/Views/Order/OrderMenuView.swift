import SwiftUI

struct OrderMenuView: View {
    @StateObject var vm: OrderMenuViewModel
    @State private var toBasketViews = [ItemToBasketView]()
    
    @State private var action: Int? = 0
    
    init(
        vm: OrderMenuViewModel = OrderMenuViewModel()
    ) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    ForEach(vm.menu.categories, id: \.self) { category in
                        Section(content: {
                            ForEach(vm.menuFilteredBy(category), id: \.name) { item in
                                MenuItemView(menuItem: item)
                                    .contentShape(Rectangle())
                                    .onTapGesture(coordinateSpace: .global) { location in
                                        vm.tappedOn(item, in: location)
                                    }
                            }
                        }, header: {
                            SectionHeaderView(text: category, color: vm.colorFor(category))
                        })
                    }
                    Section(header: Text("")) {
                        EmptyView()
                    }
                }
                ForEach(vm.toBasketViews, id: \.id) { view in
                    view
                }
            }
            .withBottomNavLink(
                vm.buttonText(),
                icon: "cart",
                color: vm.basketButtonDisabled ? Color.neapolitanGray : Color.neapolitanRed,
                disabled: vm.basketButtonDisabled,
                bounce: vm.animation
            ) {
                BasketView(vm: BasketViewModel(basket: $vm.basket))
            }
        }
        .customBackButton(color: .neapolitanRed)
        .onAppear {
            vm.onAppear()
        }
        .onLoad {
            vm.onLoad()
        }
    }
}



#Preview {
    OrderMenuView(vm: OrderMenuViewModel(communicator: MenuCommunicatorMock()))
}
