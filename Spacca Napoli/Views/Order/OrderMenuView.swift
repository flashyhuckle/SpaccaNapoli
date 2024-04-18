import SwiftUI

struct OrderMenuView: View {
    @StateObject var vm: OrderMenuViewModel
    @State private var toBasketViews = [ItemToBasketView]()
    
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
                                        vm.tappedOn(item)
                                        spawnView(item: item, location: location)
                                    }
                            }
                        }, header: {
                            Text(category)
                                .font(.title)
                                .foregroundStyle(vm.colours[category] ?? .blue)
                        })
                    }
                    Section(header: Text("")) {
                        EmptyView()
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
                        .background(vm.basketButtonDisabled ? Color.basketButtonDisabled : Color.basketButtonActive)
                        .clipShape(Capsule())
                        .scaleEffect(vm.animation ? CGSize(width: 1.2, height: 1.2) : CGSize(width: 1, height: 1))
                    }.disabled(vm.basketButtonDisabled)
                }
                ForEach(toBasketViews, id: \.id) { view in
                    view
                }
            }
        }
        .onAppear {
            vm.onAppear()
        }
    }
    
    func spawnView(item: MenuItem, location: CGPoint) {
        let view = ItemToBasketView(imageName: item.name, offset: location)
        toBasketViews.append(view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation {
                _ = self.toBasketViews.remove(at: 0)
            }
        }
    }
}

struct ItemToBasketView: View {
    let id = UUID()
    let imageName: String
    let offset: CGPoint
    @State private var animate = false
    
    var body: some View {
        GeometryReader { proxy in
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 80)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .scaleEffect(animate ? CGSize(width: 0.1, height: 0.1) : CGSize(width: 1.0, height: 1.0))
                .rotationEffect(.degrees(animate ? 90 : 0))
                .position(x: animate ? proxy.size.width / 2 : offset.x , y: animate ? proxy.size.height - 50 : (offset.y - 80))
                .animation(.easeIn(duration: 0.4), value: animate)
            
                .onAppear {
                    animate = true
                }
        }
    }
}

#Preview {
    OrderMenuView()
}
