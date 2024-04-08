import SwiftUI

struct MenuView: View {
    @StateObject var vm: MenuViewModel
    
    init(vm: MenuViewModel = MenuViewModel()) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            Form {
//                ForEach(Array(Set(vm.newMenu.compactMap{ $0[keyPath: \.category] })), id: \.self) { category in
                ForEach(vm.menu.categories, id: \.self) { category in
                    Section(content: {
                        ForEach(vm.menu.items.filter { $0.category == category }) { item in
                            Button(action: {
                                
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
        }
        .onAppear(perform: {
            vm.getMenu()
        })
    }
}

#Preview {
    MenuView()
}
