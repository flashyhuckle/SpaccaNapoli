import SwiftUI

struct MenuView: View {
    @StateObject var vm: MenuViewModel
    
    init(vm: MenuViewModel = MenuViewModel()) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                ForEach(vm.menu.categories, id: \.self) { category in
                    Section(content: {
                        ForEach(vm.menuFilteredBy(category), id: \.name) { item in
                            NavigationLink(destination: {
                                MenuDetailView(vm: MenuDetailViewModel(menuItem: item))
                            }, label: {
                                MenuItemView(menuItem: item)
                            })
                        }
                    }, header: {
                        SectionHeaderView(text: category, color: vm.colorFor(category))
                    })
                }
            }
        }
        .customBackButton(color: .neapolitanGreen)
                
        .onLoad {
            Task {
                await vm.onLoad()
            }
        }
    }
}


#Preview {
    MenuView(vm: MenuViewModel(communicator: MenuCommunicatorMock()))
}
