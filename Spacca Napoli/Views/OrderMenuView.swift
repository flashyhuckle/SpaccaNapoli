import SwiftUI

struct OrderMenuView: View {
    
    @StateObject var vm: MenuViewModel
    @State private var basketItems: [MenuItem] = []
    
    init(
        vm: MenuViewModel = MenuViewModel()
    ) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    ForEach(vm.menu.categories, id: \.self) { category in
                        Section(content: {
                            ForEach(vm.menu.items.filter { $0.category == category }) { item in
                                Button(action: {
                                    basketItems.append(item)
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
                        BasketView(basketItems: $basketItems)
                    } label: {
                        HStack {
                            Image(systemName: "cart")
                            Text("Basket: \(countPrice()) PLN")
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color(red: 0.8, green: 0, blue: 0))
                        .clipShape(Capsule())
                    }
                }
            }
        }
        .onAppear(perform: {
            vm.getMenu()
        })
    }
    
    private func countPrice() -> Int {
        var price = 0
        for item in basketItems {
            price += item.price
        }
        return price
    }
}

#Preview {
    MenuView()
}
