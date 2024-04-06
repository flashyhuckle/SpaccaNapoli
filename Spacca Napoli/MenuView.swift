import SwiftUI

struct MenuView: View {
    @StateObject var vm: MenuViewModel
    @State private var basketItems: [MenuItem] = []
    
    init(vm: MenuViewModel = MenuViewModel()) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section(content: {
                        ForEach(vm.menu.coldApetizersAndSalads, id: \.name) { item in
                            Button(action: {
                                basketItems.append(item)
                            }, label: {
                                MenuItemView(menuItem: item)
                                    .foregroundStyle(.black)
                            })
                        }
                    }, header: {
                        Text("Cold Apetizers and Salads")
                            .font(.title)
                            .foregroundStyle(.green)
                    })
                    
                    Section(content: {
                        ForEach(vm.menu.hotApetizers, id: \.name) { item in
                            Button(action: {
                                basketItems.append(item)
                            }, label: {
                                MenuItemView(menuItem: item)
                                    .foregroundStyle(.black)
                            })
                        }
                    }, header: {
                        Text("Hot Apetizers")
                            .font(.title)
                            .foregroundStyle(.red)
                    })
                    
                    Section(content: {
                        ForEach(vm.menu.pizzaRossa, id: \.name) { item in
                            Button(action: {
                                basketItems.append(item)
                            }, label: {
                                MenuItemView(menuItem: item)
                                    .foregroundStyle(.black)
                            })
                        }
                    }, header: {
                        Text("Pizza Rosa")
                            .font(.title)
                            .foregroundStyle(.red)
                    })
                    
                    Section(content: {
                        ForEach(vm.menu.pizzaBianca, id: \.name) { item in
                            Button(action: {
                                basketItems.append(item)
                            }, label: {
                                MenuItemView(menuItem: item)
                            })
                        }
                    }, header: {
                        Text("Pizza Bianca")
                            .font(.title)
                            .foregroundStyle(.gray)
                    })
                    
                    Section(content: {
                        ForEach(vm.menu.pizzaSpecial, id: \.name) { item in
                            Button(action: {
                                basketItems.append(item)
                            }, label: {
                                MenuItemView(menuItem: item)
                            })
                        }
                    }, header: {
                        Text("Pizza Special")
                            .font(.title)
                            .foregroundStyle(.yellow)
                    })
                    
                    Section(content: {
                        ForEach(vm.menu.calzoni, id: \.name) { item in
                            Button(action: {
                                basketItems.append(item)
                            }, label: {
                                MenuItemView(menuItem: item)
                            })
                        }
                    }, header: {
                        Text("Calzoni")
                            .font(.title)
                            .foregroundStyle(.brown)
                    })
                    
                    Section(content: {
                        ForEach(vm.menu.pastaFresca, id: \.name) { item in
                            Button(action: {
                                basketItems.append(item)
                            }, label: {
                                MenuItemView(menuItem: item)
                            })
                        }
                    }, header: {
                        Text("Pasta fresca")
                            .font(.title)
                            .foregroundStyle(.brown)
                    })
                    
                    Section(content: {
                        ForEach(vm.menu.desserts, id: \.name) { item in
                            Button(action: {
                                basketItems.append(item)
                            }, label: {
                                MenuItemView(menuItem: item)
                            })
                        }
                    }, header: {
                        Text("Desserts")
                            .font(.title)
                            .foregroundStyle(.brown)
                    })
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
