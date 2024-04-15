import SwiftUI

struct OrderMenuView: View {
    @StateObject var vm: OrderMenuViewModel
    
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
                            ForEach(vm.menu.items.filter { $0.category == category }, id: \.name) { item in
                                Button(action: {
                                    vm.tappedOn(item)
                                }, label: {
                                    MenuItemView(menuItem: item)
                                })
                            }
                        }, header: {
                            Text(category)
                                .font(.title)
                                .foregroundStyle(vm.colours[category] ?? .blue)
                        })
                    }
                }
                
                VStack {
                    Spacer()
                    NavigationLink {
                        BasketView(vm: BasketViewModel(basket: $vm.basket))
                    } label: {
                        HStack {
                            Image(systemName: "cart")
                            Text(vm.buttonText())
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color(red: 0.8, green: 0, blue: 0))
                        .clipShape(Capsule())
                    }
                }
            }
        }
        .onAppear {
            vm.onAppear()
        }
    }
}

#Preview {
    OrderMenuView()
}
