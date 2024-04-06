import SwiftUI

struct BasketView: View {
    @Binding var basketItems: [MenuItem]
    
    var body: some View {
        ZStack {
            List {
                ForEach(basketItems, id: \.name) { item in
                    MenuItemView(menuItem: item)
                }.onDelete(perform: { indexSet in
                    deleteItem(at: indexSet)
                })
            }
            VStack {
                Spacer()
                NavigationLink {
                    OrderView(basketItems: $basketItems)
                } label: {
                    VStack {
                        HStack {
                            Image(systemName: "cart")
                            Text("Basket: \(countPrice()) PLN")
                        }
                        Text("Checkout")
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color(red: 0.8, green: 0, blue: 0))
                    .clipShape(Capsule())
                }
            }
        }
    }
    
    private func countPrice() -> Int {
        var price = 0
        for item in basketItems {
            price += item.price
        }
        return price
    }
    
    private func deleteItem(at index: IndexSet) {
        basketItems.remove(atOffsets: index)
    }
}

//#Preview {
//    BasketView()
//}
